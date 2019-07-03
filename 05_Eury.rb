eval(File.read(File.expand_path('~/A/Music/SonicPi/Sequencer.rb')))
eval(File.read(File.expand_path('~/A/Music/SonicPi/EuclideanRhythm.rb')))

MIDI_PORT = 'loopmidi'

use_bpm 60

live_loop :bass_frog_drop do
  Sequence.new(method(:bass_frog_drop)).play
end

live_loop :drums_kicka do
  Sequence.new(method(:drums_kicka)).play
end

live_loop :flute_smooth do
  Sequence.new(method(:flute_smooth)).play
end

live_loop :guitar_wonky_comb do
  Sequence.new(method(:guitar_wonky_comb)).play
end

live_loop :mallet_space_domestic do
  Sequence.new(method(:mallet_space_domestic)).play
end

live_loop :multitrack_ratios do
  Sequence.new(method(:multitrack_ratios)).play
end

live_loop :multitrack_mystic_visions do
  Sequence.new(method(:multitrack_mystic_visions)).play
end

live_loop :organ_world_park do
  Sequence.new(method(:organ_world_park)).play
end

def bass_frog_drop
  rhythm = EuclideanRhythm.euclidean_rhythm(3, 5).ring
  notes  = scale(:A2, :phrygian, num_octaves: 1).shuffle
  step   = Step.new(port: MIDI_PORT)
  loop do
    step.probability = rhythm.tick(:rhythm) ? 1 : 0
    if step.probability > 0
      step.note     = notes.tick(:note)
      step.velocity = rand(0.4..1)
    end
    yield step
  end
end

def drums_kicka
  rhythm      = EuclideanRhythm.euclidean_rhythm(2, 5).ring
  notes       = scale(:A1, :phrygian, num_octaves: 3).shuffle
  step        = Step.new(port: MIDI_PORT, channel: 2)
  probability = 0
  loop do
    if rhythm.tick(:rhythm)
      probability      += 0.1
      step.probability = probability
      step.note        = notes.tick(:note)
      step.velocity    = rand(0.5..1)
    else
      step.probability = 0
    end
    yield step
    probability = probability % 1.5
  end
end

def flute_smooth
  rhythm = EuclideanRhythm.euclidean_rhythm(4, 10).ring
  notes  = scale(:A3, :phrygian, num_octaves: 2).shuffle
  step   = Step.new(port: MIDI_PORT, channel: 3, duration: 2)
  loop do
    step.probability = rhythm.tick(:rhythm) ? 1 : 0
    if step.probability > 0
      step.note     = notes.tick(:note)
      step.velocity = rand(0.5..1)
    end
    yield step
  end
end

def guitar_wonky_comb
  rhythm = EuclideanRhythm.euclidean_rhythm(3, 10).ring
  notes  = scale(:A3, :phrygian).shuffle
  step   = Step.new(port: MIDI_PORT, channel: 4, duration: 1)
  loop do
    step.probability = rhythm.tick(:rhythm) ? 1 : 0
    if step.probability > 0
      step.note     = notes.tick(:note)
      step.velocity = rand(0.6..1)
    end
    yield step
  end
end

def mallet_space_domestic
  rhythm = EuclideanRhythm.euclidean_rhythm(9, 15).ring
  notes  = scale(:A2, :phrygian).shuffle
  step   = Step.new(port: MIDI_PORT, channel: 5, duration: 0.5)
  loop do
    step.probability = rhythm.tick(:rhythm) ? 1 : 0
    if step.probability > 0
      step.note     = notes.tick(:note)
      step.velocity = rand(0.5..1)
    end
    yield step
  end
end

def multitrack_ratios
  rhythm = EuclideanRhythm.euclidean_rhythm(8, 15).ring
  notes  = scale(:A2, :phrygian).shuffle
  step   = Step.new(port: MIDI_PORT, channel: 6, duration: 2)
  loop do
    step.probability = rhythm.tick(:rhythm) ? 1 : 0
    if step.probability > 0
      step.note     = notes.tick(:note)
      step.velocity = rand(0.5..1)
    end
    yield step
  end
end

def multitrack_mystic_visions
  rhythm = EuclideanRhythm.euclidean_rhythm(1, 14).ring
  notes  = scale(:A3, :phrygian).shuffle
  step   = Step.new(port: MIDI_PORT, channel: 7, duration: 3)
  loop do
    step.probability = rhythm.tick(:rhythm) ? 1 : 0
    if step.probability > 0
      step.note     = notes.tick(:note)
      step.velocity = rand(0.9..1)
    end
    yield step
  end
end

def organ_world_park
  rhythm = EuclideanRhythm.euclidean_rhythm(4, 7).ring
  notes  = scale(:A1, :phrygian, num_octaves: 3)
  step   = Step.new(port: MIDI_PORT, channel: 8, duration: 3)
  loop do
    step.probability = rhythm.tick(:rhythm) ? 1 : 0
    if step.probability > 0
      step.note     = notes.tick(:note)
      step.velocity = rand(0.05..1)
    end
    yield step
  end
end