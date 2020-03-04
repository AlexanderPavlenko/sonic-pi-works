eval(File.read(File.expand_path('~/A/Music/SonicPi/Sequencer.rb')))
eval(File.read(File.expand_path('~/A/Music/SonicPi/EuclideanRhythm.rb')))

MIDI_PORT  = 'iac_driver_bus_1'
KONG_NOTES = %i[C2 Cs2 D2 Ds2 E2 F2 Fs2 G2 Gs2 A2 As2 B2 C3 Cs3 D3 Ds3].ring

use_bpm 60

def hyper_rhythm
  step = Step.new(port: MIDI_PORT)
  (3..9).to_a.shuffle.each do |steps|
    next if steps.even?
    ((steps / 2)..(steps - 1)).to_a.shuffle.each do |pulses|
      4.times do
        step.note = KONG_NOTES.pick(1)[0]
        EuclideanRhythm.euclidean_rhythm(pulses, steps).each_with_index do |pulse, i|
          step.probability = pulse ? 1 : 0
          step.play
        end
        step.probability = 0
        pulses.times { step.play }
      end
    end
  end
end

6.times do |i|
  live_loop :"hyper_rhythm_#{i}" do
    hyper_rhythm
  end
end