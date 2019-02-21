$core = self
use_timing_guarantees true

def show_must_go_on!
  live_loop :high_hat do
    seq = Sequence.new(%(
      v900000 | ______ | v60 p20 | v40 p40 r3
      v80 p50 | v20 r2 |  _____  | v30 p10 r4
    ), note: :G2)
    with_bpm(120) { seq.play }
  end

  live_loop :kick do
    seq = [
      Sequence.new('.|_|v10 p50 r3|v88|_', note: :E2),
      Sequence.new('_|v30 p40 r2|v5 p15 r4|v40|v88|_|v10 p15 r3|_', note: :E2)
    ]
    seq[0].play(4, pendulum: true)
    seq[1].play
  end

  live_loop :ride do
    seq = Sequence.new(
      (0..0.8).step(0.02).lazy.map { |v|
        Step.new(velocity: v, note: :Ds3)
      }
    )
    seq.play(pendulum: true)
  end

  live_loop :keys do
    generator = -> (&block) {
      notes    = scale(:A3, :phrygian).to_a
      max_note = notes.max.to_f
      notes.shuffle.each_with_index { |n, i|
        block.call Step.new(
          channel:     2,
          note:        n,
          velocity:    (i + 1) / notes.size.to_f,
          repeats:     [1, 2, 3].choose,
          probability: 0.7 + 0.3 * n / max_note,
        )
      }
    }
    seq       = Sequence.new(generator.to_enum(:call))
    with_bpm(30) { seq.play }
  end
end


Step = Struct.new(
  *%i[note channel velocity probability repeats duration],
  keyword_init: true
) do

  # @param note [Symbol, Integer] MIDI parameter; :A..:G, :A2 - with octave, :Fs3 - sharp, :Eb3 - flat
  # @see http://www.sonic-pi.net/tutorial.html#section-2-1 Traditional Note Names
  # @param channel [Integer] MIDI channel for notes output
  # @see http://www.sonic-pi.net/tutorial.html#section-11-2 Selecting a MIDI device
  # @param velocity [Float, Integer] MIDI parameter; 0..1
  # @param probability [Float, Integer] 1 - plays each time, 0 - never plays, 0.5 - Kernel.rand decides
  # @param repeats [Integer] Number of times to play the note per duration
  # @param duration [Float] Play time in beats
  def initialize(note: :G2, channel: 1, velocity: 1, probability: 1, repeats: 1, duration: 0.25)
    self.note        = note
    self.channel     = channel.to_i.abs
    self.repeats     = repeats.to_i.abs
    self.duration    = duration.to_f
    self.velocity    = normalize(velocity)
    self.probability = normalize(probability)
  end

  def play
    if probability > 0 && repeats > 0 && rand <= probability
      step = duration / repeats
      repeats.times do
        $core.midi note, velocity_f: velocity, sustain: step, channel: channel
        $core.sleep step
      end
    else
      $core.sleep duration
    end
  end

  def normalize(number, range: 0..1)
    if number > range.end
      range.end
    elsif number < range.begin
      range.begin
    else
      number
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
  # @return [Array<Step>] Parsed steps
  def self.parse(pattern)
    normalized = pattern.tr("\n", '|').split('|').reject { |s| s.strip.empty? }
    normalized.map do |params|
      params.split(' ').each_with_object(Step.new) do |param, step|
        if param.squeeze == '_'
          step.probability = 0
        else
          prefix = param[0]
          value  = param[1..-1]
          case prefix
          when ':'
            step.note = value.to_sym
          when 'v'
            step.velocity = value.to_i / 100.0
          when 'p'
            step.probability = value.to_i / 100.0
          when 'r'
            step.repeats = value.to_i
          end
        end
      end
    end
  end

  # @param pattern [String, Enumerable<Step>] Defines notes sequence
  # @see Sequence.parse If pattern is a String
  # @see Step.initialize If pattern is an Enumerable<Step>
  # @param note [Symbol, Integer] Overrides note for all steps
  # @param channel [Integer] Overrides channel for all steps
  def initialize(pattern, note: nil, channel: nil)
    override   = { note: note, channel: channel }.compact
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
        if override.empty? && step.is_a?(Step)
          step
        else
          Step.new(**step.to_h.merge(override))
        end
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

    n   ||= steps.size
    seq = steps
    seq = steps.reverse_each if reverse && finite?
    if n.nil?
      seq.each(&:play)
    else
      seq.cycle.take(n).each(&:play)
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