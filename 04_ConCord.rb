eval(File.read(File.expand_path('~/A/Music/SonicPi/Sequencer.rb')))

live_loop :melody do
  with_bpm 4 do
    Sequence.new(method(:melody)).play
  end
end

def melody
  notes = chord_degree(1, :A0, :phrygian, 6)
  step  = Step.new
  loop do
    step.note = notes.tick
    yield step
  end
end