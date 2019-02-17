# the notes that we are playing
notes = scale(:C, :major)[0..6]
# scale gives an array of notes (see documentation).
# [0..6] takes the first six elements (to avoid the repetition
# of C an octave higher)

# the time waiting between two notes
wait = 0.5

# a single strand of notes that rises in pitch over three octaves
# the amplitude (volume) of notes first rises, then plateaus and
# finally falls
define :upstrand do |notes|
  
  # the number of notes in each part of the strand
  len = notes.count()
  
  # First part of the strand: lower pitch, rising amplitude
  # `with_octave` transposes the whole section (from `do` to `end`) by
  # the number of specified octaves
  with_octave -1 do
    len.times do |i|
      # the volume of each note is computed individually
      # `i.to_f / len`  is `i` divided by `len`, it increases with `i`
      # `.to_f` is necessary to use a floating point division
      # `** 0.5` takes the square root which smoothes the transition
      vol = (i.to_f / len) ** 0.5
      midi notes[i], vel_f: vol
      sleep wait
    end
  end
  
  # Second part of the strand: normal pitch, constant amplitude
  len.times do |i|
    midi notes[i], vel_f: 1.0
    sleep wait
  end
  
  # Third part of the strand: higher pitch, decreasing amplitude
  with_octave 1 do
    len.times do |i|
      # `vol` is similar to the rising amplitude of the first part
      # the only difference is the `1 - ..` which makes it decrease
      vol = (1 - (i.to_f / len)) ** 0.5
      midi notes[i], vel_f: vol
      sleep wait
    end
  end
end

# Start upstrand patterns (as defined above) at regular intervals
# the interval is computed based on the number of notes and the time
# between notes
while true do
    in_thread do
      upstrand notes
    end
    sleep wait * notes.count()
  end