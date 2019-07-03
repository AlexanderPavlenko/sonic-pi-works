eval(File.read(File.expand_path('~/A/Music/SonicPi/Sequencer.rb')))

KONG_NOTES = %i[C2 Cs2 D2 Ds2 E2 F2 Fs2 G2 Gs2 A2 As2 B2 C3 Cs3 D3 Ds3].ring

live_loop :rhythm do
  seq  = Sequence.new(method(:rhythm))
  play = -> (bpm) {
    with_bpm(bpm) { seq.play }
  }
  bpm  = 70..170
  bpm.step(1).each(&play)
  bpm.step(4).reverse_each(&play)
end

def rhythm
  yield Step.new(
    duration: 1 / 3.0,
    note:     KONG_NOTES.choose,
  )
  yield Step.new(
    duration:    1 / 6.0,
    note:        KONG_NOTES.choose,
    channel:     2,
    repeats:     [1, 1, 2].choose,
    probability: 0.7
  )
  yield Step.new(
    duration:    [1 / 6.0, 1 / 7.0, 1 / 8.0].choose,
    note:        KONG_NOTES[0],
    probability: 0.2
  )
end