eval(File.read(File.expand_path('~/A/Music/SonicPi/Sequencer.rb')))

generator = -> (notes, density: 0.7) {
  -> (&block) {
    notes    = notes.to_a
    max_note = notes.max.to_f
    notes.shuffle.each_with_index { |n, i|
      block.call Step.new(
        note:        n,
        velocity:    (i + 1) / notes.size.to_f,
        probability: density + 0.3 * n / max_note,
      )
    }
  }.to_enum(:call)
}

live_loop :av do
  seq = Sequence.new(generator[scale(:A3, :phrygian)])
  with_bpm(8) { seq.play }
end

live_loop :eai do
  seq = Sequence.new(generator[scale(:A3, :minor_pentatonic), density: 0], channel: 2)
  with_bpm(4) { seq.play }
end

live_loop :st do
  seq = Sequence.new(generator[scale(:A1, :phrygian), density: 0.2], channel: 3)
  with_bpm(16) { seq.play }
end