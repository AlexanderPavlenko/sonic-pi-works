eval(File.read(File.expand_path('~/A/Music/SonicPi/Sequencer.rb')))
eval(File.read(File.expand_path('~/A/Music/SonicPi/EuclideanRhythm.rb')))

MIDI_PORT  = 'iac_driver_bus_1'

use_bpm 120

beep = Step.new(port: MIDI_PORT)
beep_counter = 0

live_loop :beep do
  beep_counter += 0.05
  puts beep.probability = Math.sin(beep_counter).abs
  beep.velocity = rand
  beep.duration = rand(0.2 .. 2 - beep.probability / 2)
  beep.play

  beep2 = beep.dup
  beep2.channel = 2
  beep2.velocity = 1 - beep2.velocity
  beep2.probability = 1 - beep2.probability
  beep2.duration = 0.6 - beep2.probability / 2
  beep2.repeats = (beep2.probability * 3).to_i + 1
  beep2.play
end