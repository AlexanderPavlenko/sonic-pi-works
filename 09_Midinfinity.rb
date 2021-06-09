# inspired by https://github.com/bettinson/markov_midi

$LOAD_PATH.unshift('/Users/alex/A/Music/SonicPi/vendor/bundle/ruby/3.0.0/gems/midilib-2.0.5/lib')
require 'midilib'

MIDI_DIR = '/Users/alex/Music/MIDI/'
if Dir[MIDI_DIR + '*'].empty?
  system %(fuse-zip -r /Users/alex/A/Music/MIDI/kunstderfuge-com_complete_collection.zip #{MIDI_DIR})
end
MIDI_FILES = Dir[MIDI_DIR + '**/*.mid']
MIDI_FILES.__orig_shuffle_bang__

Note = Struct.new(:note, :velocity, :duration, :position, :duration_normalized)

def each_track_notes
  MIDI_FILES.each do |path|
    puts path
    seq = MIDI::Sequence.new()
    File.open(path, 'rb') do |file|
      seq.read(file)
    end

    seq.each_with_index do |track, i|
      puts "#{path[MIDI_DIR.size..]}|#{i}"
      notes = []
      track.each do |event|
        if event.kind_of? MIDI::NoteOn
          note = Note.new(event.note, event.velocity, 0, event.time_from_start)
          notes << note
        end
        if event.kind_of? MIDI::NoteOff
          note          = notes.reverse_each.find { |note| note.note == event.note }
          note.duration = event.time_from_start - note.position if note
        end
      end
      next if notes.empty?

      notes_size = notes.size
      notes.reject! { |note| note.duration.nil? || note.duration <= 0 }
      puts "ignoring #{notes_size - notes.size} notes without duration"
      notes.sort_by!(&:position) # probably redundant

      duration_median = notes.sort_by(&:duration)[notes.size / 2].duration.to_f
      notes.each do |note|
        note.duration_normalized = (note.duration / duration_median).round(3)
      end

      yield notes
    end
  rescue => ex
    puts ex.inspect
    next
  end
end

# @param quantize [Integer|Boolean] larger number turns more nearby notes into a chord
#   until the whole track is one giant chord.
def chords_chain(notes, quantize: 10)
  puts "quantize: #{quantize}"
  if quantize && quantize > 1
    chords = notes.group_by { |note|
      note.position - (note.position % quantize)
    }.sort_by(&:first)
    chords.map!(&:last)
  else
    chords = notes.map { |note| [note] }
  end

  chain = Hash.new { |h, k| h[k] = [] }
  chords.each_cons(2) do |w1, w2|
    chain[w1] << w2
  end
  chain[chords.last] << chords.first

  chain
end

def generate(n, chain)
  raise ArgumentError if n < 0
  unless block_given?
    return to_enum(__method__, n, chain) { n }
  end

  last = chain.each_key.first
  n.times do
    last = chain[last].sample
    yield last
  end
end

def midi_play_chord(chord_notes, sustain_factor: 1, channel_map: nil)
  max_sustain = 0
  chord_notes.each do |note|
    sustain = sustain_factor * note.duration_normalized
    channel = channel_map ? channel_map[note.note] : MIDI_CHANNEL
    midi note.note, vel: note.velocity, sustain: sustain, channel: channel
    max_sustain = [max_sustain, sustain].max
  end
  sleep max_sustain
end

def loading(in_progress = true, eta: 2)
  $loading = in_progress
  if $loading
    live_loop :loading do
      if $loading
        sleep eta
      else
        cue :loaded
        stop
      end
    end
  else
    sync :loaded
  end
end


MIDI_PORT    = 'network_away'
# MIDI_PORT    = 'iac_driver_bus_1'
MIDI_CHANNEL = 1
use_midi_defaults port: MIDI_PORT, channel: MIDI_CHANNEL
use_bpm 60

quantize = 10 # false # 100
loading
each_track_notes do |notes|
  quantize = (quantize + 30) % 200
  chain    = chords_chain(notes, quantize: quantize)
  sustain  = (1 / 32r) * [8, 16].sample
  loading false
  generate(rand(21..84), chain) do |chord_notes|
    midi_play_chord chord_notes, sustain_factor: sustain, channel_map: ->(_) { 1 } # rand_i(8) + 1 }
  end
  midi_all_notes_off port: MIDI_PORT
  loading
end

# TODO: synth preset change via midi command
# TODO: headless radio
