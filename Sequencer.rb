$core = self
use_timing_guarantees true

def show_must_go_on!
  in_thread { track_1 }
  in_thread { track_2 }
  in_thread { track_3 }
  in_thread { track_4 }
end

def track_1 # high hat
  seq = Sequence.new(%(
    v900000 | ______ | v60 p20 | v40 p40 r3
    v80 p50 | v20 r2 |  _____  | v30 p10 r4
  ), note: :G2)
  infinitely do
    with_bpm 120 do
      seq.play
    end
  end
end

def track_2 # kick
  seq = [
    Sequence.new('.|_|v10 p50 r3|v88|_', note: :E2),
    Sequence.new('_|v30 p40 r2|v5 p15 r4|v40|v88|_|v10 p15 r3|_', note: :E2)
  ]
  infinitely do
    seq[0].play(4, pendulum: true)
    seq[1].play
  end
end

def track_3 # ride
  seq = Sequence.new(
    (0..0.8).step(0.02).lazy.map { |v| { velocity: v } },
    note: :Ds3
  )
  infinitely do
    seq.play(pendulum: true)
  end
end

def track_4 # keys
  infinitely do
    notes    = scale(:A3, :phrygian).to_a
    max_note = notes.max.to_f
    seq      = notes.shuffle.each_with_index.map { |n, i|
      {
        note:        n,
        velocity:    (i + 1) / notes.size.to_f,
        repeats:     [1, 2, 3].choose,
        probability: 0.7 + 0.3 * n / max_note,
      }
    }
    with_bpm 30 do
      Sequence.new(seq, channel: 2).play
    end
  end
end

def track_parse_example
  Sequence.new(%(
    :B2 v40 p60 r2 | :B3 | _ | KABOOM
    r16            |_____| . | !!!!!!
  ), note: :Ds3).tap { |s| puts s.to_s }.play
end

def infinitely
  (0..Float::INFINITY).each do
    yield
  end
end


class Step

  DURATION = 0.25.to_f # in beats

  attr_accessor :note, :channel, :velocity, :probability, :repeats

  # @param note [Symbol, Integer] MIDI parameter; :A..:G, :A2 - with octave, :Fs3 - sharp, :Eb3 - flat
  # @see http://www.sonic-pi.net/tutorial.html#section-2-1 Traditional Note Names
  # @param channel [Integer] MIDI channel for notes output
  # @see http://www.sonic-pi.net/tutorial.html#section-11-2 Selecting a MIDI device
  # @param velocity [Float, Integer] MIDI parameter; 0..1
  # @param probability [Float, Integer] 1 - plays each time, 0 - never plays, 0.5 - Kernel.rand decides
  # @param repeats [Integer] Number of times to play the note per Step::DURATION
  def initialize(note: nil, channel: nil, velocity: 1, probability: 1, repeats: 1)
    self.note        = note || :G2
    self.channel     = channel.to_i || 1
    self.repeats     = repeats.to_i.abs
    self.velocity    =
      if velocity > 1
        1
      elsif velocity < 0
        0
      else
        velocity
      end
    self.probability =
      if probability > 1
        1
      elsif probability < 0
        0
      else
        probability
      end
  end

  def play
    if probability > 0 && repeats > 0 && rand <= probability
      step = DURATION / repeats
      repeats.times do
        $core.midi note, velocity_f: velocity, sustain: step, channel: channel
        $core.sleep step
      end
    else
      $core.sleep DURATION
    end
  end

  def to_s
    if probability.zero?
      '_'
    else
      result = ":#{note}".dup
      result << " v#{(velocity * 100).to_i}" if velocity < 1
      result << " p#{(probability * 100).to_i}" if probability < 1
      result << " r#{repeats}" if repeats > 1
      result
    end
  end
end


class Sequence

  attr_accessor :steps

  # @param pattern [String] Defines notes sequence
  #   Syntax: <step> | <step> | <step> | ...
  #   Any number of lines and spaces are allowed.
  #   Each <step> can have:
  #   - any number of ___ for an interval of silence
  #   - or any combination of params:
  #     - note: :A2 | :G3 | ...
  #     - velocity: v1 | v50 | v100 | ...
  #     - probability: p1 | p50 | p100 | ...
  #     - repeats: r1 | r4 | r16 | ...
  #   - or anything else to use all the defaults
  # @example Multiline pattern
  #   :B2 v40 p60 r2 | :B3 | _ | KABOOM
  #   r16            |_____| . | !!!!!!
  # @see Step.initialize
  # @return [Array<Hash>] Parsed steps
  def self.parse(pattern)
    normalized = pattern.tr("\n", '|').split('|').reject { |s| s.strip.empty? }
    normalized.map do |params|
      params.split(' ').each_with_object({}) do |param, step|
        if param.squeeze == '_'
          step[:probability] = 0
        else
          prefix = param[0]
          value  = param[1..-1]
          case prefix
          when ':'
            step[:note] = value.to_sym
          when 'v'
            step[:velocity] = value.to_i / 100.0
          when 'p'
            step[:probability] = value.to_i / 100.0
          when 'r'
            step[:repeats] = value.to_i
          end
        end
      end
    end
  end

  # @param pattern [String, Enumerable<Hash>] Defines notes sequence
  # @see Sequence.parse If pattern is a String
  # @see Step.initialize If pattern is an Enumerable<Hash>
  # @param note [Symbol, Integer] Default value for all steps
  # @param channel [Integer] Default value for all steps
  def initialize(pattern, note: nil, channel: nil)
    defaults   = { note: note, channel: channel }
    parsed     =
      if pattern.is_a?(String)
        self.class.parse(pattern)
      elsif pattern.is_a?(Enumerable)
        pattern
      else
        raise ArgumentError, "Invalid pattern: #{ pattern.inspect }"
      end
    self.steps =
      parsed.lazy.map do |step|
        Step.new(**defaults.merge(step))
      end
  end

  # Plays sequence once, or endlessly if it's defined by an infinite enumerable.
  # @param n [Integer] Number of steps to play
  #   May help to sync multiple polyrhythm sequences
  # @param reverse [Boolean] Plays sequence once in the reverse order
  #   Ignored if sequence is infinite
  # @param pendulum [Boolean] Plays sequence back and forth once
  #   If n is also provided, it limits the size of each part, not the total size
  def play(n = nil, reverse: false, pendulum: false)
    if pendulum
      play(n, reverse: reverse)
      play(n, reverse: !reverse)
      return
    end

    n ||= steps.size
    seq = steps
    seq = steps.reverse_each if reverse && finite?
    if finite?
      seq.cycle.take(n).each(&:play)
    else
      seq.each(&:play)
    end
  end

  def finite?
    !steps.size.nil?
  end

  def to_s
    seq = finite? ? steps : steps.take(16)
    seq.map(&:to_s).to_a.join('|')
  end
end

show_must_go_on!

# @author Alexander Pavlenko <alerticus@pm.me>