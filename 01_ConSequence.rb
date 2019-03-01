eval(File.read(File.expand_path('~/A/Music/SonicPi/Sequencer.rb')))

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