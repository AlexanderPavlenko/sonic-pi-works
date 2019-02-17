class Step
  
  DURATION = 0.25.to_f
  
  attr_accessor :note, :channel, :velocity, :probability, :repeats
  
  def initialize(note: nil, channel: nil, velocity: 1, probability: 1, repeats: 1)
    self.note = note || :G2
    self.channel = channel || 1
    self.repeats = repeats.to_i.abs
    
    self.velocity =
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
      "#{note}"\
        "#{velocity < 1 ? " v#{(velocity * 100).to_i}" : nil}"\
        "#{probability < 1 ? " p#{(probability * 100).to_i}" : nil}"\
        "#{repeats > 1 ? " r#{repeats}" : nil}"
    end
  end
end


class Sequence
  
  attr_accessor :steps
  
  def initialize(pattern, note: nil, channel: nil)
    default_step = { note: note, channel: channel }
    self.steps =
    case pattern
    when String
      normalized = pattern.tr("\n", '|').split('|').reject{ |s| s.strip.empty? }
      normalized.map do |step|
        Step.new **step.split(' ').each_with_object(
          default_step.dup
        ) { |item, result|
          if item.squeeze == '_'
            result[:probability] = 0
          else
            prefix = item[0]
            value  = item[1..-1]
            case prefix
            when 'v'
              result[:velocity] = value.to_i / 100.0
            when 'p'
              result[:probability] = value.to_i / 100.0
            when 'r'
              result[:repeats] = value
            when ':'
              result[:note] = item
            end
          end
        }
      end
    when Array
      pattern.map do |step|
        Step.new **default_step.merge(step)
      end
    end
    raise ArgumentError, "Empty sequence" if steps.empty?
  end
  
  def play(n=nil, reverse: false, pendulum: false)
    if pendulum
      play(n, reverse: reverse)
      play(n, reverse: !reverse)
      return
    end
    
    seq = steps
    seq = seq.reverse_each if reverse
    n ||= seq.size
    seq.cycle.lazy.take(n).each(&:play)
  end
  
  def to_s
    steps.map(&:to_s).join('|')
  end
end


$core = self
use_timing_guarantees true

def infinitely
  (0..Float::INFINITY).each do
    yield
  end
end

def seq_1
  infinitely do
    with_bpm 120 do
      Sequence.new(
        %(
          v9000   | ______ | v60 p20 | v40 p40 r3
          v80 p50 | v20 r2 |  _____  | v30 p10 r4
      ), note: :G2).tap{|s| puts s.to_s }.play
    end
  end
end

def seq_2
  infinitely do
    Sequence.new('.|_|v10 p15 r3|v88|_', note: :E2).play(4, pendulum: true)
  end
end

def seq_3
  seq = (0.01..0.7).step(0.02).to_a.map{ |v| {velocity: v } }
  infinitely do
    Sequence.new(seq, note: :Ds3).tap{|s| puts s.to_s }.play(pendulum: true)
  end
end

def seq_4
  infinitely do
    seq = scale(:A3, :phrygian).to_a.shuffle.map{|n| {note: n}}
    with_bpm 30 do
      Sequence.new(seq, channel: 2).play
    end
  end
end

in_thread { seq_1 }
in_thread { seq_2 }
in_thread { seq_3 }
in_thread { seq_4 }
