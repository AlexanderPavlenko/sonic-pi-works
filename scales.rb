def play_scale(key, name, up: true)
  notes = scale(key, name)
  notes = notes.reverse unless up
  notes.each do |note|
    puts key, name
    play note, duration: (100-note)/18, release: 0.2
    sleep [1/3.0, 2/3.0, 1].choose
  end
end

in_thread do
  loop do
    with_bpm 60 do
      play_scale(:C4, scale_names.choose, up: false)
    end
  end
end
in_thread do
  loop do
    with_bpm 90 do
      play_scale(:C5, scale_names.choose)
    end
  end
end