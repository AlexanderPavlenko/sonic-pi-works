MIDI_PORT = 'network_away'
use_midi_defaults port: MIDI_PORT, channel: 1
use_bpm 60

def sustain
  Rational(1, [2, 4].sample)
end

def velocity
  rand(10..100)
end

def scale_chords(scale_name: :chromatic, chord_name: :major, reverse: false)
  (scale :C, scale_name, num_octaves: 1).send(reverse ? :reverse : :itself).each do |tonic|
    sus = sustain
    (chord tonic, chord_name).each do |note|
      midi note, sustain: sus, vel: velocity
    end
    sleep sus
  end
end

# https://medium.com/@alwaysbcoding/an-intro-to-music-theory-for-hackers-8969ad4c1231
CIRCLE_FIFTHS = {
  minor: ring(*[[:A], [:E], [:B], [:Fs], [:Cs], [:Gs, :Ab], [:Ds, :Eb], [:Bb, :As], [:F], [:C], [:G], [:D]]),
  major: ring(*[[:C], [:G], [:D], [:A], [:E], [:B, :Cb], [:Fs, :Gb], [:Db, :Cs], [:Ab], [:Eb], [:Bb], [:F]]),
}

def circle_chords(chord_name: :major)
  CIRCLE_FIFTHS.fetch(chord_name).each do |tonic|
    sus = sustain
    (chord tonic.sample, chord_name).each do |note|
      midi note, sustain: sus, vel: velocity
    end
    sleep sus
  end
end

live_loop :play do
  circle_chords(chord_name: :minor)
  circle_chords(chord_name: :major)
  scale_chords(scale_name: :major, chord_name: :major, reverse: false)
  scale_chords(scale_name: :minor, chord_name: :minor, reverse: true)
end