MIDI_PORT = 'network_away'
use_midi_defaults port: MIDI_PORT, channel: 1
use_bpm 120

(scale :C, :chromatic, num_octaves: 1).each do |tonic|
  sus = Rational(1, rand(1..4).to_i * 2)
  (chord tonic, :major).each do |note|
    midi note, sustain: sus, vel: 80
  end
  sleep sus
end