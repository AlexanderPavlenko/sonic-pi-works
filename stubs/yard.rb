# Get all sample names
# Return a list of all the sample names available
# @accepts_block false
# @introduced 2.0.0
def all_sample_names
  #This is a stub, used for indexing
end

# Ensure arg is valid
# Raises an exception if the argument is either nil or false.
# @param _arg [anything]
# @accepts_block false
# @introduced 2.8.0
# @example
#   # Simple assertions
#   assert true   # As true is neither nil or false, this assertion passes
#   assert 1      # Similarly, 1 passes
#   assert "foo" # As do string
#   assert false  # This will raise an exception
#
# @example
#   # Communicating error messages
#   assert false, "oops" # This will raise an exception containing the message "oops"
#
# @example
#   # More interesting assertions
#   assert (1 + 1) == 2 # Ensure that arithmetic is sane!
#   assert [:a, :b, :c].size == 3 # ensure lists can be correctly counted
#
def assert(_arg = nil)
  #This is a stub, used for indexing
end

# Ensure args are equal
# Raises an exception if both arguments aren't equal. 
# @param _arg1 [anything]
# @param _arg2 [anything]
# @accepts_block false
# @introduced 2.8.0
# @example
#   # Simple assertions
#   assert_equal 1, 1
#
# @example
#   # More interesting assertions
#   assert_equal 1 + 1, 2 # Ensure that arithmetic is sane!
#   assert_equal [:a, :b, :c].size,  3 # ensure lists can be correctly counted
#
# @example
#   # Add messages to the exceptions
#   assert_equal 3, 5, "something is seriously wrong!"
#
def assert_equal(_arg1 = nil, _arg2 = nil)
  #This is a stub, used for indexing
end

# Ensure block throws an error
# Runs the block and ensures that it raises the correct Exception. Useful for asserting that an Exception will be raised. You may specify the particular Exception class, which defaults to `Exception`.
# @param _class [Exception]
# @accepts_block true
# @introduced 3.0.0
# @example
#   assert_error do
#     play 70
#   end                         # Will throw an exception: "Assert error failed!" as the block
#                               # contains no errors.
#
# @example
#   assert_error do
#     1 / 0
#   end                         # Will not throw an exception as the block contains an error.
#
# @example
#   assert_error ZeroDivisionError do
#     1 / 0
#   end                         # Will not throw an exception as the block contains a ZeroDivisionError.
#
# @example
#   assert_error ThreadError do
#     1 / 0
#   end                         # Will throw an exception as the block contains a ZeroDivisionError rather than
#                               # a ThreadError.
#
def assert_error(_class = nil)
  #This is a stub, used for indexing
end

# Ensure args are similar
# Raises an exception if both arguments aren't similar.
# 
# Currently similarity is only defined for numbers - all other types are compared for equality with assert_equal.
# 
# Useful for testing in cases where floating point imprecision stops you from being able to use `assert_equal`. 
# @param _arg1 [anything]
# @param _arg2 [anything]
# @accepts_block false
# @introduced 3.0.0
# @example
#   # Simple assertions
#   assert_similar 1, 1 #=> True
#
# @example
#   # Handles floating point imprecision
#   assert_similar(4.9999999999, 5.0) #=> True
#
def assert_similar(_arg1 = nil, _arg2 = nil)
  #This is a stub, used for indexing
end

# Asynchronous Time. Run a block at the given time(s)
# Given a list of times, run the block once after waiting each given time. If passed an optional params list, will pass each param individually to each block call. If size of params list is smaller than the times list, the param values will act as rings (rotate through). If the block is given 1 arg, the times are fed through. If the block is given 2 args, both the times and the params are fed through. A third block arg will receive the index of the time.
# 
# Note, all code within the block is executed in its own thread. Therefore despite inheriting all thread locals such as the random stream and ticks, modifications will be isolated to the block and will not affect external code.
# 
# `at` is just-in-time scheduling using multiple isolated threads. See `time_warp` for ahead-of-time scheduling within the current thread.
# @param _times [list]
# @param _params [list]
# @accepts_block true
# @introduced 2.1.0
# @example
#   at 4 do
#       sample :ambi_choir    # play sample after waiting for 4 beats
#     end
#
# @example
#   at [1, 2, 4] do  # plays a note after waiting 1 beat,
#       play 75           # then after 1 more beat,
#     end                 # then after 2 more beats (4 beats total)
#
# @example
#   at [1, 2, 3], [75, 76, 77] do |n|  # plays 3 different notes
#       play n
#     end
#
# @example
#   at [1, 2, 3],
#         [{:amp=>0.5}, {:amp=> 0.8}] do |p| # alternate soft and loud
#       sample :drum_cymbal_open, p          # cymbal hits three times
#     end
#
# @example
#   at [0, 1, 2] do |t| # when no params are given to at, the times are fed through to the block
#       puts t #=> prints 0, 1, then 2
#     end
#
# @example
#   at [0, 1, 2], [:a, :b] do |t, b|  #If you specify the block with 2 args, it will pass through both the time and the param
#       puts [t, b] #=> prints out [0, :a], [1, :b], then [2, :a]
#     end
#
# @example
#   at [0, 0.5, 2] do |t, idx|  #If you specify the block with 2 args, and no param list to at, it will pass through both the time and the index
#       puts [t, idx] #=> prints out [0, 0], [0.5, 1], then [2, 2]
#     end
#
# @example
#   at [0, 0.5, 2], [:a, :b] do |t, b, idx|  #If you specify the block with 3 args, it will pass through the time, the param and the index
#       puts [t, b, idx] #=> prints out [0, :a, 0], [0.5, :b, 1], then [2, :a, 2]
#     end
#
# @example
#   # at does not consume & interfere with the outer random stream
#   puts "main: ", rand  # 0.75006103515625
#   rand_back
#   at 1 do         # the random stream inside the at block is separate and
#                   # isolated from the outer stream.
#     puts "at:", rand # 0.9287109375
#     puts "at:", rand # 0.1043701171875
#   end
#   
#   sleep 2
#   puts "main: ", rand # value is still 0.75006103515625
#
# @example
#   # Each block run within at has its own isolated random stream:
#   at [1, 2] do
#               # first time round (after 1 beat) prints:
#     puts rand # 0.9287109375
#     puts rand # 0.1043701171875
#   end
#               # second time round (after 2 beats) prints:
#               # 0.1043701171875
#               # 0.764617919921875
#
def at(_times = nil, _params = nil)
  #This is a stub, used for indexing
end

# Get current beat
# Returns the beat value for the current thread/live_loop. Beats are advanced only by calls to `sleep` and `sync`. Beats are distinct from virtual time (the value obtained by calling `vt`) in that it has no notion of rate. It is just essentially a counter for sleeps. After a `sync`, the beat is overridden with the beat value from the thread which called `cue`. 
# @accepts_block false
# @introduced 2.10.0
# @example
#   use_bpm 120  # The current BPM makes no difference
#     puts beat    #=> 0
#     sleep 1
#     puts beat    #=> 1
#     use_bpm 2000
#     sleep 2
#     puts beat    #=> 3
#
def beat
  #This is a stub, used for indexing
end

# Return block duration
# Given a block, runs it and returns the amount of time that has passed. This time is in seconds and is not scaled to the current BPM. Any threads spawned in the block are not accounted for.
# @accepts_block true
# @introduced 2.9.0
# @example
#   dur = block_duration do
#     play 50
#     sleep 1
#     play 62
#     sleep 2
#   end
#   
#   puts dur #=> Returns 3 as 3 seconds have passed within the block
#
# @example
#   use_bpm 120
#   dur = block_duration do
#     play 50
#     sleep 1
#     play 62
#     sleep 2
#   end
#   
#   puts dur #=> Returns 1.5 as 1.5 seconds have passed within the block
#            #   (due to the BPM being 120)
#
def block_duration
  #This is a stub, used for indexing
end

# Determine if block contains sleep time
# Given a block, runs it and returns whether or not the block contained sleeps or syncs
# @accepts_block true
# @introduced 2.9.0
# @example
#   slept = block_slept? do
#     play 50
#     sleep 1
#     play 62
#     sleep 2
#   end
#   
#   puts slept #=> Returns true as there were sleeps in the block
#
# @example
#   in_thread do
#     sleep 1
#     cue :foo  # trigger a cue on a different thread
#   end
#   
#   slept = block_slept? do
#     sync :foo  # wait for the cue before playing the note
#     play 62
#   end
#   
#   puts slept #=> Returns true as the block contained a sync.
#
# @example
#   slept = block_slept? do
#     play 50
#     play 62
#   end
#   
#   puts slept #=> Returns false as there were no sleeps in the block
#
def block_slept?
  #This is a stub, used for indexing
end

# Create a ring of boolean values
# Create a new ring of booleans values from 1s and 0s, which can be easier to write and manipulate in a live setting.
# @param _list [array]
# @accepts_block false
# @introduced 2.2.0
# @example
#   (bools 1, 0)    #=> (ring true, false)
#
# @example
#   (bools 1, 0, true, false, nil) #=> (ring true, false, true, false, false)
#
def bools(_list = nil)
  #This is a stub, used for indexing
end

# Beat time conversion
# Beat time representation. Scales the time to the current BPM. Useful for adding bpm scaling
# @param _seconds [number]
# @accepts_block false
# @introduced 2.8.0
# @example
#   use_bpm 120  # Set the BPM to be double the default
#     puts bt(1) # 0.5
#     use_bpm 60   # BPM is now default
#     puts bt(1) # 1
#     use_bpm 30   # BPM is now half the default
#     puts bt(1) # 2
#
def bt(_seconds = nil)
  #This is a stub, used for indexing
end

# Intialise or return named buffer
# Initialise or return a named buffer with a specific duration (defaults to 8 beats). Useful for working with the `:record` FX. If the buffer is requested with a different duration, then a new buffer will be initialised and the old one recycled.
# @accepts_block false
# @introduced 3.0.0
# @example
#   buffer(:foo) # load a 8s buffer and name it :foo
#   b = buffer(:foo) # return cached buffer and bind it to b
#   puts b.duration  #=> 8.0
#
# @example
#   buffer(:foo, 16) # load a 16s buffer and name it :foo
#
# @example
#   use_bpm 120
#   buffer(:foo, 16) # load a 8s buffer and name it :foo
#                    # (this isn't 16s as the BPM has been
#                    # doubled from the default of 60)
#
# @example
#   buffer(:foo)     # init a 8s buffer and name it :foo
#   buffer(:foo, 8)  # return cached 8s buffer (has the same duration)
#   buffer(:foo, 10) # init a new 10s buffer and name it :foo
#   buffer(:foo, 10) # return cached 10s buffer
#   buffer(:foo)     # init a 8s buffer and name it :foo
#   buffer(:foo)     # return cached 8s buffer (has the same duration)
#
def buffer
  #This is a stub, used for indexing
end

# Random list selection
# Choose an element at random from a list (array).
# 
# If no arguments are given, will return a lambda function which when called takes an argument which will be a list to be chosen from. This is useful for choosing random `onset:` vals for samples
# 
# Always returns a single element (or nil)
# @param _list [array]
# @accepts_block false
# @introduced 2.0.0
# @example
#   loop do
#       play choose([60, 64, 67]) #=> plays one of 60, 64 or 67 at random
#       sleep 1
#       play chord(:c, :major).choose #=> You can also call .choose on the list
#       sleep 1
#     end
#
# @example
#   # Using choose for random sample onsets
#   live_loop :foo do
#     sample :loop_amen, onset: choose   # choose a random onset value each time
#     sleep 0.125
#   end
#
def choose(_list = nil)
  #This is a stub, used for indexing
end

# Create chord
# Creates an immutable ring of Midi note numbers when given a tonic note and a chord type. If only passed a chord type, will default the tonic to 0. See examples.
# @param _tonic [symbol]
# @param _name [symbol]
# @param invert Apply the specified num inversions to chord. See the fn `chord_invert`.
# @param num_octaves Create an arpeggio of the chord over n octaves
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts (chord :e, :minor) # returns a ring of midi notes - (ring 64, 67, 71)
#
# @example
#   # Play all the notes together
#   play (chord :e, :minor)
#
# @example
#   # Chord inversions (see the fn chord_invert)
#   play (chord :e3, :minor, invert: 0) # Play the basic :e3, :minor chord - (ring 52, 55, 59)
#   play (chord :e3, :minor, invert: 1) # Play the first inversion of :e3, :minor - (ring 55, 59, 64)
#   play (chord :e3, :minor, invert: 2) # Play the first inversion of :e3, :minor - (ring 59, 64, 67)
#
# @example
#   # You can create a chord without a tonic:
#   puts (chord :minor) #=> (ring 0, 3, 7)
#
# @example
#   # chords are great for arpeggiators
#   live_loop :arp do
#     play chord(:e, :minor, num_octaves: 2).tick, release: 0.1
#     sleep 0.125
#   end
#
# @example
#   # Sonic Pi supports a large range of chords
#    # Notice that the more exotic ones have to be surrounded by ' quotes
#   (chord :C, '1')
#   (chord :C, '5')
#   (chord :C, '+5')
#   (chord :C, 'm+5')
#   (chord :C, :sus2)
#   (chord :C, :sus4)
#   (chord :C, '6')
#   (chord :C, :m6)
#   (chord :C, '7sus2')
#   (chord :C, '7sus4')
#   (chord :C, '7-5')
#   (chord :C, 'm7-5')
#   (chord :C, '7+5')
#   (chord :C, 'm7+5')
#   (chord :C, '9')
#   (chord :C, :m9)
#   (chord :C, 'm7+9')
#   (chord :C, :maj9)
#   (chord :C, '9sus4')
#   (chord :C, '6*9')
#   (chord :C, 'm6*9')
#   (chord :C, '7-9')
#   (chord :C, 'm7-9')
#   (chord :C, '7-10')
#   (chord :C, '9+5')
#   (chord :C, 'm9+5')
#   (chord :C, '7+5-9')
#   (chord :C, 'm7+5-9')
#   (chord :C, '11')
#   (chord :C, :m11)
#   (chord :C, :maj11)
#   (chord :C, '11+')
#   (chord :C, 'm11+')
#   (chord :C, '13')
#   (chord :C, :m13)
#   (chord :C, :add2)
#   (chord :C, :add4)
#   (chord :C, :add9)
#   (chord :C, :add11)
#   (chord :C, :add13)
#   (chord :C, :madd2)
#   (chord :C, :madd4)
#   (chord :C, :madd9)
#   (chord :C, :madd11)
#   (chord :C, :madd13)
#   (chord :C, :major)
#   (chord :C, :M)
#   (chord :C, :minor)
#   (chord :C, :m)
#   (chord :C, :major7)
#   (chord :C, :dom7)
#   (chord :C, '7')
#   (chord :C, :M7)
#   (chord :C, :minor7)
#   (chord :C, :m7)
#   (chord :C, :augmented)
#   (chord :C, :a)
#   (chord :C, :diminished)
#   (chord :C, :dim)
#   (chord :C, :i)
#   (chord :C, :diminished7)
#   (chord :C, :dim7)
#   (chord :C, :i7)
#
def chord(_tonic = nil, _name = nil, invert: nil, num_octaves: nil)
  #This is a stub, used for indexing
end

# Construct chords of stacked thirds, based on scale degrees
# In music we build chords from scales. For example, a C major chord is made by taking the 1st, 3rd and 5th notes of the C major scale (C, E and G). If you do this on a piano you might notice that you play one, skip one, play one, skip one etc. If we use the same spacing and start from the second note in C major (which is a D), we get a D minor chord which is the 2nd, 4th and 6th notes in C major (D, F and A). We can move this pattern all the way up or down the scale to get different types of chords. `chord_degree` is a helper method that returns a ring of midi note numbers when given a degree (starting point in a scale) which is a symbol `:i`, `:ii`, `:iii`, `:iv`, `:v`, `:vi`, `:vii` or a number `1`-`7`. The second argument is the tonic note of the scale, the third argument is the scale type and finally the fourth argument is number of notes to stack up in the chord. If we choose 4 notes from degree `:i` of the C major scale, we take the 1st, 3rd, 5th and 7th notes of the scale to get a C major 7 chord.
# @param _degree [symbol_or_number]
# @param _tonic [symbol]
# @param _scale [symbol]
# @param _number_of_notes [number]
# @accepts_block false
# @introduced 2.1.0
# @example
#   puts (chord_degree :i, :A3, :major) # returns a ring of midi notes - (ring 57, 61, 64, 68) - an A major 7 chord
#
# @example
#   play (chord_degree :i, :A3, :major, 3)
#
# @example
#   play (chord_degree :ii, :A3, :major, 3) # Chord ii in A major is a B minor chord
#
# @example
#   play (chord_degree :iii, :A3, :major, 3) # Chord iii in A major is a C# minor chord
#
# @example
#   play (chord_degree :iv, :A3, :major, 3) # Chord iv in A major is a D major chord
#
# @example
#   play (chord_degree :i, :C4, :major, 4) # Taking four notes is the default. This gives us 7th chords - here it plays a C major 7
#
# @example
#   play (chord_degree :i, :C4, :major, 5) # Taking five notes gives us 9th chords - here it plays a C major 9 chord
#
def chord_degree(_degree = nil, _tonic = nil, _scale = nil, _number_of_notes = nil)
  #This is a stub, used for indexing
end

# Chord inversion
# Given a set of notes, apply a number of inversions indicated by the `shift` parameter. Inversions being an increase to notes if `shift` is positive or decreasing the notes if `shift` is negative.
# 
# An inversion is simply rotating the chord and shifting the wrapped notes up or down an octave. For example, consider the chord :e3, :minor - `(ring 52, 55, 59)`. When we invert it once, we rotate the notes around to `(ring 55, 59, 52)`. However, because note 52 is wrapped round, it's shifted up an octave (12 semitones) so the actual first inversion of the chord :e3, :minor is `(ring 55, 59, 52 + 12)` or `(ring 55, 59, 64)`.
# 
# Note that it's also possible to directly invert chords on creation with the `invert:` opt - `(chord :e3, :minor, invert: 2)`
# @param _notes [list]
# @param _shift [number]
# @accepts_block false
# @introduced 2.6.0
# @example
#   play (chord_invert (chord :A3, "M"), 0) #No inversion     - (ring 57, 61, 64)
#   sleep 1
#   play (chord_invert (chord :A3, "M"), 1) #First inversion  - (ring 61, 64, 69)
#   sleep 1
#   play (chord_invert (chord :A3, "M"), 2) #Second inversion - (ring 64, 69, 73)
#
def chord_invert(_notes = nil, _shift = nil)
  #This is a stub, used for indexing
end

# All chord names
# Returns a ring containing all chord names known to Sonic Pi
# @accepts_block false
# @introduced 2.6.0
# @example
#   puts chord_names #=>  prints a list of all the chords
#
def chord_names
  #This is a stub, used for indexing
end

# Clear all thread locals to defaults
# All settings such as the current synth, BPM, random stream and tick values will be reset to their defaults. Consider using `reset` to reset all these values to those inherited from the parent thread.
# @accepts_block false
# @introduced 2.11.0
# @example
#   Clear wipes out the threads locals
#   use_synth :blade
#   use_octave 3
#   
#   puts "before"         #=> "before"
#   puts current_synth      #=> :blade
#   puts current_octave     #=> 3
#   puts rand               #=> 0.75006103515625
#   puts tick               #=> 0
#   
#   at do
#     use_synth :tb303
#     puts rand               #=> 0.9287109375
#     clear
#     puts "thread"         #=> "thread"
#   
#   
#                             # The clear reset the current synth to the default
#                             # of :beep. We are therefore ignoring any inherited
#                             # synth settings. It is as if the thread was a completely
#                             # new Run.
#     puts current_synth      #=> :beep
#   
#                             # The current octave defaults back to 0
#     puts current_octave     #=> 0
#   
#                             # The random stream defaults back to the standard
#                             # stream used by every new Run.
#     puts rand               #=> 0.75006103515625
#     puts tick               #=> 0
#   end
#
def clear
  #This is a stub, used for indexing
end

# Block level commenting
# Does not evaluate any of the code within the block. However, any optional args passed before the block *will* be evaluated although they will be ignored. See `uncomment` for switching commenting off without having to remove the comment form.
# @accepts_block true
# @introduced 2.0.0
# @example
#   comment do # starting a block level comment:
#       play 50 # not played
#       sleep 1 # no sleep happens
#       play 62 # not played
#     end
#
def comment
  #This is a stub, used for indexing
end

# Control running synth
# Control a running synth node by passing new parameters to it. A synth node represents a running synth and can be obtained by assigning the return value of a call to play or sample or by specifying a parameter to the do/end block of an FX. You may modify any of the parameters you can set when triggering the synth, sample or FX. See documentation for opt details. If the synth to control is a chord, then control will change all the notes of that chord group at once to a new target set of notes - see example. Also, you may use the on: opt to conditionally trigger the control - see the docs for the `synth` and `sample` fns for more information.
# 
# If no synth to control is specified, then the last synth triggered by the current (or parent) thread will be controlled - see example below.
# @param _node [synth_node]
# @accepts_block false
# @introduced 2.0.0
# @example
#   ## Basic control
#   
#   my_node = play 50, release: 5, cutoff: 60 # play note 50 with release of 5 and cutoff of 60. Assign return value to variable my_node
#   sleep 1 # Sleep for a second
#   control my_node, cutoff: 70 # Now modify cutoff from 60 to 70, sound is still playing
#   sleep 1 # Sleep for another second
#   control my_node, cutoff: 90 # Now modify cutoff from 70 to 90, sound is still playing
#
# @example
#   ## Combining control with slide opts allows you to create nice transitions.
#   
#   s = synth :prophet, note: :e1, cutoff: 70, cutoff_slide: 8, release: 8 # start synth and specify slide time for cutoff opt
#   control s, cutoff: 130 # Change the cutoff value with a control.
#                          # Cutoff will now slide over 8 beats from 70 to 130
#
# @example
#   ## Use a short slide time and many controls to create a sliding melody
#   
#   notes = (scale :e3, :minor_pentatonic, num_octaves: 2).shuffle # get a random ordering of a scale
#   
#   s = synth :beep, note: :e3, sustain: 8, note_slide: 0.05 # Start our synth running with a long sustain and short note slide time
#   64.times do
#     control s, note: notes.tick                            # Keep quickly changing the note by ticking through notes repeatedly
#     sleep 0.125
#   end
#
# @example
#   ## Controlling FX
#   
#   with_fx :bitcrusher, sample_rate: 1000, sample_rate_slide: 8 do |bc| # Start FX but also use the handy || goalposts
#                                                                        # to grab a handle on the running FX. We can call
#                                                                        # our handle anything we want. Here we've called it bc
#     sample :loop_garzul, rate: 1
#     control bc, sample_rate: 5000                                      # We can use our handle bc now just like we used s in the
#                                                                        # previous example to modify the FX as it runs.
#   end
#
# @example
#   ## Controlling chords
#   
#   cg = play (chord :e4, :minor), sustain: 2  # start a chord
#   sleep 1
#   control cg, notes: (chord :c3, :major)     # transition to new chord.
#                                              # Each note in the original chord is mapped onto
#                                              # the equivalent in the new chord.
#
# @example
#   ## Sliding between chords
#   
#   cg = play (chord :e4, :minor), sustain: 4, note_slide: 3  # start a chord
#   sleep 1
#   control cg, notes: (chord :c3, :major)                    # slide to new chord.
#                                                             # Each note in the original chord is mapped onto
#                                                             # the equivalent in the new chord.
#
# @example
#   ## Sliding from a larger to smaller chord
#   
#   cg = play (chord :e3, :m13), sustain: 4, note_slide: 3  # start a chord with 7 notes
#   sleep 1
#   control cg, notes: (chord :c3, :major)                    # slide to new chord with fewer notes (3)
#                                                             # Each note in the original chord is mapped onto
#                                                             # the equivalent in the new chord using ring-like indexing.
#                                                             # This means that the 4th note in the original chord will
#                                                             # be mapped onto the 1st note in the second chord and so-on.
#
# @example
#   ## Sliding from a smaller to larger chord
#   cg = play (chord :c3, :major), sustain: 4, note_slide: 3  # start a chord with 3 notes
#   sleep 1
#   control cg, notes: (chord :e3, :m13)                     # slide to new chord with more notes (7)
#                                                             # Each note in the original chord is mapped onto
#                                                             # the equivalent in the new chord.
#                                                             # This means that the 4th note in the new chord
#                                                             # will not sound as there is no 4th note in the
#                                                             # original chord.
#
# @example
#   ## Changing the slide rate
#   
#   s = synth :prophet, note: :e1, release: 8, cutoff: 70, cutoff_slide: 8 # Start a synth playing with a long cutoff slide
#   sleep 1                                                                # wait a beat
#   control s, cutoff: 130                                                 # change the cutoff so it starts sliding slowly
#   sleep 3                                                                # wait for 3 beats
#   control s, cutoff_slide: 1                                             # Change the cutoff_slide - the cutoff now slides more quickly to 130
#                                                                          # it will now take 1 beat to slide from its *current* value
#                                                                          # (somewhere between 70 and 130) to 130
#
# @example
#   ## Controlling the last triggered synth
#   
#   synth :prophet, note: :e1, release: 8                                  # Every time a synth is triggered, Sonic Pi automatically remembers the node
#   sleep 1
#   16.times do
#     control note: (octs :e1, 3).tick                                     # This means we don't need to use an explicit variable to control the synth
#     sleep 0.125                                                          # we last triggered.
#   end
#
# @example
#   ## Controlling multiple synths without variables
#   
#   synth :beep, release: 4                  # Trigger a beep synth
#   sleep 0.1
#   control note: :e5                        # Control last triggered synth (:beep)
#   sleep 0.5
#   synth :dsaw, release: 4                  # Next, trigger a dsaw synth
#   sleep 0.1
#   control note: :e4                        # Control last triggered synth (:dsaw)
#
def control(_node = nil)
  #This is a stub, used for indexing
end

# Cue other threads
# Send a heartbeat synchronisation message containing the (virtual) timestamp of the current thread. Useful for syncing up external threads via the `sync` fn. Any opts which are passed are given to the thread which syncs on the `cue_id`. The values of the opts must be immutable. Currently numbers, symbols, booleans, nil and frozen strings, or vectors/rings/frozen arrays/maps of immutable values are supported.
# @param _cue_id [symbol]
# @param your_key Your value
# @param another_key Another value
# @param key All these opts are passed through to the thread which syncs
# @accepts_block false
# @introduced 2.0.0
# @example
#   in_thread do
#       sync :foo # this parks the current thread waiting for a foo cue message to be received.
#       sample :ambi_lunar_land
#     end
#   
#     sleep 5
#   
#     cue :foo # We send a cue message from the main thread.
#               # This then unblocks the thread above and we then hear the sample
#
# @example
#   in_thread do   # Start a metronome thread
#       loop do      # Loop forever:
#         cue :tick  # sending tick heartbeat messages
#         sleep 0.5  # and sleeping for 0.5 beats between ticks
#       end
#     end
#   
#     # We can now play sounds using the metronome.
#     loop do                    # In the main thread, just loop
#       sync :tick               # waiting for :tick cue messages
#       sample :drum_heavy_kick  # after which play the drum kick sample
#     end
#
# @example
#   in_thread do   # Start a metronome thread
#       loop do      # Loop forever:
#         cue [:foo, :bar, :baz].choose # sending one of three tick heartbeat messages randomly
#         sleep 0.5  # and sleeping for 0.5 beats between ticks
#       end
#     end
#   
#     # We can now play sounds using the metronome:
#   
#     in_thread do
#       loop do              # In the main thread, just loop
#         sync :foo          # waiting for :foo cue messages
#         sample :elec_beep  # after which play the elec beep sample
#       end
#     end
#   
#     in_thread do
#       loop do              # In the main thread, just loop
#         sync :bar          # waiting for :bar cue messages
#         sample :elec_flip  # after which play the elec flip sample
#       end
#     end
#   
#     in_thread do
#       loop do              # In the main thread, just loop
#         sync :baz          # waiting for :baz cue messages
#         sample :elec_blup  # after which play the elec blup sample
#       end
#     end
#
# @example
#   in_thread do
#       loop do
#         cue :tick, foo: 64  # sending tick heartbeat messages with a value :foo
#         sleep 0.5
#       end
#     end
#   
#     # The value for :foo can now be used in synced threads
#   
#     loop do
#       values = sync :tick
#       play values[:foo]    # play the note value from :foo
#     end
#
def cue(_cue_id = nil, your_key: nil, another_key: nil, key: nil)
  #This is a stub, used for indexing
end

# Get current arg checking status
# Returns the current arg checking setting (`true` or `false`).
# 
# This can be set via the fns `use_arg_checks` and `with_arg_checks`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts current_arg_checks # Print out the current arg check setting
#
def current_arg_checks
  #This is a stub, used for indexing
end

# Duration of current beat
# Get the duration of the current beat in seconds. This is the actual length of time which will elapse with `sleep 1`.
# 
# Affected by calls to `use_bpm`, `with_bpm`, `use_sample_bpm` and `with_sample_bpm`.
# @accepts_block false
# @introduced 2.6.0
# @example
#   use_bpm 60
#     puts current_beat_duration #=> 1
#   
#     use_bpm 120
#     puts current_beat_duration #=> 0.5
#
def current_beat_duration
  #This is a stub, used for indexing
end

# Get current tempo
# Returns the current tempo as a bpm value.
# 
# This can be set via the fns `use_bpm`, `with_bpm`, `use_sample_bpm` and `with_sample_bpm`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts current_bpm # Print out the current bpm
#
def current_bpm
  #This is a stub, used for indexing
end

# Get current cent shift
# Returns the cent shift value.
# 
# This can be set via the fns `use_cent_tuning` and `with_cent_tuning`.
# @accepts_block false
# @introduced 2.9.0
# @example
#   puts current_cent_tuning # Print out the current cent shift
#
def current_cent_tuning
  #This is a stub, used for indexing
end

# Get current debug status
# Returns the current debug setting (`true` or `false`).
# 
# This can be set via the fns `use_debug` and `with_debug`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts current_debug # Print out the current debug setting
#
def current_debug
  #This is a stub, used for indexing
end

# Get current MIDI defaults
# Returns the current MIDI defaults. This is a map of opt names to values
# 
# This can be set via the fns `use_midi_defaults`, `with_midi_defaults`, `use_merged_midi_defaults` and `with_merged_midi_defaults`.
# @accepts_block false
# @introduced 3.0.0
# @example
#   use_midi_defaults channel: 1, port: "foo"
#   midi_note_on :e1 # Sends MIDI :e1 note on to channel 1 on port "foo"
#   current_midi_defaults #=> Prints {channel: 1, port: "foo"}
#
def current_midi_defaults
  #This is a stub, used for indexing
end

# Get current octave shift
# Returns the octave shift value.
# 
# This can be set via the fns `use_octave` and `with_octave`.
# @accepts_block false
# @introduced 2.9.0
# @example
#   puts current_octave # Print out the current octave shift
#
def current_octave
  #This is a stub, used for indexing
end

# Get current random seed
# Returns the current random seed.
# 
# This can be set via the fns `use_random_seed` and `with_random_seed`. It is incremented every time you use the random number generator via fns such as `choose` and `rand`.
# @accepts_block false
# @introduced 2.10.0
# @example
#   puts current_random_seed # Print out the current random seed
#
# @example
#   ## Resetting the seed back to a known place
#   puts rand               #=>  0.75006103515625
#   puts rand               #=>  0.733917236328125
#   a = current_random_seed # Grab the current seed
#   puts rand               #=> 0.464202880859375
#   puts rand               #=> 0.24249267578125
#   use_random_seed a       # Restore the seed
#                           # we'll now get the same random values:
#   puts rand               #=> 0.464202880859375
#   puts rand               #=> 0.24249267578125
#
def current_random_seed
  #This is a stub, used for indexing
end

# Get current sample defaults
# Returns the current sample defaults. This is a map of synth arg names to either values or functions.
# 
# This can be set via the fns `use_sample_defaults`, `with_sample_defaults`, `use_merged_sample_defaults` and `with_merged_sample_defaults`.
# @accepts_block false
# @introduced 2.5.0
# @example
#   use_sample_defaults amp: 0.5, cutoff: 80
#   sample :loop_amen # Plays amen break with amp 0.5 and cutoff 80
#   puts current_sample_defaults #=> Prints {amp: 0.5, cutoff: 80}
#
def current_sample_defaults
  #This is a stub, used for indexing
end

# Get current sched ahead time
# Returns the current schedule ahead time.
# 
# This can be set via the fn `set_sched_ahead_time!`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   set_sched_ahead_time! 0.5
#   puts current_sched_ahead_time # Prints 0.5
#
def current_sched_ahead_time
  #This is a stub, used for indexing
end

# Get current synth
# Returns the current synth name.
# 
# This can be set via the fns `use_synth` and `with_synth`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts current_synth # Print out the current synth name
#
def current_synth
  #This is a stub, used for indexing
end

# Get current synth defaults
# Returns the current synth defaults. This is a map of synth arg names to values.
# 
# This can be set via the fns `use_synth_defaults`, `with_synth_defaults`, `use_merged_synth_defaults` and `with_merged_synth_defaults`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   use_synth_defaults amp: 0.5, cutoff: 80
#   play 50 # Plays note 50 with amp 0.5 and cutoff 80
#   puts current_synth_defaults #=> Prints {amp: 0.5, cutoff: 80}
#
def current_synth_defaults
  #This is a stub, used for indexing
end

# Get current (logically quantized) time
# Returns the current logical time. This is a 'wall-clock' time which should typically be pretty similar to Time.now but quantised to a nearby sleep point in the thread. May be quite different to Time.now within a time_warp!
# 
# Unlike `Time.now`, Multiple calls to `current_time` with no interleaved calls to `sleep` or `sync` will return the same value.
# @accepts_block false
# @introduced 3.0.0
# @example
#   puts current_time # 2017-03-19 23:37:57 +0000
#
# @example
#   # The difference between current_time and Time.now
#   # See that Time.now is continuous and current_time is discrete
#   #
#   # {run: 19, time: 0.0}
#   puts "A", Time.now.to_f # ├─ "A" 1489966042.761211
#   puts "B", __system_thread_locals.get(:sonic_pi_spider_time).to_f # ├─ "B" 1489966042.760181
#   puts "C", Time.now.to_f # ├─ "C" 1489966042.761235
#   puts "D", __system_thread_locals.get(:sonic_pi_spider_time).to_f # ├─ "D" 1489966042.760181
#   puts "E", __system_thread_locals.get(:sonic_pi_spider_time).to_f # └─ "E" 1489966042.760181
#
def current_time
  #This is a stub, used for indexing
end

# Get current transposition
# Returns the current transpose value.
# 
# This can be set via the fns `use_transpose` and `with_transpose`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts current_transpose # Print out the current transpose value
#
def current_transpose
  #This is a stub, used for indexing
end

# Get current volume
# Returns the current volume.
# 
# This can be set via the fn `set_volume!`.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts current_volume # Print out the current volume
#
# @example
#   set_volume! 2
#   puts current_volume #=> 2
#
def current_volume
  #This is a stub, used for indexing
end

# Decrement
# Decrement a number by `1`. Equivalent to `n - 1`
# @param _n [number]
# @accepts_block false
# @introduced 2.1.0
# @example
#   dec 1 # returns 0
#
# @example
#   dec -1 # returns -2
#
def dec(_n = nil)
  #This is a stub, used for indexing
end

# Define a new function
# Allows you to group a bunch of code and give it your own name for future re-use. Functions are very useful for structuring your code. They are also the gateway into live coding as you may redefine a function whilst a thread is calling it, and the next time the thread calls your function, it will use the latest definition.
# @param _name [symbol]
# @accepts_block true
# @introduced 2.0.0
# @example
#   # Define a new function called foo
#     define :foo do
#       play 50
#       sleep 1
#     end
#   
#     # Call foo on its own
#     foo
#   
#     # You can use foo anywhere you would use normal code.
#     # For example, in a block:
#     3.times do
#       foo
#     end
#
def define(_name = nil)
  #This is a stub, used for indexing
end

# Define a named value only once
# Allows you to assign the result of some code to a name, with the property that the code will only execute once - therefore stopping re-definitions. This is useful for defining values that you use in your compositions but you don't want to reset every time you press run. You may force the block to execute again regardless of whether or not it has executed once already by using the override option (see examples).
# @param _name [symbol]
# @param override If set to true, re-definitions are allowed and this acts like define
# @accepts_block true
# @introduced 2.0.0
# @example
#   defonce :foo do  # Define a new function called foo
#       sleep 1        # Sleep for a beat in the function definition. Note that this amount
#                      # of time in seconds will depend on the current BPM of the live_loop
#                      # or thread calling this function.
#       puts "hello" # Print hello
#       10             # Return a value of 10
#     end
#   
#     # Call foo on its own
#     puts foo # The run sleeps for a beat and prints "hello" before returning 10
#   
#     # Try it again:
#     puts foo # This time the run doesn't sleep or print anything out. However, 10 is still returned.
#   
#   
#   
#     defonce :foo do # Try redefining foo
#       puts "you can't redefine me"
#       15
#     end
#   
#     puts foo # We still don't see any printing or sleeping, and the result is still 10
#   
#     # You can use foo anywhere you would use normal code.
#     # For example, in a block:
#     3.times do
#       play foo  # play 10
#     end
#
# @example
#   defonce :bar do
#       50
#     end
#   
#     play bar # plays 50
#   
#     defonce :bar do # This redefinition doesn't work due to the behaviour of defonce
#       70
#     end
#   
#     play bar # Still plays 50
#   
#     defonce :bar, override: true do  # Force definition to take place with override option
#       80
#     end
#   
#     play bar # plays 80
#
def defonce(_name = nil, override: nil)
  #This is a stub, used for indexing
end

# Convert a degree into a note
# For a given scale and tonic it takes a symbol `:i`, `:ii`, `:iii`, `:iv`,`:v`, `:vi`, `:vii` or a number `1`-`7` and resolves it to a midi note.
# @param _degree [symbol_or_number]
# @param _tonic [symbol]
# @param _scale [symbol]
# @accepts_block false
# @introduced 2.1.0
# @example
#   play degree(:ii, :D3, :major)
#   play degree(2, :C3, :minor)
#
def degree(_degree = nil, _tonic = nil, _scale = nil)
  #This is a stub, used for indexing
end

# Squash and repeat time
# Runs the block `d` times with the bpm for the block also multiplied by `d`. Great for repeating sections a number of times faster yet keeping within a fixed time. If `d` is less than 1, then time will be stretched accordingly and the block will take longer to complete.
# @param _d [density]
# @accepts_block true
# @introduced 2.3.0
# @example
#   use_bpm 60   # Set the BPM to 60
#   
#     density 2 do       # BPM for block is now 120
#                        # block is called 2.times
#       sample :bd_haus # sample is played twice
#       sleep 0.5        # sleep is 0.25s
#     end
#
# @example
#   density 2 do |idx| # You may also pass a param to the block similar to n.times
#       puts idx         # prints out 0, 1
#       sleep 0.5        # sleep is 0.25s
#     end
#
# @example
#   density 0.5 do          # Specifying a density val of < 1 will stretch out time
#                             # A density of 0.5 will double the length of the block's
#                             # execution time.
#       play 80, release: 1   # plays note 80 with 2s release
#       sleep 0.5             # sleep is 1s
#     end
#
def density(_d = nil)
  #This is a stub, used for indexing
end

# Random dice throw
# Throws a dice with the specified num_sides (defaults to `6`) and returns the score as a number between `1` and `num_sides`.
# @param _num_sides [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   dice # will return a number between 1 and 6 inclusively
#          # (with an even probability distribution).
#
# @example
#   dice 3 # will return a number between 1 and 3 inclusively
#
def dice(_num_sides = nil)
  #This is a stub, used for indexing
end

# Create a ring of successive doubles
# Create a ring containing the results of successive doubling of the `start` value. If `num_doubles` is negative, will return a ring of `halves`.
# @param _start [number]
# @param _num_doubles [int]
# @accepts_block false
# @introduced 2.10.0
# @example
#   (doubles 60, 2)  #=> (ring 60, 120)
#
# @example
#   (doubles 1.5, 3) #=> (ring 1.5, 3, 6)
#
# @example
#   (doubles 1.5, 5) #=> (ring 1.5, 3, 6, 12, 24)
#
# @example
#   (doubles 100, -4) #=> (ring 100, 50, 25, 12.5)
#
def doubles(_start = nil, _num_doubles = nil)
  #This is a stub, used for indexing
end

# Factor test
# Test to see if factor is indeed a factor of `val`. In other words, can `val` be divided exactly by factor.
# @param _val [number]
# @param _factor [number]
# @accepts_block false
# @introduced 2.1.0
# @example
#   factor?(10, 2) # true - 10 is a multiple of 2 (2 * 5 = 10)
#
# @example
#   factor?(11, 2) #false - 11 is not a multiple of 2
#
# @example
#   factor?(2, 0.5) #true - 2 is a multiple of 0.5 (0.5 * 4 = 2)
#
def factor?(_val = nil, _factor = nil)
  #This is a stub, used for indexing
end

# Get all FX names
# Return a list of all the FX available
# @accepts_block false
# @introduced 2.10.0
def fx_names
  #This is a stub, used for indexing
end

# Get information from the Time State
# Retrieve information from Time State set prior to the current time from either the current or any other thread. If called multiple times will always return the same value unless a call to `sleep`, `sync`, `set` or `cue` is interleaved. Also, calls to `get` will always return the same value across Runs for deterministic behaviour - which means you may safely use it in your compositions for repeatable music.
# 
# May be used within a `time_warp` to retrieve past events. If in a time warp, `get` can not be called from a future position. Does not advance time.
# @param _time_state_key [default]
# @accepts_block false
# @introduced 3.0.0
# @example
#   get :foo #=> returns the last value set as :foo, or nil
#
# @example
#   set :foo, 3
#   get[:foo] #=> returns 3
#
# @example
#   in_thread do
#     set :foo, 3
#   end
#   
#   in_thread do
#     puts get[:foo]  #=> always returns 3 (no race conditions here!)
#   end
#
def get(_time_state_key = nil)
  #This is a stub, used for indexing
end

# Create a ring of successive halves
# Create a ring containing the results of successive halving of the `start` value. If `num_halves` is negative, will return a ring of `doubles`.
# @param _start [number]
# @param _num_halves [int]
# @accepts_block false
# @introduced 2.10.0
# @example
#   (halves 60, 2)  #=> (ring 60, 30)
#
# @example
#   (halves 120, 3) #=> (ring 120, 60, 30)
#
# @example
#   (halves 120, 5) #=> (ring 120, 60, 30, 15, 7.5)
#
# @example
#   (halves 30, -5) #=> (ring 30, 60, 120, 240, 480)
#
def halves(_start = nil, _num_halves = nil)
  #This is a stub, used for indexing
end

# Hz to MIDI conversion
# Convert a frequency in hz to a midi note. Note that the result isn't an integer and there is a potential for some very minor rounding errors.
# @param _freq [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   hz_to_midi(261.63) #=> 60.0003
#
def hz_to_midi(_freq = nil)
  #This is a stub, used for indexing
end

# Run code block at the same time
# Execute a given block (between `do` ... `end`) in a new thread. Use for playing multiple 'parts' at once. Each new thread created inherits all the use/with defaults of the parent thread such as the time, current synth, bpm, default synth args, etc. Despite inheriting defaults from the parent thread, any modifications of the defaults in the new thread will *not* affect the parent thread. Threads may be named with the `name:` optional arg. Named threads will print their name in the logging pane when they print their activity. If you attempt to create a new named thread with a name that is already in use by another executing thread, no new thread will be created.
# 
# It is possible to delay the initial trigger of the thread on creation with both the `delay:` and `sync:` opts. See their respective docstrings. If both `delay:` and `sync:` are specified, on initial thread creation first the delay will be honoured and then the sync.
# @param name Make this thread a named thread with name. If a thread with this name already exists, a new thread will not be created.
# @param delay Initial delay in beats before the thread starts. Default is 0.
# @param sync Initial sync symbol. Will sync with this symbol before the thread starts.
# @param sync_bpm Initial sync symbol. Will sync with this symbol before the live_loop starts. Live loop will also inherit the BPM of the thread which cued the symbol.
# @accepts_block true
# @introduced 2.0.0
# @example
#   loop do      # If you write two loops one after another like this,
#       play 50    # then only the first loop will execute as the loop acts
#       sleep 1    # like a trap not letting the flow of control out
#     end
#   
#     loop do      # This code is never executed.
#       play 55
#       sleep 0.5
#     end
#
# @example
#   # In order to play two loops at the same time, the first loops need to
#     # be in a thread (note that it's probably more idiomatic to use live_loop
#     # when performing):
#   
#     # By wrapping our loop in an in_thread block, we split the
#     # control flow into two parts. One flows into the loop (a) and
#     # the other part flows immediately after the in_thread block (b).
#     # both parts of the control flow execute at exactly the same time.
#   
#     in_thread do
#       # (a)
#       loop do
#         # (a)
#         play 50
#         sleep 1
#       end
#     end
#   
#     # (b)
#   
#     loop do      # This loop is executed thanks to the thread above
#       play 55
#       sleep 0.5
#     end
#
# @example
#   use_bpm 120  # Set the bpm to be double rate
#     use_synth :dsaw  # Set the current synth to be :dsaw
#   
#     in_thread do     # Create a new thread
#       play 50        # Play note 50 at time 0
#       use_synth :fm  # Switch to fm synth (only affects this thread)
#       sleep 1        # sleep for 0.5 seconds (as we're double rate)
#       play 38        # Play note 38 at time 0.5
#     end
#   
#     play 62          # Play note 62 at time 0 (with dsaw synth)
#     sleep 2          # sleep 1s
#     play 67          # Play note 67 at time 1s (also with dsaw synth)
#
# @example
#   in_thread(name: :foo) do # Here we've created a named thread
#       loop do
#         sample :drum_bass_hard
#         sleep 1
#       end
#     end
#   
#     in_thread(name: :foo) do # This thread isn't created as the name is
#       loop do                # the same as the previous thread which is
#         sample :elec_chime   # still executing.
#         sleep 0.5
#       end
#     end
#
# @example
#   # Named threads work well with functions for live coding:
#     define :foo do  # Create a function foo
#       play 50       # which does something simple
#       sleep 1       # and sleeps for some time
#     end
#   
#     in_thread(name: :main) do  # Create a named thread
#       loop do                  # which loops forever
#         foo                    # calling our function
#       end
#     end
#   
#     # We are now free to modify the contents of :foo and re-run the entire buffer.
#     # We'll hear the effect immediately without having to stop and re-start the code.
#     # This is because our fn has been redefined, (which our thread will pick up) and
#     # due to the thread being named, the second re-run will not create a new similarly
#     # named thread. This is a nice pattern for live coding and is the basis of live_loop.
#
# @example
#   #Delaying the start of a thread
#     in_thread delay: 1 do
#       sample :ambi_lunar_land # this sample is not triggered at time 0 but after 1 beat
#     end
#   
#     play 80                   # Note 80 is played at time 0
#
def in_thread(name: nil, delay: nil, sync: nil, sync_bpm: nil)
  #This is a stub, used for indexing
end

# Increment
# Increment a number by `1`. Equivalent to `n + 1`
# @param _n [number]
# @accepts_block false
# @introduced 2.1.0
# @example
#   inc 1 # returns 2
#
# @example
#   inc -1 # returns 0
#
def inc(_n = nil)
  #This is a stub, used for indexing
end

# Kill synth
# Kill a running synth sound or sample. In order to kill a sound, you need to have stored a reference to it in a variable.
# @param _node [synth_node]
# @accepts_block false
# @introduced 2.0.0
# @example
#   # store a reference to a running synth in a variable called foo:
#   foo = play 50, release: 4
#   sleep 1
#   # foo is still playing, but we can kill it early:
#   kill foo
#
# @example
#   bar = sample :loop_amen
#   sleep 0.5
#   kill bar
#
def kill(_node = nil)
  #This is a stub, used for indexing
end

# Knit a sequence of repeated values
# Knits a series of value, count pairs to create a ring buffer where each value is repeated count times.
# @param _value [anything]
# @param _count [number]
# @accepts_block false
# @introduced 2.2.0
# @example
#   (knit 1, 5)    #=> (ring 1, 1, 1, 1, 1)
#
# @example
#   (knit :e2, 2, :c2, 3) #=> (ring :e2, :e2, :c2, :c2, :c2)
#
def knit(_value = nil, _count = nil)
  #This is a stub, used for indexing
end

# Create a ring buffer representing a straight line
# Create a ring buffer representing a straight line between start and finish of num_slices elements. Num slices defaults to `8`. Indexes wrap around positively and negatively. Similar to `range`.
# @param _start [number]
# @param _finish [number]
# @param steps number of slices or segments along the line
# @param inclusive boolean value representing whether or not to include finish value in line
# @accepts_block false
# @introduced 2.5.0
# @example
#   (line 0, 4, steps: 4)    #=> (ring 0.0, 1.0, 2.0, 3.0)
#
# @example
#   (line 5, 0, steps: 5)    #=> (ring 5.0, 4.0, 3.0, 2.0, 1.0)
#
# @example
#   (line 0, 3, inclusive: true) #=> (ring 0.0, 1.0, 2.0, 3.0)
#
def line(_start = nil, _finish = nil, steps: nil, inclusive: nil)
  #This is a stub, used for indexing
end

# A named audio stream live from your soundcard
# Create a named synthesiser which works similar to `play`, `sample` or `synth`. Rather than synthesising the sound mathematically or playing back recorded audio, it streams audio live from your sound card.
# 
# However, unlike `play`, `sample` and `synth`, which allow multiple similar synths to play at the same time (i.e. a chord) only one `live_audio` synth of a given name may exist in the system at any one time. This is similar to `live_loop` where only one live loop of each name may exist at any one time. See examples for further information.
# 
# An additional difference is that `live_audio` will create an infinitely long synth rather than be timed to an envelope like the standard `synth` and `sample` synths. This is particularly suitable for working with continuous incoming audio streams where the source of the audio is unknown (for example, it may be a guitar, an analog synth or an electronic violin). If the source is continuous, then it may not be suited to being stitched together by successive enveloped calls to something like: `synth :sound_in, attack: 0, sustain: 4, release: 0`. If we were to `live_loop` this with a `sleep 4` to match the sustain duration, we would get something that emulated a continuous stream, but for certain inputs you'll hear clicking at the seams between each successive call to `synth` where the final part of the audio signal from the previous synth doesn't precisely match up with the start of the signal in the next synth due to very minor timing differences.
# 
# Another important feature of `live_audio` is that it will automatically move an existing `live_audio` synth into the current FX context. This means you can live code the FX chain around the live stream and it will update automatically. See examples.
# 
# To stop a `live_audio` synth, use the `:stop` arg: `live_audio :foo, :stop`.
# .
# @accepts_block false
# @introduced 3.0.0
# @example
#   # Basic usage
#   live_audio :foo  # Play whatever audio is coming into the sound card on input 1
#
# @example
#   # Specify an input
#   live_audio :foo, input: 3  # Play whatever audio is coming into the sound card on input 3
#
# @example
#   # Work with stereo input
#   live_audio :foo, input: 3, stereo: true  # Play whatever audio is coming into the sound card on inputs 3 and 4
#                                            # as a stereo stream
#
# @example
#   # Switching audio contexts (i.e. changing FX)
#   live_audio :guitar     # Play whatever audio is coming into the sound card on input 1
#   
#   sleep 2                # Wait for 2 seconds then...
#   
#   with_fx :reverb do
#     live_audio :guitar   # Add reverb to the audio from input 1
#   end
#   
#   sleep 2                # Wait for another 2 seconds then...
#   
#   live_audio :guitar     # Remove the reverb from input 1
#
# @example
#   # Working with live_loops
#   
#   live_loop :foo do
#     with_fx [:reverb, :distortion, :echo].choose do   # chooses a new FX each time round the live loop
#       live_audio :voice                               # the audio stream from input 1 will be moved to the
#     end                                               # new FX and the old FX will complete and finish as normal.
#     sleep 8
#   end
#
# @example
#   # Stopping
#   
#   live_audio :foo            #=> start playing audio from input 1
#   live_audio :bar, input: 2  #=> start playing audio from input 2
#   
#   sleep 3                    #=> wait for 3s...
#   
#   live_audio :foo, :stop     #=> stop playing audio from input 1
#                              #=> (live_audio :bar is still playing)
#
def live_audio
  #This is a stub, used for indexing
end

# A loop for live coding
# Loop the do/end block forever. However, unlike a basic loop, a live_loop has two special properties. Firstly it runs in a thread - so you can have any number of live loops running at the same time (concurrently). Secondly, you can change the behaviour of a live loop whilst it is still running without needing to stop it. Live loops are therefore the secret to live coding with Sonic Pi.
# 
# As live loops are excecuted within a named in_thread, they behave similarly. See the in_thread documentation for all the details. However, it's worth mentioning a few important points here. Firstly, only one live loop with a given name can run at any one time. Therefore, if you define two or more `live_loop`s called `:foo` only one will be running. Another important aspect of `live_loop`s is that they manage their own thread locals set with the `use_*` and `with_*` fns. This means that each `live_loop` can have its own separate default synth, BPM and sample defaults. When a `live_loop` is *first* created, it inherits the thread locals from the parent thread, but once it has started, the only way to change them is by re-defining the do/end body of the `live_loop`. See the examples below for details. Finally, as mentioned above, provided their names are different, you may have many `live_loop`s executing at once.
# 
# A typical way of live coding with live loops is to define a number of them in a buffer, hit Run to start them and then to modify their do/end blocks and then hit Run again. This will not create any more thread, but instead just modify the behaviour of the existing threads. The changes will *not* happen immediately. Instead, they will only happen the next time round the loop. This is because the behaviour of each live loop is implemented with a standard function. When a live loop is updated, the function definition is also updated. Each time round the live loop, the function is called, so the new behviour is only observed next time round the loop.
# 
# Also sends a `cue` with the same name each time the `live_loop` repeats. This may be used to `sync` with other threads and `live_loop`s.
# 
# If the `live_loop` block is given a parameter, this is given the result of the last run of the loop (with initial value either being `0` or an init arg). This allows you to 'thread' values across loops.
# 
# Finally, it is possible to delay the initial trigger of the live_loop on creation with both the `delay:` and `sync:` opts. See their respective docstrings. If both `delay:` and `sync:` are specified, on initial live_loop creation first the delay will be honoured and then the sync.
# @param _name [symbol]
# @param init initial value for optional block arg
# @param auto_cue enable or disable automatic cue (default is true)
# @param delay Initial delay in beats before the live_loop starts. Default is 0.
# @param sync Initial sync symbol. Will sync with this symbol before the live_loop starts.
# @param sync_bpm Initial sync symbol. Will sync with this symbol before the live_loop starts. Live loop will also inherit the BPM of the thread which cued the symbol.
# @param seed override initial random generator seed before starting loop.
# @accepts_block true
# @introduced 2.1.0
# @example
#   ## Define and start a simple live loop
#   
#   live_loop :ping do  # Create a live loop called :ping
#     sample :elec_ping # This live loops plays the :elec_ping sample
#     sleep 1           # Then sleeps for 1 beat before repeating
#   end
#
# @example
#   ## Every live loop must sleep or sync
#   
#   live_loop :ping do  # Create a live loop called :ping
#     sample :elec_ping # This live loops plays the :elec_ping sample
#                       # However, because the do/end lock of the live loop does not
#                       # contain any calls to sleep or sync, the live loop stops at
#                       # the end of the first loop with a 'Did not sleep' error.
#   end
#
# @example
#   ## Multiple live loops will play at the same time
#   live_loop :foo do  # Start a live loop called :foo
#     play 70
#     sleep 1
#   end
#   
#   live_loop :bar do  # Start another live loop called :bar
#     sample :bd_haus  # Both :foo and :bar will be playing
#     sleep 0.5        # at the same time.
#   end
#
# @example
#   ## Live loops inherit external use_* thread locals
#   use_bpm 30
#   live_loop :foo do
#     play 70           # live loop :foo now has a BPM of 30
#     sleep 1           # This sleep will be for 2 seconds
#   end
#
# @example
#   ## Live loops can have their own thread locals
#   live_loop :foo do
#     use_bpm 30       # Set the BPM of live loop :foo to 30
#     play 70
#     sleep 1          # This sleep will be for 2 seconds
#   end
#   
#   live_loop :bar do
#     use_bpm 120      # Set the BPM of live loop :bar to 120
#     play 82
#     sleep 1          # This sleep will be for 0.5 seconds
#   end
#
# @example
#   ## Live loops can pass values between iterations
#   live_loop :foo do |a|  # pass a param (a) to the block (inits to 0)
#     puts a               # prints out all the integers
#     sleep 1
#     a += 1               # increment a by 1 (last value is passed back into the loop)
#   end
#
# @example
#   ## Live loop names must be unique
#   live_loop :foo do  # Start a live loop called :foo
#     play 70
#     sleep 1
#   end
#   
#   live_loop :foo do  # Attempt to start another also called :foo
#     sample :bd_haus  # With a different do/end block
#     sleep 0.5        # This will not start another live loop
#                      # but instead replace the behaviour of the first.
#   end                # There will only be one live loop running playing
#                      # The bass drum
#
# @example
#   ## You can sync multiple live loops together
#   live_loop :foo, sync: :bar do # Wait for a :bar cue event before starting :foo
#    play 70                      # Live loop :foo is therefore blocked and does
#    sleep 1                      # not make a sound initially
#   end
#   
#   sleep 4                       # Wait for 4 beats
#   
#   live_loop :bar do             # Start a live loop called :foo which will emit a :bar
#     sample :bd_haus             # cue message therefore releasing the :foo live loop.
#     sleep 0.5                   # Live loop :foo therefore starts and also inherits the
#   end                           # logical time of live loop :bar.
#   
#                                 # This pattern is also useful to re-sync live loops after
#                                 # errors are made. For example, when modifying live loop :foo
#                                 # it is possible to introduce a runtime error which will stop
#                                 # :foo but not :bar (as they are separate, isolated threads).
#                                 # Once the error has been fixed and the code is re-run, :foo
#                                 # will automatically wait for :bar to loop round and restart
#                                 # in sync with the correct virtual clock.
#
def live_loop(_name = nil, init: nil, auto_cue: nil, delay: nil, sync: nil, sync_bpm: nil, seed: nil)
  #This is a stub, used for indexing
end

# Load the contents of a file to the current buffer
# Given a path to a file, will read the contents and load it into the current buffer. This will replace any previous content.
# @param _path [string]
# @accepts_block false
# @introduced 2.10.0
# @example
#   load_buffer "~/sonic-pi-tracks/phat-beats.rb" # will replace content of current buffer with contents of the file
#
def load_buffer(_path = nil)
  #This is a stub, used for indexing
end

# Load a built-in example
# Given a keyword representing an example, will load it into the current buffer. This will replace any previous content.
# @param _path [string]
# @accepts_block false
# @introduced 2.10.0
# @example
#   load_example :rerezzed # will replace content of current buffer with the rerezzed example
#
def load_example(_path = nil)
  #This is a stub, used for indexing
end

# Pre-load first matching sample
# Given a path to a `.wav`, `.wave`, `.aif`, `.aiff`, `.ogg`, `.oga` or `.flac` file, pre-loads the sample into memory.
# 
# You may also specify the same set of source and filter pre-args available to `sample` itself. `load_sample` will then load all matching samples. See `sample`'s docs for more information.
# @param _path [string]
# @accepts_block false
# @introduced 2.0.0
# @example
#   load_sample :elec_blip # :elec_blip is now loaded and ready to play as a sample
#   sample :elec_blip # No delay takes place when attempting to trigger it
#
# @example
#   # Using source and filter pre-args
#   dir = "/path/to/sample/dir"
#   load_sample dir # loads first matching sample in "/path/to/sample/dir"
#   load_sample dir, 1 # loads sample with index 1 in "/path/to/sample/dir"
#   load_sample dir, :foo # loads sample with name "foo" in "/path/to/sample/dir"
#   load_sample dir, "quux" # loads first sample with file name containing "quux" in "/path/to/sample/dir"
#   load_sample dir, /[Bb]ar/ # loads first sample which matches regex /[Bb]ar/ in "/path/to/sample/dir"
#
def load_sample(_path = nil)
  #This is a stub, used for indexing
end

# Pre-load all matching samples
# Given a directory containing multiple `.wav`, `.wave`, `.aif`, `.aiff`, `.ogg`, `.oga` or `.flac` files, pre-loads all the samples into memory.
# 
#  You may also specify the same set of source and filter pre-args available to `sample` itself. `load_sample` will load all matching samples (not just the sample `sample` would play given the same opts) - see `sample`'s docs for more information.
# @param _paths [list]
# @accepts_block false
# @introduced 2.0.0
# @example
#   load_sample :elec_blip # :elec_blip is now loaded and ready to play as a sample
#    sample :elec_blip # No delay takes place when attempting to trigger it
#
# @example
#   # Using source and filter pre-args
#    dir = "/path/to/sample/dir"
#    load_sample dir # loads all samples in "/path/to/sample/dir"
#    load_sample dir, 1 # loads sample with index 1 in "/path/to/sample/dir"
#    load_sample dir, :foo # loads sample with name "foo" in "/path/to/sample/dir"
#    load_sample dir, "quux" # loads all samples with file names containing "quux" in "/path/to/sample/dir"
#    load_sample dir, /[Bb]ar/ # loads all samples which match regex /[Bb]ar/ in "/path/to/sample/dir"
#
def load_samples(_paths = nil)
  #This is a stub, used for indexing
end

# Load external synthdefs
# Load all pre-compiled synth designs in the specified directory. The binary files containing synth designs need to have the extension `.scsyndef`. This is useful if you wish to use your own SuperCollider synthesiser designs within Sonic Pi.
# 
# ## Important notes
# 
# You may not trigger external synthdefs unless you enable the following GUI preference:
# 
# ```
# Studio -> Synths and FX -> Enable external synths and FX
# ```
# 
# Also, if you wish your synth to work with Sonic Pi's automatic stereo sound infrastructure *you need to ensure your synth outputs a stereo signal* to an audio bus with an index specified by a synth arg named `out_bus`. For example, the following synth would work nicely:
# 
# 
#     (
#     SynthDef(\piTest,
#              {|freq = 200, amp = 1, out_bus = 0 |
#                Out.ar(out_bus,
#                       SinOsc.ar([freq,freq],0,0.5)* Line.kr(1, 0, 5, amp, doneAction: 2))}
#     ).writeDefFile("/Users/sam/Desktop/")
#     )
# 
# 
#     
# @param _path [string]
# @accepts_block false
# @introduced 2.0.0
# @example
#   load_synthdefs "~/Desktop/my_noises" # Load all synthdefs in my_noises folder
#
def load_synthdefs(_path = nil)
  #This is a stub, used for indexing
end

# Obtain value of a tick
# Read and return value of default tick. If a `key` is specified, read the value of that specific tick. Ticks are `in_thread` and `live_loop` local, so the tick read will be the tick of the current thread calling `look`.
# @param offset Offset to add to index returned. Useful when calling look on lists, rings and vectors to offset the returned value
# @accepts_block false
# @introduced 2.6.0
# @example
#   puts look #=> 0
#     puts look #=> 0
#     puts look #=> 0 # look doesn't advance the tick, it just returns the current value
#
# @example
#   puts look #=> 0 # A look is always 0 before the first tick
#     tick # advance the tick
#     puts look #=> 0 # Note: a look is still 0 after the first tick.
#     tick
#     puts look #=> 1
#     puts look #=> 1 # making multiple calls to look doesn't affect tick value
#     tick
#     puts look #=> 2
#
# @example
#   tick(:foo)
#     tick(:foo)
#     puts look(:foo) #=> 1 (keyed look :foo has been advanced)
#     puts look #=> 0 (default look hasn't been advanced)
#     puts look(:bar) #=> 0 (other keyed looks haven't been advanced either)
#
# @example
#   # You can call look on lists and rings
#     live_loop :foo do
#       tick                                      # advance the default tick
#       use_synth :beep
#       play (scale :e3, :minor_pentatonic).look  # look into the default tick to play all notes in sequence
#       sleep 0.5
#       use_synth :square
#       play (ring :e1, :e2, :e3).look, release: 0.25 # use the same look on another ring
#       sleep 0.25
#     end
#
# @example
#   # Returns numbers unchanged if single argument
#   puts look(0)     #=> 0
#   puts look(4)     #=> 4
#   puts look(-4)    #=> -4
#   puts look(20.3)  #=> 20.3
#
def look(offset: nil)
  #This is a stub, used for indexing
end

# Repeat do/end block forever
# Given a do/end block, repeats it forever. Note that once the program enters the loop - it will not move on but will instead stay within the loop. Plain loops like this are like black holes - instead of sucking in the light they suck in the program.
# 
# The loop must either `sleep` or `sync` each time round otherwise it will stop and throw an error. This is to stop the loop from spinning out of control and locking the system.
# 
# For a more powerful, flexible loop built for live coding see `live_loop`.
# @accepts_block true
# @introduced 2.0.0
# @example
#   play 70       # note 70 is played
#   
#   loop do
#     play 50     # This loop will repeat notes 50 and 62 forever
#     sleep 1
#     play 62
#     sleep 2
#   end
#   
#   play 80      # This is *never* played as the program is trapped in the loop above
#
def loop
  #This is a stub, used for indexing
end

# Create an immutable map
# Create a new immutable key/value map from args. 
# @param _list [array]
# @accepts_block false
# @introduced 2.11.0
# @example
#   (map foo: 1, bar: 2)[:foo] #=> 1
#
# @example
#   (map foo: 1, bar: 2)[:bar] #=> 2
#
# @example
#   (map foo: 1, bar: 2)[:quux] #=> nil
#
def map(_list = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - normalise block code
# Given a block name or id will return a number representing the id of the block or throw an exception if the name or id isn't valid
# @param _name [symbol_or_number]
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_block_id :air #=> 0
#
# @example
#   puts mc_block_id 0  #=> 0
#
# @example
#   puts mc_block_id 19 #=> Throws an invalid block id exception
#
# @example
#   puts mc_block_id :foo #=> Throws an invalid block name exception
#
def mc_block_id(_name = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - list all block ids
# Returns a list of all the valid block ids as numbers. Note not all numbers are valid block ids. For example, 19 is not a valid block id.
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_block_ids #=> [0, 1, 2, 3, 4, 5...
#
def mc_block_ids
  #This is a stub, used for indexing
end

# Minecraft Pi - normalise block name
# Given a block id or a block name will return a symbol representing the block name or throw an exception if the id or name isn't valid.
# @param _id [number_or_symbol]
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_block_name :air #=> :air
#
# @example
#   puts mc_block_name 0   #=> :air
#
# @example
#   puts mc_block_name 19 #=> Throws an invalid block id exception
#
# @example
#   puts mc_block_name :foo #=> Throws an invalid block name exception
#
def mc_block_name(_id = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - list all block names
# Returns a list of all the valid block names as symbols
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_block_names #=> [:air, :stone, :grass, :dirt, :cobblestone...
#
def mc_block_names
  #This is a stub, used for indexing
end

# Minecraft Pi - fixed camera mode
# Set the camera mode to fixed.
# @accepts_block false
# @introduced 2.5.0
# @example
#
def mc_camera_fixed
  #This is a stub, used for indexing
end

# Minecraft Pi - normal camera mode
# Set the camera mode to normal.
# @accepts_block false
# @introduced 2.5.0
# @example
#
def mc_camera_normal
  #This is a stub, used for indexing
end

# Minecraft Pi - move camera
# Move the camera to a new location.
# @accepts_block false
# @introduced 2.5.0
# @example
#
def mc_camera_set_location
  #This is a stub, used for indexing
end

# Minecraft Pi - third person camera mode
# Set the camera mode to third person
# @accepts_block false
# @introduced 2.5.0
# @example
#
def mc_camera_third_person
  #This is a stub, used for indexing
end

# Minecraft Pi - synonym for mc_message
# See mc_message
# @accepts_block false
# @introduced 2.5.0
def mc_chat_post
  #This is a stub, used for indexing
end

# Minecraft Pi - restore checkpoint
# Restore the world to the last snapshot taken with `mc_checkpoint_save`.
# @accepts_block false
# @introduced 2.5.0
# @example
#
def mc_checkpoint_restore
  #This is a stub, used for indexing
end

# Minecraft Pi - save checkpoint
# Take a snapshot of the world and save it. Restore back with `mc_checkpoint_restore`
# @accepts_block false
# @introduced 2.5.0
# @example
#
def mc_checkpoint_save
  #This is a stub, used for indexing
end

# Minecraft Pi - get type of block at coords
# Returns the type of the block at the coords `x`, `y`, `z` as a symbol.
# @param _x [number]
# @param _y [number]
# @param _z [number]
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_get_block 40, 50, 60 #=> :air
#
def mc_get_block(_x = nil, _y = nil, _z = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - synonym for mc_ground_height
# See `mc_ground_height`
# @accepts_block false
# @introduced 2.5.0
def mc_get_height
  #This is a stub, used for indexing
end

# Minecraft Pi - synonym for mc_location
# See `mc_location`
# @accepts_block false
# @introduced 2.5.0
def mc_get_pos
  #This is a stub, used for indexing
end

# Minecraft Pi - get location of current tile/block
# Returns the coordinates of the nearest block that the player is next to. This is more course grained than `mc_location` as it only returns whole number coordinates.
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_get_tile #=> [10, 20, 101]
#
def mc_get_tile
  #This is a stub, used for indexing
end

# Minecraft Pi - get ground height at x, z coords
# Returns the height of the ground at the specified `x` and `z` coords.
# @param _x [number]
# @param _z [number]
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_ground_height 40, 50 #=> 43 (height of world at x=40, z=50)
#
def mc_ground_height(_x = nil, _z = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - get current location
# Returns a list of floats `[x, y, z]` coords of the current location for Steve. The coordinates are finer grained than raw block coordinates but may be used anywhere you might use block coords.
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts mc_location    #=> [10.1, 20.67, 101.34]
#
# @example
#   x, y, z = mc_location       #=> Find the current location and store in x, y and z variables.
#
def mc_location
  #This is a stub, used for indexing
end

# Minecraft Pi - post a chat message
# Post contents of `msg` on the Minecraft chat display. You may pass multiple arguments and all will be joined to form a single message (with spaces).
# @param _msg [string]
# @accepts_block false
# @introduced 2.5.0
# @example
#   mc_message "Hello from Sonic Pi" #=> Displays "Hello from Sonic Pi" on Minecraft's chat display
#
def mc_message(_msg = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - set area of blocks
# Set an area/box of blocks of type `block_name` defined by two distinct sets of coordinates.
# @param _block_name [symbol_or_number]
# @param _x [number]
# @param _y [number]
# @param _z [number]
# @param _x2 [number]
# @param _y2 [number]
# @param _z2 [number]
# @accepts_block false
# @introduced 2.5.0
def mc_set_area(_block_name = nil, _x = nil, _y = nil, _z = nil, _x2 = nil, _y2 = nil, _z2 = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - set block at specific coord
# Change the block type of the block at coords `x`, `y`, `z` to `block_type`. The block type may be specified either as a symbol such as `:air` or a number. See `mc_block_ids` and `mc_block_types` for lists of valid symbols and numbers.
# @param _x [number]
# @param _y [number]
# @param _z [number]
# @param _block_name [symbol_or_number]
# @accepts_block false
# @introduced 2.5.0
# @example
#   mc_set_block :glass, 40, 50, 60 #=> set block at coords 40, 50, 60 to type glass
#
def mc_set_block(_x = nil, _y = nil, _z = nil, _block_name = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - synonym for mc_teleport
# See `mc_teleport`
# @accepts_block false
# @introduced 2.5.0
def mc_set_pos
  #This is a stub, used for indexing
end

# Minecraft Pi - set location to coords of specified tile/block
# @param _x [number]
# @param _y [number]
# @param _z [number]
# @accepts_block false
# @introduced 2.5.0
# @example
#
def mc_set_tile(_x = nil, _y = nil, _z = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - teleport to world surface at x and z coords
# Teleports you to the specified x and z coordinates with the y automatically set to place you on the surface of the world. For example, if the x and z coords target a mountain, you'll be placed on top of the mountain, not in the air or under the ground. See mc_ground_height for discovering the height of the ground at a given x, z point.
# @param _x [number]
# @param _z [number]
# @accepts_block false
# @introduced 2.5.0
# @example
#   mc_surface_teleport 40, 50 #=> Teleport user to coords x = 40, y = height of surface, z = 50
#
def mc_surface_teleport(_x = nil, _z = nil)
  #This is a stub, used for indexing
end

# Minecraft Pi - teleport to a new location
# Magically teleport the player to the location specified by the `x`, `y`, `z` coordinates. Use this for automatically moving the player either small or large distances around the world.
# @param _x [number]
# @param _y [number]
# @param _z [number]
# @accepts_block false
# @introduced 2.5.0
# @example
#   mc_teleport 40, 50, 60  # The player will be moved to the position with coords:
#                           # x: 40, y: 50, z: 60
#
def mc_teleport(_x = nil, _y = nil, _z = nil)
  #This is a stub, used for indexing
end

# Trigger and release an external synth via MIDI
# Sends a MIDI note on event to *all* connected MIDI devices and *all* channels and then after sustain beats sends a MIDI note off event. Ensures MIDI trigger is synchronised with standard calls to play and sample. Co-operates completely with Sonic Pi's timing system including `time_warp`.
# 
# If `note` is specified as `:off` then all notes will be turned off (same as `midi_all_notes_off`).
# @param _note [number]
# @param sustain Duration of note event in beats
# @param vel Velocity of note as a MIDI number
# @param on If specified and false/nil/0 will stop the midi on/off messages from being sent out. (Ensures all opts are evaluated in this call to `midi` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi :e1, sustain: 0.3, vel_f: 0.5, channel: 3 # Play E, octave 1 for 0.3 beats at half velocity on channel 3 on all connected MIDI ports.
#
# @example
#   midi :off, channel: 3 #=> Turn off all notes on channel 3 on all connected MIDI ports
#
# @example
#   midi :e1, channel: 3, port: "foo" #=> Play note :E1 for 1 beats on channel 3 on MIDI port named "foo" only
#
# @example
#   live_loop :arp do
#     midi (octs :e1, 3).tick, sustain: 0.1 # repeatedly play a ring of octaves
#     sleep 0.125
#   end
#
def midi(_note = nil, sustain: nil, vel: nil, on: nil)
  #This is a stub, used for indexing
end

# Turn off all notes on MIDI devices
# Sends a MIDI all notes off message to *all* connected MIDI devices. on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# When an All Notes Off event is received, all oscillators will turn off.
# 
# [MIDI 1.0 Specification - Channel Mode Messages - All Notes Off](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param channel Channel to send the all notes off message to
# @param port MIDI port to send to
# @param on If specified and false/nil/0 will stop the midi all notes off message from being sent out. (Ensures all opts are evaluated in this call to `midi_all_notes_off` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_all_notes_off #=> Turn off all notes on MIDI devices on all channels (and ports)
#
# @example
#   midi_all_notes_off channel: 2 #=> Turn off all notes on MIDI devices on channel 2
#
def midi_all_notes_off(channel: nil, port: nil, on: nil)
  #This is a stub, used for indexing
end

# Send MIDI control change message
# Sends a MIDI control change message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# Control number and control value can be passed as a note such as `:e3` and decimal values will be rounded down or up to the nearest whole number - so values between 3.5 and 4 will be rounded up to 4 and values between 3.49999... and 3 will be rounded down to 3.
# 
# You may also optionally pass the control value as a floating point value between 0 and 1 such as 0.2 or 0.785 (which will be mapped to MIDI values between 0 and 127) using the `val_f:` opt.
# 
# [MIDI 1.0 Specification - Channel Voice Messages - Control change](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _control_num [midi]
# @param _value [midi]
# @param channel Channel(s) to send to
# @param port MIDI port(s) to send to
# @param value Control value as a MIDI number.
# @param val_f Control value as a value between 0 and 1 (will be converted to a MIDI value)
# @param on If specified and false/nil/0 will stop the midi cc message from being sent out. (Ensures all opts are evaluated in this call to `midi_cc` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_cc 100, 32  #=> Sends MIDI cc message to control 100 with value 32 to all ports and channels
#
# @example
#   midi_cc :e7, 32  #=> Sends MIDI cc message to control 100 with value 32 to all ports and channels
#
# @example
#   midi_cc 100, 32, channel: 5  #=> Sends MIDI cc message to control 100 with value 32 on channel 5 to all ports
#
# @example
#   midi_cc 100, val_f: 0.8, channel: 5  #=> Sends MIDI cc message to control 100 with value 102 on channel 5 to all ports
#
# @example
#   midi_cc 100, value: 102, channel: [1, 5]  #=> Sends MIDI cc message to control 100 with value 102 on channel 1 and 5 to all ports
#
def midi_cc(_control_num = nil, _value = nil, channel: nil, port: nil, value: nil, val_f: nil, on: nil)
  #This is a stub, used for indexing
end

# Send MIDI channel pressure (aftertouch) message
# Sends a MIDI channel pressure (aftertouch) message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# The pressure value can be passed as a note such as `:e3` and decimal values will be rounded down or up to the nearest whole number - so values between 3.5 and 4 will be rounded up to 4 and values between 3.49999... and 3 will be rounded down to 3.
# 
# You may also optionally pass the pressure value as a floating point value between 0 and 1 such as 0.2 or 0.785 (which will be mapped to MIDI values between 0 and 127) using the `val_f:` opt.
# 
# [MIDI 1.0 Specification - Channel Voice Messages - Channel Pressure (Aftertouch)](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _val [midi]
# @param channel Channel(s) to send to
# @param port MIDI port(s) to send to
# @param value Pressure value as a MIDI number.
# @param val_f Pressure value as a value between 0 and 1 (will be converted to a MIDI value)
# @param on If specified and false/nil/0 will stop the midi channel pressure message from being sent out. (Ensures all opts are evaluated in this call to `midi_channel_pressure` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_channel_pressure 50  #=> Sends MIDI channel pressure message with value 50 to all ports and channels
#
# @example
#   midi_channel_pressure :C4  #=> Sends MIDI channel pressure message with value 60 to all ports and channels
#
# @example
#   midi_channel_pressure 0.5  #=> Sends MIDI channel pressure message with value 63.5 to all ports and channels
#
# @example
#   midi_channel_pressure 30, channel: [1, 5]  #=> Sends MIDI channel pressure message with value 30 on channel 1 and 5 to all ports
#
def midi_channel_pressure(_val = nil, channel: nil, port: nil, value: nil, val_f: nil, on: nil)
  #This is a stub, used for indexing
end

# Send a quarter-note's worth of MIDI clock ticks
# Sends enough MIDI clock ticks for one beat to *all* connected MIDI devices. Use the `port:` opt to restrict which MIDI ports are used.
# 
# The MIDI specification requires 24 clock tick events to be sent per beat. These can either be sent manually using `midi_clock_tick` or all 24 can be scheduled in one go using this fn. `midi_clock_beat` will therefore schedule for 24 clock ticks to be sent linearly spread over duration beats. This fn will automatically take into account the current BPM and any `time_warp`s.
# @param _duration [beats]
# @param port MIDI port to send to
# @param on If specified and false/nil/0 will stop the midi clock tick messages from being sent out. (Ensures all opts are evaluated in this call to `midi_clock_beat` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_clock_beat #=> Send 24 clock ticks over a period of 1 beat
#
# @example
#   midi_clock_beat 0.5 #=> Send 24 clock ticks over a period of 0.5 beats
#
# @example
#   live_loop :clock do  # Create a live loop which continually sends out MIDI clock
#     midi_clock_beat    # events at the current BPM
#     sleep 1
#   end
#
# @example
#   # Ensuring Clock Phase is Correct
#   live_loop :clock do
#     midi_start if tick == 0 # Send a midi_start event the first time round the live loop only
#     midi_clock_beat         # this will not just send a steady clock beat, but also ensure
#     sleep 1                 # the clock phase of the MIDI device matches Sonic Pi.
#   end
#
def midi_clock_beat(_duration = nil, port: nil, on: nil)
  #This is a stub, used for indexing
end

# Send an individual MIDI clock tick
# Sends a MIDI clock tick message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# Typical MIDI devices expect the clock to send 24 ticks per quarter note (typically a beat). See `midi_clock_beat` for a simple way of sending all the ticks for a given beat.
# 
# [MIDI 1.0 Specification - System Real-Time Messages - Timing Clock](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param port MIDI port to send to
# @param on If specified and false/nil/0 will stop the midi clock tick message from being sent out. (Ensures all opts are evaluated in this call to `midi_clock_tick` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_clock_tick #=> Send an individual clock tick to all connected MIDI devices on all ports.
#
def midi_clock_tick(port: nil, on: nil)
  #This is a stub, used for indexing
end

# Send MIDI system message - continue
# Sends the MIDI continue system message to *all* connected MIDI devices on *all* ports.  Use the `port:` opt to restrict which MIDI ports are used.
# 
# Upon receiving the MIDI continue event, the MIDI device(s) will continue at the point the sequence was stopped.
# 
# [MIDI 1.0 Specification - System Real-Time Messages - Continue](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param port MIDI Port(s) to send the continue message to
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_continue #=> Send continue message to all connected MIDI devices
#
def midi_continue(port: nil)
  #This is a stub, used for indexing
end

# Disable local control on MIDI devices
# Sends a MIDI local control off message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# All devices on a given channel will respond only to data received over MIDI. Played data, etc. will be ignored. See `midi_local_control_on` to enable local control.
# 
# [MIDI 1.0 Specification - Channel Mode Messages - Local Control Off](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param channel Channel to send the local control off message to
# @param port MIDI port to send to
# @param on If specified and false/nil/0 will stop the midi local control off message from being sent out. (Ensures all opts are evaluated in this call to `midi_local_control_off` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_local_control_off #=> Disable local control on MIDI devices on all channels (and ports)
#
# @example
#   midi_local_control_off channel: 2 #=> Disable local control on MIDI devices on channel 2
#
def midi_local_control_off(channel: nil, port: nil, on: nil)
  #This is a stub, used for indexing
end

# Enable local control on MIDI devices
# Sends a MIDI local control on message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# All devices on a given channel will respond both to data received over MIDI and played data, etc. See `midi_local_control_off` to disable local control.
# 
# [MIDI 1.0 Specification - Channel Mode Messages - Local Control On](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param channel Channel to send the local control on message to
# @param port MIDI port to send to
# @param on If specified and false/nil/0 will stop the midi local control on message from being sent out. (Ensures all opts are evaluated in this call to `midi_local_control_on` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_local_control_on #=> Enable local control on MIDI devices on all channels (and ports)
#
# @example
#   midi_local_control_on channel: 2 #=> Enable local control on MIDI devices on channel 2
#
def midi_local_control_on(channel: nil, port: nil, on: nil)
  #This is a stub, used for indexing
end

# Set Omni/Mono/Poly mode
# Sends the Omni/Mono/Poly MIDI mode message to *all* connected MIDI devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# Valid modes are:
# 
# :omni_off - Omni Mode Off
# :omni_on  - Omni Mode On
# :mono     - Mono Mode On (Poly Off). Set num_chans: to be the number of channels to use (Omni Off) or 0 (Omni On). Default for num_chans: is 16.
# :poly     - Poly Mode On (Mono Off)
# 
# Note that this fn also includes the behaviour of `midi_all_notes_off`.
# 
# [MIDI 1.0 Specification - Channel Mode Messages - Omni Mode Off | Omni Mode On | Mono Mode On (Poly Off) | Poly Mode On](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _mode [mode_keyword]
# @param channel Channel to send the MIDI mode message to
# @param port MIDI port to send to
# @param mode Mode keyword - one of :omni_off, :omni_on, :mono or :poly
# @param num_chans Used in mono mode only - Number of channels (defaults to 16)
# @param on If specified and false/nil/0 will stop the midi local control off message from being sent out. (Ensures all opts are evaluated in this call to `midi_local_control_off` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_mode :omni_on #=> Turn Omni Mode On on all ports and channels
#
# @example
#   midi_mode :mono, num_chans: 5 #=> Mono Mode On, Omni off using 5 channels.
#
# @example
#   midi_mode :mono, num_chans: 0 #=> Mono Mode On, Omni on.
#
# @example
#   midi_mode :mono #=> Mono Mode On, Omni off using 16 channels (the default) .
#
def midi_mode(_mode = nil, channel: nil, port: nil, mode: nil, num_chans: nil, on: nil)
  #This is a stub, used for indexing
end

# Send MIDI note off message
# Sends the MIDI note off message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# Note and release velocity values can be passed as a note symbol such as `:e3` or a number. Decimal values will be rounded down or up to the nearest whole number - so values between 3.5 and 4 will be rounded up to 4 and values between 3.49999... and 3 will be rounded down to 3. These values will also be clipped within the range 0->127 so all values lower then 0 will be increased to 0 and all values greater than 127 will be reduced to 127.
# 
# The `release_velocity` param may be omitted - in which case it will default to 127 unless you supply it as a named opt via the keys `velocity:` or `vel_f:`.
# 
# You may also optionally pass the release velocity value as a floating point value between 0 and 1 such as 0.2 or 0.785 (which will be mapped to MIDI values between 0 and 127) using the `vel_f:` opt.
# 
# [MIDI 1.0 Specification - Channel Voice Messages - Note off event](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _note [midi]
# @param _release_velocity [midi]
# @param channel MIDI channel(s) to send event on as a number or list of numbers.
# @param port MIDI port(s) to send to as a string or list of strings.
# @param velocity Release velocity as a MIDI number.
# @param vel_f Release velocity as a value between 0 and 1 (will be converted to a MIDI velocity)
# @param on If specified and false/nil/0 will stop the midi note off message from being sent out. (Ensures all opts are evaluated in this call to `midi_note_off` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_note_off :e3 #=> Sends MIDI note off for :e3 with the default release velocity of 127 to all ports and channels
#
# @example
#   midi_note_off :e3, 12  #=> Sends MIDI note off on :e3 with velocity 12 on all channels
#
# @example
#   midi_note_off :e3, 12, channel: 3  #=> Sends MIDI note off on :e3 with velocity 12 to channel 3
#
# @example
#   midi_note_off :e3, velocity: 100 #=> Sends MIDI note on for :e3 with release velocity 100
#
# @example
#   midi_note_off :e3, vel_f: 0.8 #=> Scales release velocity 0.8 to MIDI value 102 and sends MIDI note off for :e3 with release velocity 102
#
# @example
#   midi_note_off 60.3, 50.5 #=> Rounds params up or down to the nearest whole number and sends MIDI note off for note 60 with velocity 51
#
# @example
#   midi_note_off :e3, channel: [1, 3, 5] #=> Send MIDI note off on :e3 to channels 1, 3, 5 on all connected ports
#
# @example
#   midi_note_off :e3, port: ["foo", "bar"] #=> Send MIDI note off on :e3 to on all channels on ports named "foo" and "bar"
#
# @example
#   midi_note_off :e3, channel: 1, port: "foo" #=> Send MIDI note off on :e3 only on channel 1 on port "foo"
#
def midi_note_off(_note = nil, _release_velocity = nil, channel: nil, port: nil, velocity: nil, vel_f: nil, on: nil)
  #This is a stub, used for indexing
end

# Send MIDI note on message
# Sends a MIDI Note On Event to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to indepently restrict which MIDI ports and channels are used.
# 
# Note and velocity values can be passed as a note symbol such as `:e3` or a MIDI number such as 52. Decimal values will be rounded down or up to the nearest whole number - so values between 3.5 and 4 will be rounded up to 4 and values between 3.49999... and 3 will be rounded down to 3. These values will also be clipped within the range 0->127 so all values lower than 0 will be increased to 0 and all values greater than 127 will be reduced to 127.
# 
# The `velocity` param may be omitted - in which case it will default to 127 unless you supply it as an opt via the keys `velocity:` or `vel_f:`.
# 
# You may also optionally pass the velocity value as a floating point value between 0 and 1 such as 0.2 or 0.785 (which will be linearly mapped to MIDI values between 0 and 127) using the vel_f: opt.
# 
# [MIDI 1.0 Specification - Channel Voice Messages - Note on event](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _note [midi]
# @param _velocity [midi]
# @param channel MIDI channel(s) to send event on
# @param port MIDI port(s) to send to
# @param velocity Note velocity as a MIDI number.
# @param vel_f Velocity as a value between 0 and 1 (will be converted to a MIDI velocity between 0 and 127)
# @param on If specified and false/nil/0 will stop the midi note on message from being sent out. (Ensures all opts are evaluated in this call to `midi_note_on` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_note_on :e3  #=> Sends MIDI note on :e3 with the default velocity of 12 to all ports and channels
#
# @example
#   midi_note_on :e3, 12  #=> Sends MIDI note on :e3 with velocity 12 to all channels
#
# @example
#   midi_note_on :e3, 12, channel: 3  #=> Sends MIDI note on :e3 with velocity 12 on channel 3
#
# @example
#   midi_note_on :e3, velocity: 100 #=> Sends MIDI note on for :e3 with velocity 100
#
# @example
#   midi_note_on :e3, vel_f: 0.8 #=> Scales velocity 0.8 to MIDI value 102 and sends MIDI note on for :e3 with velocity 102
#
# @example
#   midi_note_on 60.3, 50.5 #=> Rounds params up or down to the nearest whole number and sends MIDI note on for note 60 with velocity 51
#
# @example
#   midi_note_on :e3, channel: [1, 3, 5] #=> Send MIDI note :e3 on to channels 1, 3, 5 on all connected ports
#
# @example
#   midi_note_on :e3, port: ["foo", "bar"] #=> Send MIDI note :e3 on to on all channels on ports named "foo" and "bar"
#
# @example
#   midi_note_on :e3, channel: 1, port: "foo" #=> Send MIDI note :e3 on only on channel 1 on port "foo"
#
def midi_note_on(_note = nil, _velocity = nil, channel: nil, port: nil, velocity: nil, vel_f: nil, on: nil)
  #This is a stub, used for indexing
end

# Create a ring buffer of midi note numbers
# Create a new immutable ring buffer of notes from args. Indexes wrap around positively and negatively. Final ring consists only of MIDI numbers and nil.
# @param _list [array]
# @accepts_block false
# @introduced 2.7.0
# @example
#   (midi_notes :d3, :d4, :d5) #=> (ring 50, 62, 74)
#
# @example
#   (midi_notes :d3, 62,  nil) #=> (ring 50, 62, nil)
#
def midi_notes(_list = nil)
  #This is a stub, used for indexing
end

# Send MIDI program change message
# Sends a MIDI program change message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# Program number can be passed as a note such as `:e3` and decimal values will be rounded down or up to the nearest whole number - so values between 3.5 and 4 will be rounded up to 4 and values between 3.49999... and 3 will be rounded down to 3.
# 
# [MIDI 1.0 Specification - Channel Voice Messages - Program change](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _program_num [midi]
# @param channel Channel(s) to send to
# @param port MIDI port(s) to send to
# @param on If specified and false/nil/0 will stop the midi pc message from being sent out. (Ensures all opts are evaluated in this call to `midi_pc` regardless of value).
# @accepts_block false
# @introduced 3.0.2
# @example
#   midi_pc 100  #=> Sends MIDI pc message to all ports and channels
#
# @example
#   midi_pc :e7  #=> Sends MIDI pc message to all ports and channels
#
# @example
#   midi_pc 100, channel: 5  #=> Sends MIDI pc message on channel 5 to all ports
#
# @example
#   midi_pc 100, channel: 5  #=> Sends MIDI pc message on channel 5 to all ports
#
# @example
#   midi_pc 100, channel: [1, 5]  #=> Sends MIDI pc message on channel 1 and 5 to all ports
#
def midi_pc(_program_num = nil, channel: nil, port: nil, on: nil)
  #This is a stub, used for indexing
end

# Send MIDI pitch bend message
# Sends a MIDI pitch bend message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# Delta value is between 0 and 1 with 0.5 representing no pitch bend, 1 max pitch bend and 0 minimum pitch bend.
# 
# Typical MIDI values such as note or cc are represented with 7 bit numbers which translates to the range 0-127. This makes sense for keyboards which have at most 88 keys. However, it translates to a poor resolution when working with pitch bend. Therefore, pitch bend is unlike most MIDI values in that it has a much greater range: 0 - 16383 (by virtue of being represented by 14 bits).
# 
# * It is also possible to specify the delta value as a (14 bit) MIDI pitch bend value between 0 and 16383 using the `delta_midi:` opt.
# * When using the `delta_midi:` opt no pitch bend is the value 8192
# 
# [MIDI 1.0 Specification - Channel Voice Messages - Pitch Bend Change](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _delta [float01]
# @param channel Channel(s) to send to
# @param port MIDI port(s) to send to
# @param delta Pitch bend value as a number between 0 and 1 (will be converted to a value between 0 and 16383). No bend is the central value 0.5
# @param delta_midi Pitch bend value as a number between 0 and 16383 inclusively. No bend is central value 8192.
# @param on If specified and false/nil/0 will stop the midi pitch bend message from being sent out. (Ensures all opts are evaluated in this call to `midi_pitch_bend` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_pitch_bend 0  #=> Sends MIDI pitch bend message with value 0 to all ports and channels
#
# @example
#   midi_pitch_bend 1  #=> Sends MIDI pitch bend message with value 16383 to all ports and channels
#
# @example
#   midi_pitch_bend 0.5  #=> Sends MIDI pitch bend message with value 8192 to all ports and channels
#
# @example
#   midi_pitch_bend delta_midi: 8192  #=> Sends MIDI pitch bend message with value 8192 to all ports and channels
#
# @example
#   midi_pitch_bend 0, channel: [1, 5]  #=> Sends MIDI pitch bend message with value 0 on channel 1 and 5 to all ports
#
def midi_pitch_bend(_delta = nil, channel: nil, port: nil, delta: nil, delta_midi: nil, on: nil)
  #This is a stub, used for indexing
end

# Send a MIDI polyphonic key pressure message
# Sends a MIDI polyphonic key pressure message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# Note number and pressure value can be passed as a note such as `:e3` and decimal values will be rounded down or up to the nearest whole number - so values between 3.5 and 4 will be rounded up to 4 and values between 3.49999... and 3 will be rounded down to 3.
# 
# You may also optionally pass the pressure value as a floating point value between 0 and 1 such as 0.2 or 0.785 (which will be mapped to MIDI values between 0 and 127) using the `val_f:` opt.
# 
# [MIDI 1.0 Specification - Channel Voice Messages - Polyphonic Key Pressure (Aftertouch)](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _note [midi]
# @param _value [midi]
# @param channel Channel(s) to send to
# @param port MIDI port(s) to send to
# @param value Pressure value as a MIDI number.
# @param val_f Pressure value as a value between 0 and 1 (will be converted to a MIDI value)
# @param on If specified and false/nil/0 will stop the midi poly pressure message from being sent out. (Ensures all opts are evaluated in this call to `midi_poly_pressure` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_poly_pressure 100, 32  #=> Sends a MIDI poly key pressure message to control note 100 with value 32 to all ports and channels
#
# @example
#   midi_poly_pressure :e7, 32  #=> Sends a MIDI poly key pressure message to control note 100 with value 32 to all ports and channels
#
# @example
#   midi_poly_pressure 100, 32, channel: 5  #=> Sends MIDI poly key pressure message to control note 100 with value 32 on channel 5 to all ports
#
# @example
#   midi_poly_pressure 100, val_f: 0.8, channel: 5  #=> Sends a MIDI poly key pressure message to control note 100 with value 102 on channel 5 to all ports
#
# @example
#   midi_poly_pressure 100, value: 102, channel: [1, 5]  #=> Sends MIDI poly key pressure message to control note 100 with value 102 on channel 1 and 5 to all ports
#
def midi_poly_pressure(_note = nil, _value = nil, channel: nil, port: nil, value: nil, val_f: nil, on: nil)
  #This is a stub, used for indexing
end

# Send raw MIDI message
# Sends the raw MIDI message to *all* connected MIDI devices. Gives you direct access to the individual bytes of a MIDI message. Typically this should be rarely used - prefer the other `midi_` fns where possible.
# 
# A raw MIDI message consists of 3 separate bytes - the Status Byte and two Data Bytes. These may be passed as base 10 decimal integers between 0 and 255, in hex form by prefixing `0x` such as `0xb0` which in decimal is 176 or binary form by prefixing `0b` such as `0b01111001` which represents 121 in decimal.
# 
# Floats will be rounded up or down to the nearest whole number e.g. 176.1 -> 176, 120.5 -> 121, 0.49 -> 0.
# 
# Non-number values will be automatically turned into numbers prior to sending the event if possible (if this conversion does not work an Error will be thrown).
# 
# See https://www.midi.org/specifications/item/table-1-summary-of-midi-message for a summary of MIDI messages and their corresponding byte structures.
# @param _a [byte]
# @param _b [byte]
# @param _c [byte]
# @param port Port(s) to send the raw MIDI message events to
# @param on If specified and false/nil/0 will stop the raw midi message from being sent out. (Ensures all opts are evaluated in this call to `midi_raw` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_raw 176, 121, 0  #=> Sends the MIDI reset command
#
# @example
#   midi_raw 176.1, 120.5, 0.49  #=> Sends the MIDI reset command (values are rounded down, up and down respectively)
#
# @example
#   midi_raw 0xb0, 0x79, 0x0  #=> Sends the MIDI reset command
#
# @example
#   midi_raw 0b10110000, 0b01111001, 0b00000000  #=> Sends the MIDI reset command
#
def midi_raw(_a = nil, _b = nil, _c = nil, port: nil, on: nil)
  #This is a stub, used for indexing
end

# Reset MIDI devices
# Sends a MIDI reset all controllers message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# All controller values are reset to their defaults.
# 
# [MIDI 1.0 Specification - Channel Mode Messages - Reset All Controllers](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param _value [number]
# @param channel Channel to send the midi reset message to
# @param port MIDI port to send to
# @param value Value must only be zero (the default) unless otherwise allowed in a specific Recommended Practice
# @param on If specified and false/nil/0 will stop the midi reset message from being sent out. (Ensures all opts are evaluated in this call to `midi_reset` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_reset #=> Reset MIDI devices on all channels (and ports)
#
# @example
#   midi_reset channel: 2 #=> Reset MIDI devices on channel 2
#
def midi_reset(_value = nil, channel: nil, port: nil, value: nil, on: nil)
  #This is a stub, used for indexing
end

# Silence all MIDI devices
# Sends a MIDI sound off message to *all* connected devices on *all* channels. Use the `port:` and `channel:` opts to restrict which MIDI ports and channels are used.
# 
# All oscillators will turn off, and their volume envelopes are set to zero as soon as possible.
# 
# [MIDI 1.0 Specification - Channel Mode Messages - All Sound Off](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param channel Channel to send the sound off message to
# @param port MIDI port to send to
# @param on If specified and false/nil/0 will stop the midi sound off on message from being sent out. (Ensures all opts are evaluated in this call to `midi_sound_off` regardless of value).
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_sound_off #=> Silence MIDI devices on all ports and channels
#
# @example
#   midi_sound_off channel: 2 #=> Silence MIDI devices on channel 2
#
def midi_sound_off(channel: nil, port: nil, on: nil)
  #This is a stub, used for indexing
end

# Send MIDI system message - start
# Sends the MIDI start system message to *all* connected MIDI devices on *all* ports.  Use the `port:` opt to restrict which MIDI ports are used.
# 
# Start the current sequence playing. (This message should be followed with calls to `midi_clock_tick` or `midi_clock_beat`).
# 
# [MIDI 1.0 Specification - System Real-Time Messages - Start](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_start #=> Send start message to all connected MIDI devices
#
def midi_start
  #This is a stub, used for indexing
end

# Send MIDI system message - stop
# Sends the MIDI stop system message to *all* connected MIDI devices on *all* ports.  Use the `port:` opt to restrict which MIDI ports are used.
# 
# Stops the current sequence.
# 
# [MIDI 1.0 Specification - System Real-Time Messages - Start](https://www.midi.org/specifications/item/table-1-summary-of-midi-message)
# @param port MIDI Port(s) to send the stop message to
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_stop #=> Send stop message to all connected MIDI devices
#
def midi_stop(port: nil)
  #This is a stub, used for indexing
end

# MIDI to Hz conversion
# Convert a midi note to hz
# @param _note [symbol_or_number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   midi_to_hz(60) #=> 261.6256
#
def midi_to_hz(_note = nil)
  #This is a stub, used for indexing
end

# Define a new function
# Does nothing. Use to stop a define from actually defining. Simpler than wrapping whole define in a comment block or commenting each individual line out.
# @param _name [symbol]
# @accepts_block true
# @introduced 2.1.0
def ndefine(_name = nil)
  #This is a stub, used for indexing
end

# Describe note
# Takes a midi note, a symbol (e.g. `:C`) or a string (e.g. `"C"`) and resolves it to a midi note. You can also pass an optional `octave:` parameter to get the midi note for a given octave. Please note - `octave:` param overrides any octave specified in a symbol i.e. `:c3`. If the note is `nil`, `:r` or `:rest`, then `nil` is returned (`nil` represents a rest)
# @param _note [symbol_or_number]
# @param octave The octave of the note. Overrides any octave declaration in the note symbol such as :c2. Default is 4
# @accepts_block false
# @introduced 2.0.0
# @example
#   # These all return 60 which is the midi number for middle C (octave 4)
#   puts note(60)
#   puts note(:C)
#   puts note(:C4)
#   puts note('C')
#
# @example
#   # returns 60 - octave param has no effect if we pass in a number
#   puts note(60, octave: 2)
#   
#   # These all return 36 which is the midi number for C2 (two octaves below middle C)
#   puts note(:C, octave: 2)
#   puts note(:C4, octave: 2) # note the octave param overrides any octaves specified in a symbol
#   puts note('C', octave: 2)
#
def note(_note = nil, octave: nil)
  #This is a stub, used for indexing
end

# Get note info
# Returns an instance of `SonicPi::Note`. Please note - `octave:` param overrides any octave specified in a symbol i.e. `:c3`
# @param _note [symbol_or_number]
# @param octave The octave of the note. Overrides any octave declaration in the note symbol such as :c2. Default is 4
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts note_info(:C, octave: 2)
#   # returns #<SonicPi::Note :C2>
#
def note_info(_note = nil, octave: nil)
  #This is a stub, used for indexing
end

# Get a range of notes
# Produces a ring of all the notes between a low note and a high note. By default this is chromatic (all the notes) but can be filtered with a pitches: argument. This opens the door to arpeggiator style sequences and other useful patterns. If you try to specify only pitches which aren't in the range it will raise an error - you have been warned!
# @param _low_note [note]
# @param _high_note [note]
# @param pitches An array of notes (symbols or ints) to filter on. Octave information is ignored.
# @accepts_block false
# @introduced 2.6.0
# @example
#   (note_range :c4, :c5) # => (ring 60,61,62,63,64,65,66,67,68,69,70,71,72)
#
# @example
#   (note_range :c4, :c5, pitches: (chord :c, :major)) # => (ring 60,64,67,72)
#
# @example
#   (note_range :c4, :c6, pitches: (chord :c, :major)) # => (ring 60,64,67,72,76,79,84)
#
# @example
#   (note_range :c4, :c5, pitches: (scale :c, :major)) # => (ring 60,62,64,65,67,69,71,72)
#
# @example
#   (note_range :c4, :c5, pitches: [:c4, :g2]) # => (ring 60,67,72)
#
# @example
#   live_loop :arpeggiator do
#     # try changing the chord
#     play (note_range :c4, :c5, pitches: (chord :c, :major)).tick
#     sleep 0.125
#   end
#
def note_range(_low_note = nil, _high_note = nil, pitches: nil)
  #This is a stub, used for indexing
end

# Create a ring of octaves
# Create a ring of successive octaves starting at `start` for `num_octaves`. 
# @param _start [note]
# @param _num_octaves [pos_int]
# @accepts_block false
# @introduced 2.8.0
# @example
#   (octs 60, 2)  #=> (ring 60, 72)
#
# @example
#   (octs :e3, 3) #=> (ring 52, 64, 76)
#
def octs(_start = nil, _num_octaves = nil)
  #This is a stub, used for indexing
end

# Optionally evaluate block
# Optionally evaluate the block depending on the truthiness of the supplied condition. The truthiness rules are as follows: all values are seen as true except for: false, nil and 0. Lambdas will be automatically called and the truthiness of their results used.
# @param _condition [truthy]
# @accepts_block false
# @introduced 2.10.0
# @example
#   on true do
#     play 70     #=> will play 70 as true is truthy
#   end
#
# @example
#   on 1 do
#     play 70     #=> will play 70 as 1 is truthy
#   end
#
# @example
#   on 0 do
#     play 70     #=> will *not* play 70 as 0 is not truthy
#   end
#
# @example
#   on false do
#     play 70     #=> will *not* play 70 as false is not truthy
#   end
#
# @example
#   on nil do
#     play 70     #=> will *not* play 70 as nil is not truthy
#   end
#
# @example
#   on lambda{true} do
#     play 70     #=> will play 70 as the lambda returns a truthy value
#   end
#
# @example
#   on lambda{false} do
#     play 70     #=> will *not* play 70 as the lambda does not return a truthy value
#   end
#
# @example
#   on lambda{[true, false].choose} do
#     play 70     #=> will maybe play 70 depending on the choice in the lambda
#   end
#
def on(_condition = nil)
  #This is a stub, used for indexing
end

# Random true value with specified probability
# Returns `true` or `false` with a specified probability - it will return true every one in num times where num is the param you specify
# @param _num [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   one_in 2 # will return true with a probability of 1/2, false with probability 1/2
#
# @example
#   one_in 3 # will return true with a probability of 1/3, false with a probability of 2/3
#
# @example
#   one_in 100 # will return true with a probability of 1/100, false with a probability of 99/100
#
def one_in(_num = nil)
  #This is a stub, used for indexing
end

# Send an OSC message (Open Sound Control)
# Sends an OSC message to the current host and port specified by `use_osc` or `with_osc`.
# 
# OSC (Open Sound Control) is a simple way of passing messages between two separate programs on the same computer or even on different computers via a local network or even the internet. `osc` enables you to send well-timed OSC messages from within Sonic Pi. `osc` will ensure that the OSC message is sent at the correct time using the same timing system shared with the synthesis functionality via `sample`, `synth` and friends. `osc` even works seamlessly within `time_warp` - see examples.
# 
# A typical OSC message has two parts: a descriptive `path` which looks simalar to a URL (website address), and an optional list of `arguments` that are either numbers or strings.
# 
# For example, a hypothetical synth program might accept this OSC message:
# 
# `/set/filter lowpass 80 0.5`
# 
# where `/set/filter` is the path, and `lowpass`, `80`, and `0.5` are three
# arguments. This can be sent from within Sonic Pi by writing:
# 
# `osc "/set/filter", "lowpass", 80, 0.5`
# 
# However, in order to send the OSC message you must first specify where to send it to. This is achieved by specifying both the host (the machine's internet address) and the port that the remote OSC server is listening on. This is configured using `use_osc` or `with_osc`. So, if our synth program was running on a machine on the local network with IP address `10.0.1.5` on port `5100` we could send our OSC message to it with the following:
# 
# 
# `use_osc "10.0.1.5", 5100`
# 
# `osc "/set/filter", "lowpass", 80, 0.5`
# 
# 
# Note, by default, Sonic Pi listens for OSC messages on port `4559`, so you may send messages to an external machine running Sonic Pi if you know the IP address of that external machine. Any OSC messages received on port `4559` are automatically converted to standard cue events and displayed in the GUI's cue log. This also means that you can use `sync` to wait for the next incoming OSC message with a given path (see example).
# 
# Finally, it is also very useful to send OSC messages to aother programs on the same computer. This can be achieved by specifying "localhost" as the hostname and the port as normal (depending on which port the other program is listening on).
# 
# See `osc_send` for a version which allows you to specify the hostname and port directly (ignoring any values set via `use_osc` or `with_osc`).
# 
# For further information see the OSC spec: [http://opensoundcontrol.org/spec-1_0](http://opensoundcontrol.org/spec-1_0)
# @param _path [arguments]
# @accepts_block false
# @introduced 3.0.0
# @example
#   # Send a simple OSC message to another program on the same machine
#   
#   use_osc "localhost", 7000  # Specify port 7000 on this machine
#   osc "/foo/bar"             # Send an OSC message with path "/foo/bar"
#                                # and no arguments
#
# @example
#   # Send an OSC messages with arguments to another program on the same machine
#   
#   use_osc "localhost", 7000        # Specify port 7000 on this machine
#   osc "/foo/bar", 1, 3.89, "baz" # Send an OSC message with path "/foo/bar"
#                                      # and three arguments:
#                                      # 1) The whole number (integer) 1
#                                      # 2) The fractional number (float) 3.89
#                                      # 3) The string "baz"
#
# @example
#   # Send an OSC messages with arguments to another program on a different machine
#   
#   use_osc "10.0.1.5", 7000         # Specify port 7000 on the machine with address 10.0.1.5
#   osc "/foo/bar", 1, 3.89, "baz" # Send an OSC message with path "/foo/bar"
#                                      # and three arguments:
#                                      # 1) The whole number (integer) 1
#                                      # 2) The fractional number (float) 3.89
#                                      # 3) The string "baz"
#
# @example
#   # OSC messages honour the timing system
#   
#   osc "/foo/bar"       # Send an OSC message with path /foo/bar at *exactly* the
#   play 60                # same time as note 60 is played
#   
#   sleep 1                # Wait for 1 beat
#   
#   osc "/baz/quux"       # Send an OSC message with path /baz/quux at *exactly* the
#   play 72                 # same time as note 72 is played
#
# @example
#   # Send a incrementing OSC counter
#   
#   live_loop :foo do             # Start a live loop called :foo
#     osc "/counter", tick      # Send an OSC message with the path /counter
#                                 # with successive whole numbers (0, 1, 2, 3.. etc.)
#                                 # each time round the live loop
#     sleep 1                     # Repeat the live loop every 1 beat
#   end
#
# @example
#   # OSC messages can be sent from within time_warp
#   
#   time_warp 0.5 do
#     osc "/foo/bar"       # Send an OSC message with path /foo/bar at 0.5 beats
#   end
#   
#   sleep 1                  # Wait for 1 beat
#   
#   time_warp -0.1 do
#     osc "/baz/quux"      # Send an OSC message with path /baz/quux at 0.9 beats
#   end
#
def osc(_path = nil)
  #This is a stub, used for indexing
end

# Send an OSC message to a specific host and port
# Similar to `osc` except ignores any `use_osc` settings and sends the OSC message directly to the specified `hostname` and `port`.
# 
# See `osc` for more information.
# @param _hostname [string]
# @param _port [number]
# @param _path [osc_path]
# @param _args [list]
# @accepts_block true
# @introduced 3.0.0
# @example
#   osc_send "localhost", 7000, "/foo/baz"  # Send an OSC message to port 7000 on the same machine
#
# @example
#   use_osc "localhost", 7010                 # set hostname and port
#   osc "/foo/baz"                            # Send an OSC message to port 7010
#   
#   osc_send "localhost", 7000, "/foo/baz"  # Send an OSC message to port 7000
#                                               # (ignores use_osc settings)
#
def osc_send(_hostname = nil, _port = nil, _path = nil, _args = nil)
  #This is a stub, used for indexing
end

# Randomly pick from list (with duplicates)
# Pick n elements from list or ring. Unlike shuffle, after each element has been picked, it is 'returned' to the list so it may be picked again. This means there may be duplicates in the result. If n is greater than the size of the ring/list then duplicates are guaranteed to be in the result.
# 
# If `n` isn't supplied it defaults to the size of the list/ring.
# 
# If no arguments are given, will return a lambda function which when called takes an argument which will be a list to be picked from. This is useful for choosing random `onset:` vals for samples.
# 
# Always returns a list-like thing (either an array or ring)
# @param _list [array]
# @param _n [number_or_nil]
# @param skip Number of rands to skip over with each successive pick
# @accepts_block false
# @introduced 2.10.0
# @example
#   puts [1, 2, 3, 4, 5].pick(3) #=> [4, 4, 3]
#
# @example
#   puts (ring 1, 2, 3, 4, 5).pick(3) #=> (ring 4, 4, 3)
#
# @example
#   puts (ring 1, 2).pick(5) #=> (ring 2, 2, 1, 1, 1)
#
# @example
#   puts (ring 1, 2, 3).pick #=> (ring 3, 3, 2)
#
# @example
#   # Using pick for random sample onsets
#   live_loop :foo do
#     sample :loop_amen, onset: pick   # pick a random onset value each time
#     sleep 0.125
#   end
#
def pick(_list = nil, _n = nil, skip: nil)
  #This is a stub, used for indexing
end

# relative MIDI pitch to frequency ratio
# Convert a midi note to a ratio which when applied to a frequency will scale the frequency by the number of semitones. Useful for changing the pitch of a sample by using it as a way of generating the rate.
# @param _pitch [midi_number]
# @accepts_block false
# @introduced 2.5.0
# @example
#   pitch_to_ratio 12 #=> 2.0
#
# @example
#   pitch_to_ratio 1 #=> 1.05946
#
# @example
#   pitch_to_ratio -12 #=> 0.5
#
# @example
#   sample :ambi_choir, rate: pitch_to_ratio(3) # Plays :ambi_choir 3 semitones above default.
#
# @example
#   # Play a chromatic scale of semitones
#   (range 0, 16).each do |n|                  # For each note in the range 0->16
#     sample :ambi_choir, rate: pitch_to_ratio(n) # play :ambi_choir at the relative pitch
#     sleep 0.5                                # and wait between notes
#   end
#
def pitch_to_ratio(_pitch = nil)
  #This is a stub, used for indexing
end

# Play current synth
# Play note with current synth. Accepts a set of standard options which include control of an amplitude envelope with `attack:`, `decay:`, `sustain:` and `release:` phases. These phases are triggered in order, so the duration of the sound is attack + decay + sustain + release times. The duration of the sound does not affect any other notes. Code continues executing whilst the sound is playing through its envelope phases.
# 
# If `duration:` is supplied and `sustain:` isn't, it causes `sustain:` to be set so that all four phases add up to the duration.
# 
# Accepts optional args for modification of the synth being played. See each synth's documentation for synth-specific opts. See `use_synth` and `with_synth` for changing the current synth.
# 
# If note is `nil`, `:r` or `:rest`, play is ignored and treated as a rest. Also, if the `on:` opt is specified and returns `false`, or `nil` then play is similarly ignored and treated as a rest.
# 
# Note that the default opts listed are only a guide to the most common opts across all the synths. Not all synths support all the default opts and each synth typically supports many more opts specific to that synth. For example, the `:tb303` synth supports 45 unique opts. For a full list of a synth's opts see its documentation in the Help system.
#     
# @param _note [symbol_or_number]
# @param amp The amplitude of the note
# @param amp_slide The duration in beats for amplitude changes to take place
# @param pan The stereo position of the sound. -1 is left, 0 is in the middle and 1 is on the right. You may use a value in between -1 and 1 such as 0.25
# @param pan_slide The duration in beats for the pan value to change
# @param attack Amount of time (in beats) for sound to reach full amplitude (attack_level). A short attack (i.e. 0.01) makes the initial part of the sound very percussive like a sharp tap. A longer attack (i.e 1) fades the sound in gently.
# @param decay Amount of time (in beats) for the sound to move from full amplitude (attack_level) to the sustain amplitude (sustain_level).
# @param sustain Amount of time (in beats) for sound to remain at sustain level amplitude. Longer sustain values result in longer sounds. Full length of sound is attack + decay + sustain + release.
# @param release Amount of time (in beats) for sound to move from sustain level amplitude to silent. A short release (i.e. 0.01) makes the final part of the sound very percussive (potentially resulting in a click). A longer release (i.e 1) fades the sound out gently.
# @param attack_level Amplitude level reached after attack phase and immediately before decay phase
# @param decay_level Amplitude level reached after decay phase and immediately before sustain phase. Defaults to sustain_level unless explicitly set
# @param sustain_level Amplitude level reached after decay phase and immediately before release phase.
# @param env_curve Select the shape of the curve between levels in the envelope. 1=linear, 2=exponential, 3=sine, 4=welch, 6=squared, 7=cubed
# @param slide Default slide time in beats for all slide opts. Individually specified slide opts will override this value
# @param pitch Pitch adjustment in semitones. 1 is up a semitone, 12 is up an octave, -12 is down an octave etc.  Decimal numbers can be used for fine tuning.
# @param on If specified and false/nil/0 will stop the synth from being played. Ensures all opts are evaluated.
# @accepts_block true
# @introduced 2.0.0
# @example
#   play 50 # Plays note 50 on the current synth
#
# @example
#   play 50, attack: 1 # Plays note 50 with a fade-in time of 1s
#
# @example
#   play 62, pan: -1, release: 3 # Play note 62 in the left ear with a fade-out time of 3s.
#
# @example
#   # controlling a synth synchronously
#   s = play :e3, release: 4
#   sleep 1
#   control s, note: :e5
#   sleep 0.5
#   use_synth :dsaw
#   play :e3   # This is triggered after 1.5s from start
#
# @example
#   # Controlling a synth asynchronously
#   play :e3, release: 4 do |s|
#     sleep 1                                               # This block is run in an implicit in_thread
#     control s, note: :e5                                  # and therefore is asynchronous
#   end
#   
#   sleep 0.5
#   use_synth :dsaw
#   play :e3 # This is triggered after 0.5s from start
#
def play(_note = nil, amp: nil, amp_slide: nil, pan: nil, pan_slide: nil, attack: nil, decay: nil, sustain: nil, release: nil, attack_level: nil, decay_level: nil, sustain_level: nil, env_curve: nil, slide: nil, pitch: nil, on: nil)
  #This is a stub, used for indexing
end

# Play notes simultaneously
# Play a list of notes at the same time.
# 
# Accepts optional args for modification of the synth being played. See each synth's documentation for synth-specific opts. See `use_synth` and `with_synth` for changing the current synth.
# @param _notes [list]
# @param amp The amplitude of the note
# @param amp_slide The duration in beats for amplitude changes to take place
# @param pan The stereo position of the sound. -1 is left, 0 is in the middle and 1 is on the right. You may use a value in between -1 and 1 such as 0.25
# @param pan_slide The duration in beats for the pan value to change
# @param attack Amount of time (in beats) for sound to reach full amplitude (attack_level). A short attack (i.e. 0.01) makes the initial part of the sound very percussive like a sharp tap. A longer attack (i.e 1) fades the sound in gently.
# @param decay Amount of time (in beats) for the sound to move from full amplitude (attack_level) to the sustain amplitude (sustain_level).
# @param sustain Amount of time (in beats) for sound to remain at sustain level amplitude. Longer sustain values result in longer sounds. Full length of sound is attack + decay + sustain + release.
# @param release Amount of time (in beats) for sound to move from sustain level amplitude to silent. A short release (i.e. 0.01) makes the final part of the sound very percussive (potentially resulting in a click). A longer release (i.e 1) fades the sound out gently.
# @param attack_level Amplitude level reached after attack phase and immediately before decay phase
# @param decay_level Amplitude level reached after decay phase and immediately before sustain phase. Defaults to sustain_level unless explicitly set
# @param sustain_level Amplitude level reached after decay phase and immediately before release phase.
# @param env_curve Select the shape of the curve between levels in the envelope. 1=linear, 2=exponential, 3=sine, 4=welch, 6=squared, 7=cubed
# @param slide Default slide time in beats for all slide opts. Individually specified slide opts will override this value
# @param pitch Pitch adjustment in semitones. 1 is up a semitone, 12 is up an octave, -12 is down an octave etc.  Decimal numbers can be used for fine tuning.
# @param on If specified and false/nil/0 will stop the synth from being played. Ensures all opts are evaluated.
# @accepts_block false
# @introduced 2.0.0
# @example
#   play_chord [40, 45, 47]
#   
#   # same as:
#   
#   play 40
#   play 45
#   play 47
#
# @example
#   play_chord [40, 45, 47], amp: 0.5
#   
#   # same as:
#   
#   play 40, amp: 0.5
#   play 45, amp: 0.5
#   play 47, amp: 0.5
#
# @example
#   play_chord chord(:e3, :minor)
#
def play_chord(_notes = nil, amp: nil, amp_slide: nil, pan: nil, pan_slide: nil, attack: nil, decay: nil, sustain: nil, release: nil, attack_level: nil, decay_level: nil, sustain_level: nil, env_curve: nil, slide: nil, pitch: nil, on: nil)
  #This is a stub, used for indexing
end

# Play a nested pattern of notes, samples or lambdas
# Using a nested array to represent rhythm, you can use this method to structure melodies, beats and other rhythmic patterns.
# 
#   A nested array is just an array that contains other arrays inside it e.g. `[1, [2, 2], 1, 1]`. Here we can see three elements at the top level of the array (the ones) and two elements which are nested two arrays deep (the twos).
# 
#   We can use this nesting to play through the contents of the array at faster and faster rates. Things nested at the second level will play twice as fast, things nested at the third level will play four times as fast and so on.
# 
#   It might help to think about music notation - if the level 1 is a crotchet/quarter note, then level two is like a quaver/eighth note and so on, all the way down to hemidemisemiquavers and beyond.
# 
#   If you want to use a triplet rhythm you can use a special notation to spread across multiple beats e.g. `[:d5, :cs5, {over: 2, val: [:c5,:c5,:c5]}, :b4, :bb4, :a4]`. This spaces the three `:c5` notes over the space of two normal notes which gives you a quaver triplet rhythm. You might recognize this from Bizet's opera Carmen.
# @param _pattern []
# @param beat_length Length of a single (top level) beat - defaults to 1
# @param mode One of `:notes`, `:samples` or `:lambdas` depending on what is in your nested pattern. See examples below.
# @accepts_block false
# @introduced 2.8.0
# @example
#   play_nested_pattern [:c, [:d, :f], :e, :c]
#                                   # Same as:
#                                   #   play :c
#                                   #   sleep 1
#                                   #   play :d
#                                   #   sleep 0.5
#                                   #   play :f
#                                   #   sleep 0.5
#                                   #   play :e
#                                   #   sleep 1
#                                   #   play :c
#                                   #   sleep 1
#
# @example
#   # We can also use sample names with `:samples` as the mode option
#         rock_you_pattern =
#           [:bd_haus, :elec_snare, [:bd_haus, :bd_haus], :elec_snare]
#   
#         play_nested_pattern(rock_you_pattern, mode: :samples) # Same as:
#                                   #   sample :bd_haus
#                                   #   sleep 1
#                                   #   sample :elec_snare
#                                   #   sleep 1
#                                   #   sample :bd_haus
#                                   #   sleep 0.5
#                                   #   sample :bd_haus
#                                   #   sleep 0.5
#                                   #   sample :elec_snare
#                                   #   sleep 1
#
# @example
#   # We can also use lambdas with `:lambdas` as the mode option
#         rand_notes = lambda {
#           notes = scale(:c3, :minor_pentatonic, num_octaves: 3)
#           play_pattern_timed(notes.shuffle.take(3), 0.33)
#         }
#         random_pattern = [rand_notes, rand_notes, [rand_notes, rand_notes], rand_notes]
#         loop do
#           # because we already sleep inside play_pattern_timed,
#           # we set the :beat_length to zero
#           play_nested_pattern(random_pattern, mode: :lambdas, beat_length: 0)
#         end
#
# @example
#   # Triplets and cross rhythms
#         # By using a hash with :over and :val keys, we can spread, for example, three notes over the space of two
#         # This creates the equivalent of triplets in music
#         carmen_pattern = [:d5, :cs5, {over: 2, val: [:c5,:c5,:c5]}, :b4, :bb4, :a4]
#         # This spaces the three `:c5` notes (our `:val`) over the space of two (our `:over`) normal notes which gives you a quaver triplet rhythm.
#         # You might recognize this from Bizet's opera Carmen.
#         play_nested_pattern(carmen_pattern, beat_length: 0.5)
#
# @example
#   # Advanced version - a randomised drum beat
#         live_loop :beatz do
#           use_bpm 120
#   
#           bd = lambda { sample :bd_haus, rate: 2}
#           sn = lambda { sample :drum_snare_hard, rate: 4 }
#           hh = lambda { sample :drum_cymbal_closed, rate: rrand(3,4)}
#           rest = lambda { nil }
#   
#           drumbeat = [bd, sn, [bd, [bd,bd]], [sn, hh]]
#           drumbreak = [[bd,bd,bd,bd], {over: 2, val: [sn,sn,sn]}, [rest,hh,rest,hh]]
#   
#           3.times do
#             play_nested_pattern(drumbeat, mode: :lambdas)
#           end
#           # We use .shuffle to get a different break each time
#           play_nested_pattern(drumbreak.shuffle, mode: :lambdas)
#         end
#
def play_nested_pattern(_pattern = nil, beat_length: nil, mode: nil)
  #This is a stub, used for indexing
end

# Play pattern of notes
# Play list of notes with the current synth one after another with a sleep of 1
# 
# Accepts optional args for modification of the synth being played. See each synth's documentation for synth-specific opts. See use_synth and with_synth for changing the current synth.
# @param _notes [list]
# @accepts_block false
# @introduced 2.0.0
# @example
#   play_pattern [40, 41, 42] # Same as:
#                             #   play 40
#                             #   sleep 1
#                             #   play 41
#                             #   sleep 1
#                             #   play 42
#
# @example
#   play_pattern [:d3, :c1, :Eb5] # You can use keyword notes
#
# @example
#   play_pattern [:d3, :c1, :Eb5], amp: 0.5, cutoff: 90 # Supports the same arguments as play:
#
def play_pattern(_notes = nil)
  #This is a stub, used for indexing
end

# Play pattern of notes with specific times
# Play each note in a list of notes one after another with specified times between them. The notes should be a list of MIDI numbers, symbols such as :E4 or chords such as chord(:A3, :major) - identical to the first parameter of the play function. The times should be a list of times between the notes in beats.
# 
# If the list of times is smaller than the number of gaps between notes, the list is repeated again. If the list of times is longer than the number of gaps between notes, then some of the times are ignored. See examples for more detail.
# 
# Accepts optional args for modification of the synth being played. See each synth's documentation for synth-specific opts. See `use_synth` and `with_synth` for changing the current synth.
# @param _notes [list]
# @param _times [list_or_number]
# @param amp The amplitude of the note
# @param amp_slide The duration in beats for amplitude changes to take place
# @param pan The stereo position of the sound. -1 is left, 0 is in the middle and 1 is on the right. You may use a value in between -1 and 1 such as 0.25
# @param pan_slide The duration in beats for the pan value to change
# @param attack Amount of time (in beats) for sound to reach full amplitude (attack_level). A short attack (i.e. 0.01) makes the initial part of the sound very percussive like a sharp tap. A longer attack (i.e 1) fades the sound in gently.
# @param decay Amount of time (in beats) for the sound to move from full amplitude (attack_level) to the sustain amplitude (sustain_level).
# @param sustain Amount of time (in beats) for sound to remain at sustain level amplitude. Longer sustain values result in longer sounds. Full length of sound is attack + decay + sustain + release.
# @param release Amount of time (in beats) for sound to move from sustain level amplitude to silent. A short release (i.e. 0.01) makes the final part of the sound very percussive (potentially resulting in a click). A longer release (i.e 1) fades the sound out gently.
# @param attack_level Amplitude level reached after attack phase and immediately before decay phase
# @param decay_level Amplitude level reached after decay phase and immediately before sustain phase. Defaults to sustain_level unless explicitly set
# @param sustain_level Amplitude level reached after decay phase and immediately before release phase.
# @param env_curve Select the shape of the curve between levels in the envelope. 1=linear, 2=exponential, 3=sine, 4=welch, 6=squared, 7=cubed
# @param slide Default slide time in beats for all slide opts. Individually specified slide opts will override this value
# @param pitch Pitch adjustment in semitones. 1 is up a semitone, 12 is up an octave, -12 is down an octave etc.  Decimal numbers can be used for fine tuning.
# @param on If specified and false/nil/0 will stop the synth from being played. Ensures all opts are evaluated.
# @accepts_block false
# @introduced 2.0.0
# @example
#   play_pattern_timed [40, 42, 44, 46], [1, 2, 3]
#   
#   # same as:
#   
#   play 40
#   sleep 1
#   play 42
#   sleep 2
#   play 44
#   sleep 3
#   play 46
#
# @example
#   play_pattern_timed [40, 42, 44, 46, 49], [1, 0.5]
#   
#   # same as:
#   
#   play 40
#   sleep 1
#   play 42
#   sleep 0.5
#   play 44
#   sleep 1
#   play 46
#   sleep 0.5
#   play 49
#
# @example
#   play_pattern_timed [40, 42, 44, 46], [0.5]
#   
#   # same as:
#   
#   play 40
#   sleep 0.5
#   play 42
#   sleep 0.5
#   play 44
#   sleep 0.5
#   play 46
#
# @example
#   play_pattern_timed [40, 42, 44], [1, 2, 3, 4, 5]
#   
#   #same as:
#   
#   play 40
#   sleep 1
#   play 42
#   sleep 2
#   play 44
#
def play_pattern_timed(_notes = nil, _times = nil, amp: nil, amp_slide: nil, pan: nil, pan_slide: nil, attack: nil, decay: nil, sustain: nil, release: nil, attack_level: nil, decay_level: nil, sustain_level: nil, env_curve: nil, slide: nil, pitch: nil, on: nil)
  #This is a stub, used for indexing
end

# Display a message in the output pane
# Displays the information you specify as a string inside the output pane. This can be a number, symbol, or a string itself. Useful for debugging. Synonym for `puts`.
# @param _output [anything]
# @accepts_block false
# @introduced 2.0.0
# @example
#   print "hello there"   #=> will print the string "hello there" to the output pane
#
# @example
#   print 5               #=> will print the number 5 to the output pane
#
# @example
#   print foo             #=> will print the contents of foo to the output pane
#
def print(_output = nil)
  #This is a stub, used for indexing
end

# Display a message in the output pane
# Displays the information you specify as a string inside the output pane. This can be a number, symbol, or a string itself. Useful for debugging. Synonym for `print`.
# @param _output [anything]
# @accepts_block false
# @introduced 2.0.0
# @example
#   print "hello there"   #=> will print the string "hello there" to the output pane
#
# @example
#   print 5               #=> will print the number 5 to the output pane
#
# @example
#   print foo             #=> will print the contents of foo to the output pane
#
def puts(_output = nil)
  #This is a stub, used for indexing
end

# Quantise a value to resolution
# Round value to the nearest multiple of step resolution.
# @param _n [number]
# @param _step [positive_number]
# @accepts_block false
# @introduced 2.1.0
# @example
#   quantise(10, 1) # 10 is already a multiple of 1, so returns 10
#
# @example
#   quantise(10, 1.1) # Returns 9.9 which is 1.1 * 9
#
# @example
#   quantise(13.3212, 0.1) # 13.3
#
# @example
#   quantise(13.3212, 0.2) # 13.4
#
# @example
#   quantise(13.3212, 0.3) # 13.2
#
# @example
#   quantise(13.3212, 0.5) # 13.5
#
def quantise(_n = nil, _step = nil)
  #This is a stub, used for indexing
end

# Create a ramp vector
# Create a new immutable ramp vector from args. Indexes always return first or last value if out of bounds.
# @param _list [array]
# @accepts_block false
# @introduced 2.6.0
# @example
#   (ramp 1, 2, 3)[0] #=> 1
#
# @example
#   (ramp 1, 2, 3)[1] #=> 2
#
# @example
#   (ramp 1, 2, 3)[2] #=> 3
#
# @example
#   (ramp 1, 2, 3)[3] #=> 3
#
# @example
#   (ramp 1, 2, 3)[1000] #=> 3
#
# @example
#   (ramp 1, 2, 3)[-1] #=> 1
#
# @example
#   (ramp 1, 2, 3)[-1000] #=> 1
#
def ramp(_list = nil)
  #This is a stub, used for indexing
end

# Generate a random float below a value
# Given a max number, produces a float between `0` and the supplied max value. If max is a range, produces a float within the range. With no args returns a random value between `0` and `1`.
# @param _max [number_or_range]
# @accepts_block false
# @introduced 2.0.0
# @example
#   print rand(0.5) #=> will print a number like 0.375030517578125 to the output pane
#
def rand(_max = nil)
  #This is a stub, used for indexing
end

# Roll back random generator
# Roll the random generator back essentially 'undoing' the last call to `rand`. You may specify an amount to roll back allowing you to skip back n calls to `rand`.
# @param _amount [number]
# @accepts_block false
# @introduced 2.7.0
# @example
#   # Basic rand stream rollback
#   
#     puts rand # prints 0.75006103515625
#   
#     rand_back # roll random stream back one
#               # the result of the next call to rand will be
#               # exactly the same as the previous call
#   
#     puts rand # prints 0.75006103515625 again!
#     puts rand # prints 0.733917236328125
#
# @example
#   # Jumping back multiple places in the rand stream
#   
#     puts rand # prints 0.75006103515625
#     puts rand # prints 0.733917236328125
#     puts rand # prints 0.464202880859375
#     puts rand # prints 0.24249267578125
#   
#     rand_back(3) # roll random stream back three places
#                  # the result of the next call to rand will be
#                  # exactly the same as the result 3 calls to
#                  # rand ago.
#   
#     puts rand # prints  0.733917236328125 again!
#     puts rand # prints  0.464202880859375
#
def rand_back(_amount = nil)
  #This is a stub, used for indexing
end

# Generate a random whole number below a value (exclusive)
# Given a max number, produces a whole number between `0` and the supplied max value exclusively. If max is a range produces an int within the range. With no args returns either `0` or `1`
# @param _max [number_or_range]
# @accepts_block false
# @introduced 2.0.0
# @example
#   print rand_i(5) #=> will print either 0, 1, 2, 3, or 4 to the output pane
#
def rand_i(_max = nil)
  #This is a stub, used for indexing
end

# Generate a random whole number without consuming a rand
# Given a max number, produces a whole number between `0` and the supplied max value exclusively. If max is a range produces an int within the range. With no args returns either `0` or `1`.
# 
# Does not consume a random value from the stream. Therefore, multiple sequential calls to `rand_i_look` will all return the same value.
# @param _max [number_or_range]
# @accepts_block false
# @introduced 2.11.0
# @example
#   print rand_i_look(5) #=> will print either 0, 1, 2, 3, or 4 to the output pane
#
# @example
#   print rand_i_look(5) #=> will print either 0, 1, 2, 3, or 4 to the output pane
#   print rand_i_look(5) #=> will print the same number again
#   print rand_i_look(5) #=> will print the same number again
#   print rand_i(5) #=> will print either 0, 1, 2, 3, or 4 to the output pane
#   print rand_i_look(5) #=> will print the same number as the previous statement
#
def rand_i_look(_max = nil)
  #This is a stub, used for indexing
end

# Generate a random number without consuming a rand
# Given a max number, produces a number between `0` and the supplied max value exclusively. If max is a range produces an int within the range. With no args returns a value between `0` and `1`.
# 
# Does not consume a random value from the stream. Therefore, multiple sequential calls to `rand_look` will all return the same value.
# @param _max [number_or_range]
# @accepts_block false
# @introduced 2.11.0
# @example
#   print rand_look(0.5) #=> will print a number like 0.375030517578125 to the output pane
#
# @example
#   print rand_look(0.5) #=> will print a number like 0.375030517578125 to the output pane
#     print rand_look(0.5) #=> will print the same number again
#     print rand_look(0.5) #=> will print the same number again
#     print rand_(0.5) #=> will print a different random number
#     print rand_look(0.5) #=> will print the same number as the prevoius line again.
#
def rand_look(_max = nil)
  #This is a stub, used for indexing
end

# Reset rand generator to last seed
# Resets the random stream to the last specified seed. See `use_random_seed` for changing the seed.
# @accepts_block false
# @introduced 2.7.0
# @example
#   puts rand # prints 0.75006103515625
#     puts rand # prints 0.733917236328125
#     puts rand # prints 0.464202880859375
#     puts rand # prints 0.24249267578125
#     rand_reset  # reset the random stream
#     puts rand # prints 0.75006103515625
#
def rand_reset
  #This is a stub, used for indexing
end

# Jump forward random generator
# Jump the random generator forward essentially skipping the next call to `rand`. You may specify an amount to jump allowing you to skip n calls to `rand`.
# @param _amount [number]
# @accepts_block false
# @introduced 2.7.0
# @example
#   # Basic rand stream skip
#   
#     puts rand # prints 0.75006103515625
#   
#     rand_skip # jump random stream forward one
#               # typically the next rand is 0.733917236328125
#   
#     puts rand # prints 0.464202880859375
#
# @example
#   # Jumping forward multiple places in the rand stream
#   
#     puts rand # prints 0.75006103515625
#     puts rand # prints 0.733917236328125
#     puts rand # prints 0.464202880859375
#     puts rand # prints 0.24249267578125
#   
#     rand_reset  # reset the random stream
#   
#     puts rand # prints 0.75006103515625
#   
#     rand_skip(2) # jump random stream forward three places
#                  # the result of the next call to rand will be
#                  # exactly the same as if rand had been called
#                  # three times
#   
#     puts rand 0.24249267578125
#
def rand_skip(_amount = nil)
  #This is a stub, used for indexing
end

# Create a ring buffer with the specified start, finish and step size
# Create a new ring buffer from the range arguments (start, finish and step size). Step size defaults to `1`. Indexes wrap around positively and negatively
# @param _start [number]
# @param _finish [number]
# @param _step_size [number]
# @param step Size of increment between steps; step size.
# @param inclusive If set to true, range is inclusive of finish value
# @accepts_block false
# @introduced 2.2.0
# @example
#   (range 1, 5)    #=> (ring 1, 2, 3, 4)
#
# @example
#   (range 1, 5, inclusive: true) #=> (ring 1, 2, 3, 4, 5)
#
# @example
#   (range 1, 5, step: 2) #=> (ring 1, 3)
#
# @example
#   (range 1, -5, step: 2) #=> (ring 1, -1, -3)
#
# @example
#   (range 1, -5, step: 2)[-1] #=> -3
#
def range(_start = nil, _finish = nil, _step_size = nil, step: nil, inclusive: nil)
  #This is a stub, used for indexing
end

# relative frequency ratio to MIDI pitch
# Convert a frequency ratio to a midi note which when added to a note will transpose the note to match the frequency ratio.
# @param _ratio [number]
# @accepts_block false
# @introduced 2.7.0
# @example
#   ratio_to_pitch 2 #=> 12.0
#
# @example
#   ratio_to_pitch 0.5 #=> -12.0
#
def ratio_to_pitch(_ratio = nil)
  #This is a stub, used for indexing
end

# Random number in centred distribution
# Returns a random number within the range with width around centre. If optional arg `step:` is used, the result is quantised by step.
# @param _width [number]
# @param _centre [number]
# @param step Step size of value to quantise to.
# @accepts_block false
# @introduced 2.3.0
# @example
#   print rdist(1, 0) #=> will print a number between -1 and 1
#
# @example
#   print rdist(1) #=> centre defaults to 0 so this is the same as rdist(1, 0)
#
# @example
#   loop do
#       play :c3, pan: rdist(1) #=> Will play :c3 with random L/R panning
#       sleep 0.125
#     end
#
def rdist(_width = nil, _centre = nil, step: nil)
  #This is a stub, used for indexing
end

# 
# After using `recording_start` and `recording_stop`, a temporary file is created until you decide to use `recording_save`. If you've decided you don't want to save it you can use this method to delete the temporary file straight away, otherwise the operating system will take care of deleting it later.
# @accepts_block false
# @introduced 
def recording_delete
  #This is a stub, used for indexing
end

# Save recording
# Save previous recording to the specified location
# @param _path [string]
# @accepts_block false
# @introduced 2.0.0
def recording_save(_path = nil)
  #This is a stub, used for indexing
end

# Start recording
# Start recording all sound to a `.wav` file stored in a temporary directory.
# @accepts_block false
# @introduced 2.0.0
def recording_start
  #This is a stub, used for indexing
end

# Stop recording
# Stop current recording.
# @accepts_block false
# @introduced 2.0.0
def recording_stop
  #This is a stub, used for indexing
end

# Reset all thread locals
# All settings such as the current synth, BPM, random stream and tick values will be reset to the values inherited from the parent thread. Consider using `clear` to reset all these values to their defaults.
# @accepts_block false
# @introduced 2.11.0
# @example
#   # Basic Reset
#   use_synth :blade
#   use_octave 3
#   
#   puts "before"         #=> "before"
#   puts current_synth      #=> :blade
#   puts current_octave     #=> 3
#   puts rand               #=> 0.75006103515625
#   puts tick               #=> 0
#   
#   reset
#   
#   puts "after"          #=> "after"
#   puts current_synth      #=> :beep
#   puts current_octave     #=> 0
#   puts rand               #=> 0.75006103515625
#   puts tick               #=> 0
#
# @example
#   Reset remembers defaults from when the thread was created:
#   use_synth :blade
#   use_octave 3
#   
#   puts "before"         #=> "before"
#   puts current_synth      #=> :blade
#   puts current_octave     #=> 3
#   puts rand               #=> 0.75006103515625
#   puts tick               #=> 0
#   
#   at do
#     use_synth :tb303
#     puts rand               #=> 0.9287109375
#     reset
#     puts "thread"          #=> "thread"
#   
#   
#                             # The call to reset ensured that the current
#                             # synth was returned to the the state at the
#                             # time this thread was started. Thus any calls
#                             # to use_synth between this line and the start
#                             # of the thread are ignored
#     puts current_synth      #=> :blade
#     puts current_octave     #=> 3
#   
#                             # The call to reset ensured
#                             # that the random stream was reset
#                             # to the same state as it was when
#                             # the current thread was started
#     puts rand               #=> 0.9287109375
#     puts tick               #=> 0
#   end
#
def reset
  #This is a stub, used for indexing
end

# Reset master mixer
# The master mixer is the final mixer that all sound passes through. This fn resets it to its default set - undoing any changes made via set_mixer_control!
# @accepts_block false
# @introduced 2.9.0
# @example
#   set_mixer_control! lpf: 70 # LPF cutoff value of master mixer is now 70
#   sample :loop_amen          # :loop_amen sample is played with low cutoff
#   sleep 3
#   reset_mixer!               # mixer is now reset to default values
#   sample :loop_amen          # :loop_amen sample is played with normal cutoff
#
def reset_mixer!
  #This is a stub, used for indexing
end

# Determine if note or args is a rest
# Given a note or an args map, returns true if it represents a rest and false if otherwise
# @param _note_or_args [number_symbol_or_map]
# @accepts_block false
# @introduced 2.1.0
# @example
#   puts rest? nil # true
#
# @example
#   puts rest? :r # true
#
# @example
#   puts rest? :rest # true
#
# @example
#   puts rest? 60 # false
#
# @example
#   puts rest? {} # false
#
# @example
#   puts rest? {note: :rest} # true
#
# @example
#   puts rest? {note: nil} # true
#
# @example
#   puts rest? {note: 50} # false
#
def rest?(_note_or_args = nil)
  #This is a stub, used for indexing
end

# Create a ring buffer
# Create a new immutable ring buffer from args. Indexes wrap around positively and negatively
# @param _list [array]
# @accepts_block false
# @introduced 2.2.0
# @example
#   (ring 1, 2, 3)[0] #=> 1
#
# @example
#   (ring 1, 2, 3)[1] #=> 2
#
# @example
#   (ring 1, 2, 3)[3] #=> 1
#
# @example
#   (ring 1, 2, 3)[-1] #=> 3
#
def ring(_list = nil)
  #This is a stub, used for indexing
end

# Generate a random float between two numbers
# Given two numbers, this produces a float between the supplied min and max values exclusively. Both min and max need to be supplied. For random integers, see `rrand_i`. If optional arg `step:` is used, the result is quantised by step.
# @param _min [number]
# @param _max [number]
# @param step Step size of value to quantise to.
# @accepts_block false
# @introduced 2.0.0
# @example
#   print rrand(0, 10) #=> will print a number like 8.917730007820797 to the output pane
#
# @example
#   loop do
#       play rrand(60, 72) #=> Will play a random non-integer midi note between C4 (60) and C5 (72) such as 67.3453 or 71.2393
#       sleep 0.125
#     end
#
def rrand(_min = nil, _max = nil, step: nil)
  #This is a stub, used for indexing
end

# Generate a random whole number between two points inclusively
# Given two numbers, this produces a whole number between the min and max you supplied inclusively. Both min and max need to be supplied. For random floats, see `rrand`
# @param _min [number]
# @param _max [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   print rrand_i(0, 10) #=> will print a random number between 0 and 10 (e.g. 4, 0 or 10) to the output pane
#
# @example
#   loop do
#       play rrand_i(60, 72) #=> Will play a random midi note between C4 (60) and C5 (72)
#       sleep 0.125
#     end
#
def rrand_i(_min = nil, _max = nil)
  #This is a stub, used for indexing
end

# Real time conversion
# Real time representation. Returns the amount of beats for the value in real-time seconds. Useful for bypassing any bpm scaling
# @param _seconds [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   use_bpm 120  # modifies all time to be half
#     play 50
#     sleep 1      # actually sleeps for half of a second
#     play 62
#     sleep rt(1)  # bypasses bpm scaling and sleeps for a second
#     play 72
#
def rt(_seconds = nil)
  #This is a stub, used for indexing
end

# Evaluate the code passed as a String as a new Run
# Executes the code passed as a string in a new Run. This works as if the code was in a buffer and Run button was pressed.
# @param _code [string]
# @accepts_block false
# @introduced 2.11.0
# @example
#   run_code "sample :ambi_lunar_land" #=> will play the :ambi_lunar_land sample
#
# @example
#   # Works with any amount of code:
#   run_code "8.times do
#   play 60
#   sleep 1
#   end # will play 60 8 times
#
def run_code(_code = nil)
  #This is a stub, used for indexing
end

# Evaluate the contents of the file as a new Run
# Reads the full contents of the file with `path` and executes it in a new Run. This works as if the code in the file was in a buffer and Run button was pressed.
# @param _filename [path]
# @accepts_block false
# @introduced 2.11.0
# @example
#   run_file "~/path/to/sonic-pi-code.rb" #=> will run the contents of this file
#
def run_file(_filename = nil)
  #This is a stub, used for indexing
end

# Trigger sample
# Play back a recorded sound file (sample). Sonic Pi comes with lots of great samples included (see the section under help) but you can also load and play `.wav`, `.wave`, `.aif`, `.aiff`, `.ogg`, `.oga` or `.flac` files from anywhere on your computer too. To play a built-in sample use the corresponding keyword such as `sample :bd_haus`. To play any file on your computer use a full path such as `sample "/path/to/sample.wav"`.
# 
# There are many opts for manipulating the playback. For example, the `rate:` opt affects both the speed and the pitch of the playback. To control the rate of the sample in a pitch-meaningful way take a look at the `rpitch:` opt.
# 
# The sampler synth has three separate envelopes - one for amplitude, one for a low pass filter and another for a high pass filter. These work very similar to the standard synth envelopes except for two major differences. Firstly, the envelope times do not stretch or shrink to match the BPM. Secondly, the sustain time by default stretches to make the envelope fit the length of the sample. This is explained in detail in the tutorial.
# 
# Samples are loaded on-the-fly when first requested (and subsequently remembered). If the sample loading process takes longer than the schedule ahead time, the sample trigger will be skipped rather than be played late and out of time. To avoid this you may preload any samples you wish to work with using `load_sample` or `load_samples`.
# 
# It is possible to set the `start:` and `finish:` positions within the sample to play only a sub-section of it. These values can be automatically chosen based on an onset detection algorithm which will essentially isolate each individual drum or synth hit in the sample and let you access each one by an integer index (floats will be rounded to the nearest integer value). See the `onset:` docstring and examples for more information.
# 
# Finally, the sampler supports a powerful filtering system to make it easier to work with large folders of samples. The filter commands must be used before the first standard opt. There are six kinds of filter parameters you may use:
# 
# 1. Folder strings - `"/foo/bar"` - which will add all samples within the folder to the set of candidates.
# 2. Recursive folder strings - `"/foo/bar/**"` - Folder strings ending with `**` will add all samples contained within all subfolders (searched recursively).
# 3. Sample strings - `"/path/to/sample.wav"` - which will add the specific sample to the set of candidates.
# 4. Other strings - `"foobar"` - which will filter the candidates based on whether the filename contains the string.
# 5. Regular expressions - `/b[aA]z.*/` - which will filter the candidates based on whether the regular expression matches the filename.
# 6. Keywords - `:quux` - will filter the candidates based on whether the keyword is a direct match of the filename (without extension).
# 7. Numbers - `0` - will select the candidate with that index (wrapping round like a ring if necessary).
# 8. Lists of the above - `["/foo/bar", "baz", /0-9.*/]` - will recurse down and work through the internal filter parameters as if they were in the top level.
# 9. Lambdas - `lambda {|s| [s.choose] }` - the ultimate power tool for filters. Allows you to create a custom fn which receives a list of candidates as an arg and which should return a new list of candidates (this may be smaller, larger, re-ordered it's up to you).
# 
# By combining commands which add to the candidates and then filtering those candidates it is possible to work with folders full of samples in very powerful ways. Note that the specific ordering of filter parameters is irrelevant with the exception of the numbers - in which case the last number is the index. All the candidates will be gathered first before the filters are applied.
# @param _name_or_path [symbol_or_string]
# @param rate Rate with which to play back the sample. Higher rates mean an increase in pitch and a decrease in duration. Default is 1.
# @param beat_stretch Stretch (or shrink) the sample to last for exactly the specified number of beats. Please note - this does *not* keep the pitch constant and is essentially the same as modifying the rate directly.
# @param pitch_stretch Stretch (or shrink) the sample to last for exactly the specified number of beats. This attempts to keep the pitch constant using the `pitch:` opt. Note, it's very likely you'll need to experiment with the `window_size:`, `pitch_dis:` and `time_dis:` opts depending on the sample and the amount you'd like to stretch/shrink from original size.
# @param attack Time to reach full volume. Default is 0.
# @param sustain Time to stay at full volume. Default is to stretch to length of sample (minus attack and release times).
# @param release Time (from the end of the sample) to go from full amplitude to 0. Default is 0.
# @param start Position in sample as a fraction between 0 and 1 to start playback. Default is 0.
# @param finish Position in sample as a fraction between 0 and 1 to end playback. Default is 1.
# @param pan Stereo position of audio. -1 is left ear only, 1 is right ear only, and values in between position the sound accordingly. Default is 0.
# @param amp Amplitude of playback.
# @param pre_amp Amplitude multiplier which takes place immediately before any internal FX such as the low pass filter, compressor or pitch modification. Use this opt if you want to overload the compressor.
# @param onset Analyse the sample with an onset detection algorithm and set the `start:` and `finish:` opts to play the nth onset only. Allows you to treat a rhythm sample as a palette of individual drum/synth hits. Floats are rounded to the nearest whole number.
# @param slice Divides the sample duration evenly into `num_slices` sections (defaults to 16) and set the `start:` and `finish:` opts to play the nth slice only. Use the envelope opts to remove any clicks introduced if the slice boundary is in the middle of a sound. Also consider `onset:`. Floats are rounded to the nearest whole number.
# @param num_slices Number of slices to divide the sample into when using the `slice:` opt. Defaults to 16. Floats are rounded to the nearest whole number.
# @param norm Normalise the audio (make quieter parts of the sample louder and louder parts quieter) - this is similar to the normaliser FX. This may emphasise any clicks caused by clipping.
# @param lpf Cutoff value of the built-in low pass filter (lpf) in MIDI notes. Unless specified, the lpf is *not* added to the signal chain.
# @param lpf_init_level The initial low pass filter envelope value as a MIDI note. This envelope is bypassed if no lpf env opts are specified. Default value is to match the `lpf_min:` opt.
# @param lpf_attack_level The peak lpf cutoff (value of cutoff at peak of attack) as a MIDI note. Default value is to match the `lpf_decay_level:` opt.
# @param lpf_decay_level The level of lpf cutoff after the decay phase as a MIDI note. Default value is to match the `lpf_sustain_level:` opt.
# @param lpf_sustain_level The sustain cutoff (value of lpf cutoff at sustain time) as a MIDI note. Default value is to match the `lpf_release_level:` opt.
# @param lpf_release_level The final value of the low pass filter envelope as a MIDI note. This envelope is bypassed if no lpf env opts are specified. Default value is to match the `lpf:` opt.
# @param lpf_attack Attack time for lpf cutoff filter. Amount of time (in beats) for sound to reach full cutoff value. Default value is set to match amp envelope's attack value.
# @param lpf_decay Decay time for lpf cutoff filter. Amount of time (in beats) for sound to move from full cutoff value (cutoff attack level) to the cutoff sustain level. Default value is set to match amp envelope's decay value.
# @param lpf_sustain Amount of time for lpf cutoff value to remain at sustain level in beats. When -1 (the default) will auto-stretch.
# @param lpf_release Amount of time (in beats) for sound to move from lpf cutoff sustain value to lpf cutoff min value. Default value is set to match amp envelope's release value.
# @param lpf_min Starting value of the lpf cutoff envelope. Default is 30.
# @param lpf_env_curve Select the shape of the curve between levels in the lpf cutoff envelope. 1=linear, 2=exponential, 3=sine, 4=welch, 6=squared, 7=cubed.
# @param hpf Cutoff value of the built-in high pass filter (hpf) in MIDI notes. Unless specified, the hpf is *not* added to the signal chain.
# @param hpf_init_level The initial high pass filter envelope value as a MIDI note. This envelope is bypassed if no hpf env opts are specified. Default value is set to 130.
# @param hpf_attack_level The peak hpf cutoff (value of cutoff at peak of attack) as a MIDI note. Default value is to match the `hpf_decay_level:` opt.
# @param hpf_decay_level The level of hpf cutoff after the decay phase as a MIDI note. Default value is to match the `hpf_sustain_level:` opt.
# @param hpf_sustain_level The sustain cutoff (value of hpf cutoff at sustain time) as a MIDI note. Default value is to match the `hpf_release_level:` opt.
# @param hpf_release_level The sustain hpf cutoff (value of hpf cutoff at sustain time) as a MIDI note. Default value is to match the `hpf:` opt.
# @param hpf_attack Attack time for hpf cutoff filter. Amount of time (in beats) for sound to reach full cutoff value. Default value is set to match amp envelope's attack value.
# @param hpf_decay Decay time for hpf cutoff filter. Amount of time (in beats) for sound to move from full cutoff value (cutoff attack level) to the cutoff sustain level. Default value is set to match amp envelope's decay value.
# @param hpf_sustain Amount of time for hpf cutoff value to remain at sustain level in beats. When -1 (the default) will auto-stretch.
# @param hpf_release Amount of time (in beats) for sound to move from hpf cutoff sustain value to hpf cutoff min value. Default value is set to match amp envelope's release value.
# @param hpf_env_curve Select the shape of the curve between levels in the hpf cutoff envelope. 1=linear, 2=exponential, 3=sine, 4=welch, 6=squared, 7=cubed.
# @param hpf_max Maximum value of the high pass filter envelope. Default is 200.
# @param rpitch Rate modified pitch. Multiplies the rate by the appropriate ratio to shift up or down the specified amount in MIDI notes. Please note - this does *not* keep the duration and rhythmical rate constant and is essentially the same as modifying the rate directly.
# @param pitch Pitch adjustment in semitones. 1 is up a semitone, 12 is up an octave, -12 is down an octave etc. Maximum upper limit of 24 (up 2 octaves). Lower limit of -72 (down 6 octaves). Decimal numbers can be used for fine tuning.
# @param window_size Pitch shift-specific opt - only honoured if the `pitch:` opt is used. Pitch shift works by chopping the input into tiny slices, then playing these slices at a higher or lower rate. If we make the slices small enough and overlap them, it sounds like the original sound with the pitch changed. The window_size is the length of the slices and is measured in seconds. It needs to be around 0.2 (200ms) or greater for pitched sounds like guitar or bass, and needs to be around 0.02 (20ms) or lower for percussive sounds like drum loops. You can experiment with this to get the best sound for your input.
# @param pitch_dis Pitch shift-specific opt - only honoured if the `pitch:` opt is used. Pitch dispersion - how much random variation in pitch to add. Using a low value like 0.001 can help to "soften up" the metallic sounds, especially on drum loops. To be really technical, pitch_dispersion is the maximum random deviation of the pitch from the pitch ratio (which is set by the `pitch:` opt).
# @param time_dis Pitch shift-specific opt - only honoured if the `pitch:` opt is used. Time dispersion - how much random delay before playing each grain (measured in seconds). Again, low values here like 0.001 can help to soften up metallic sounds introduced by the effect. Large values are also fun as they can make soundscapes and textures from the input, although you will most likely lose the rhythm of the original. NB - This won't have an effect if it's larger than window_size.
# @param compress Enable the compressor. This sits at the end of the internal FX chain immediately before the `amp:` opt. Therefore to drive the compressor use the `pre_amp:` opt which will amplify the signal before it hits any internal FX. The compressor compresses the dynamic range of the incoming signal. Equivalent to automatically turning the amp down when the signal gets too loud and then back up again when it's quiet. Useful for ensuring the containing signal doesn't overwhelm other aspects of the sound. Also a general purpose hard-knee dynamic range processor which can be tuned via the opts to both expand and compress the signal.
# @param threshold Threshold value determining the break point between slope_below and slope_above. Only valid if the compressor is enabled by turning on the `compress:` opt.
# @param slope_below Slope of the amplitude curve below the threshold. A value of 1 means that the output of signals with amplitude below the threshold will be unaffected. Greater values will magnify and smaller values will attenuate the signal. Only valid if the compressor is enabled by turning on the `compress:` opt.
# @param slope_above Slope of the amplitude curve above the threshold. A value of 1 means that the output of signals with amplitude above the threshold will be unaffected. Greater values will magnify and smaller values will attenuate the signal. Only valid if the compressor is enabled by turning on the `compress:` opt.
# @param clamp_time Time taken for the amplitude adjustments to kick in fully (in seconds). This is usually pretty small (not much more than 10 milliseconds). Also known as the time of the attack phase. Only valid if the compressor is enabled by turning on the `compress:` opt.
# @param relax_time Time taken for the amplitude adjustments to be released. Usually a little longer than clamp_time. If both times are too short, you can get some (possibly unwanted) artefacts. Also known as the time of the release phase. Only valid if the compressor is enabled by turning on the `compress:` opt.
# @param slide Default slide time in beats for all slide opts. Individually specified slide opts will override this value.
# @param path Path of the sample to play. Typically this opt is rarely used instead of the more powerful source/filter system. However it can be useful when working with pre-made opt maps.
# @accepts_block true
# @introduced 2.0.0
# @example
#   # Play a built-in sample
#   sample :loop_amen # Plays the Amen break
#
# @example
#   # Play two samples at the same time
#   # with incredible timing accuracy
#   sample :loop_amen
#   sample :ambi_lunar_land # Note, for timing guarantees select the pref:
#                           #   Studio -> Synths and FX -> Enforce timing guarantees
#
# @example
#   # Create a simple repeating bass drum
#   live_loop :bass do
#     sample :bd_haus
#     sleep 0.5
#   end
#
# @example
#   # Create a more complex rhythm with multiple live loops:
#   live_loop :rhythm do
#     sample :tabla_ghe3 if (spread 5, 7).tick
#     sleep 0.125
#   end
#   live_loop :bd, sync: :rhythm do
#     sample :bd_haus, lpf: 90, amp: 2
#     sleep 0.5
#   end
#
# @example
#   # Change the playback speed of the sample using rate:
#   sample :loop_amen, rate: 0.5 # Play the Amen break at half speed
#                                # for old school hip-hop
#
# @example
#   # Speed things up
#   sample :loop_amen, rate: 1.5 # Play the Amen break at 1.5x speed
#                                # for a jungle/gabba sound
#
# @example
#   # Go backwards
#   sample :loop_amen, rate: -1 # Negative rates play the sample backwards
#
# @example
#   # Fast rewind
#   sample :loop_amen, rate: -3 # Play backwards at 3x speed for a fast rewind effect
#
# @example
#   # Start mid sample
#   sample :loop_amen, start: 0.5 # Start playback half way through
#
# @example
#   # Finish mid sample
#   sample :loop_amen, finish: 0.5 # Finish playback half way through
#
# @example
#   # Play part of a sample
#   sample :loop_amen, start: 0.125, finish: 0.25 # Play the second eighth of the sample
#
# @example
#   # Finishing before the start plays backwards
#   sample :loop_amen, start: 0.25, finish: 0.125 # Play the second eighth of the sample backwards
#
# @example
#   # Play a section of a sample at quarter speed backwards
#   sample :loop_amen, start: 0.125, finish: 0.25, rate: -0.25 # Play the second eighth of the
#                                                              # amen break backwards at a
#                                                              # quarter speed
#
# @example
#   # Control a sample synchronously
#   s = sample :loop_amen, lpf: 70
#   sleep 0.5
#   control s, lpf: 130
#   sleep 0.5
#   synth :dsaw, note: :e3 # This is triggered 1s from start
#
# @example
#   # Controlling a sample asynchronously
#   sample :loop_amen, lpf: 70 do |s|
#     sleep 1                                # This block is run in an implicit in_thread
#     control s, lpf: 130                    # and therefore is asynchronous
#   end
#   sleep 0.5
#   synth :dsaw, note: :e3 # This is triggered 0.5s from start
#
# @example
#   # Play with slices
#   sample :loop_garzul, slice: 0      # => play the first 16th of the sample
#   sleep 0.5
#   4.times do
#     sample :loop_garzul, slice: 1    # => play the second 16th of the sample 4 times
#     sleep 0.125
#   end
#   sample :loop_garzul, slice: 4, num_slices: 4, rate: -1      # => play the final quarter backwards
#
# @example
#   # Build a simple beat slicer
#   use_sample_bpm :loop_amen                    # Set the BPM to match the amen break sample
#   live_loop :beat_slicer do
#     n = 8                                      # Specify number of slices
#                                                # (try changing to 2, 4, 6, 16 or 32)
#     s = rand_i n                               # Choose a random slice within range
#     sample :loop_amen, slice: s, num_slices: n # Play the specific part of the sample
#     sleep 1.0/n                                # Sleep for the duration of the slice
#   end
#
# @example
#   # Play with the built-in low pass filter, high pass filter and compressor
#   sample :loop_amen, lpf: 80, hpf: 70, compress: 1, pre_amp: 10 # Make the amen break sound punchy.
#
# @example
#   # Use the cutoff filter envelopes
#   sample :loop_garzul, lpf_attack: 8 # Sweep the low pass filter up over 8 beats
#   sleep 8
#   sample :loop_garzul, hpf_attack: 8 # Sweep the high pass filter down over 8 beats
#
# @example
#   # Sample stretching
#   puts sample_duration :loop_industrial                   # => 0.88347
#   puts sample_duration :loop_industrial, beat_stretch: 1  # => 1
#   live_loop :industrial do
#     sample :loop_industrial, beat_stretch: 1              # Stretch the sample to make it 1 beat long
#     sleep 1                                               # This now loops perfectly.
#                                                           # However, note that stretching/shrinking
#                                                           # also modifies the pitch.
#   end
#
# @example
#   # Sample shrinking
#   puts sample_duration :loop_garzul                       # => 8
#   puts sample_duration :loop_garzul, beat_stretch: 6      # => 6
#   live_loop :garzul do
#     sample :loop_garzul, beat_stretch: 6                  # As :loop_garzul is longer than 6 beats
#                                                           # it is shrunk to fit. This increases the
#                                                           # pitch.
#     sleep 6
#   end
#
# @example
#   # Sample stretching matches the BPM
#   use_bpm 30                                              # Set the BPM to 30
#   puts sample_duration :loop_garzul                       # => 4.0 (at 30 BPM the sample lasts for 4 beats)
#   puts sample_duration :loop_garzul, beat_stretch: 6      # => 6.0
#   live_loop :garzul do
#     sample :loop_garzul, beat_stretch: 6                  # The sample is stretched to match 6 beats at 30 BPM
#     sleep 6
#   end
#
# @example
#   # External samples
#   sample "/path/to/sample.wav"                          # Play any Wav, Aif or FLAC sample on your computer
#                                                           # by simply passing a string representing the full
#                                                           # path
#
# @example
#   # Sample pack filtering
#   dir = "/path/to/dir/of/samples"                       # You can easily work with a directory of samples
#   sample dir                                              # Play the first sample in the directory
#                                                           # (it is sorted alphabetically)
#   sample dir, 1                                           # Play the second sample in the directory
#   sample dir, 99                                          # Play the 100th sample in the directory, or if there
#                                                           # are fewer, treat the directory like a ring and keep
#                                                           # wrapping the index round until a sample is found.
#                                                           # For example, if there are 90 samples, the 10th sample
#                                                           # is played (index 9).
#   sample dir, "120"                                     # Play the first sample in the directory that contains
#                                                           # the substring "120".
#                                                           # For example, this may be "beat1_120_rave.wav"
#   sample dir, "120", 1                                  # Play the second sample in the directory that contains
#                                                           # the substring "120".
#                                                           # For example, this may be "beat2_120_rave.wav"
#   sample dir, /beat[0-9]/                                 # Play the first sample in the directory that matches
#                                                           # the regular expression /beat[0-9]/.
#                                                           # For example, this may be "beat0_100_trance.wav"
#                                                           # You may use the full power of Ruby's regular expression
#                                                           # system here: http://ruby-doc.org/core-2.1.1/Regexp.html
#   sample dir, /beat[0-9]0/, "100"                       # Play the first sample in the directory that both matches
#                                                           # the regular expression /beat[0-9]0/ and contains the
#                                                           # the substring "100".
#                                                           # For example, this may be "beat10_100_rave.wav"
#
# @example
#   # Filtering built-in samples
#                                                           # If you don't pass a directory source, you can filter over
#                                                           # the built-in samples.
#   sample "tabla_"                                       # Play the first built-in sample that contains the substring
#                                                           # "tabla"
#   sample "tabla_", 2                                    # Play the third built-in sample that contains the substring
#                                                           # "tabla"
#
# @example
#   # Play with whole directories of samples
#   load_samples "tabla_"                                 # You may pass any of the source/filter options to load_samples
#                                                           # to load all matching samples. This will load all the built-in
#                                                           # samples containing the substring "tabla_"
#   live_loop :tabla do
#     sample "tabla_", tick                               # Treat the matching samples as a ring and tick through them
#     sleep 0.125
#   end
#
# @example
#   # Specify multiple sources
#   dir1 = "/path/to/sample/directory"
#   dir2 = "/path/to/other/sample/directory"
#   sample dir1, dir2, "foo"                              # Match the first sample that contains the string "foo" out of
#                                                           # all the samples in dir1 and dir2 combined.
#                                                           # Note that the sources must be listed before any filters.
#
# @example
#   # List contents recursively
#   dir = "/path/to/sample/directory"                     # By default the list of all top-level samples within the directory
#                                                           # is considered.
#   dir_recursive = "/path/to/sample/directory/**"        # However, if you finish your directory string with ** then if that
#                                                           # directory contains other directories then the samples within the
#                                                           # subdirectories and their subsubdirectories in turn are considered.
#   sample dir, 0                                           # Play the first top-level sample in the directory
#   sample dir_recursive, 0                                 # Play the first sample found after combining all samples found in
#                                                           # the directory and all directories within it recursively.
#                                                           # Note that if there are many sub directories this may take some time
#                                                           # to execute. However, the result is cached so subsequent calls will
#                                                           # be fast.
#
# @example
#   # Bespoke filters
#   filter = lambda do |candidates|                         # If the built-in String, Regexp and index filters are not sufficient
#     [candidates.choose]                                   # you may write your own. They need to be a function which takes a list
#   end                                                     # of paths to samples and return a list of samples. This one returns a
#                                                           # list of a single randomly selected sample.
#   8.times do
#     sample "drum_", filter                              # Play 8 randomly selected samples from the built-in sample set that also
#     sleep 0.25                                            # contain the substring "drum_"
#   end
#
# @example
#   # Basic Onset Detection
#   
#   sample :loop_tabla, start: 0, finish: 0.00763           # If you know the right start: and finish: values, you can extract a
#                                                           # single drum hit from a longer sample. However, finding these values
#                                                           # can be very time consuming.
#   sleep 1
#                                                           # Instead of specifying the start: and finish: values manually you can
#                                                           # use the onset: option to find them for you using an integer index.
#   sample :loop_tabla, onset: 0                            # onset: 0 will set the start: and finish: values so that the first
#                                                           # percussive sound (something that shifts from quiet to loud quickly)
#                                                           # is picked out.
#   sleep 1
#   
#   sample :loop_tabla, onset: 1                            # We can easily find the second percussive sound in the sample with
#                                                           # onset: 1
#
# @example
#   # Ticking through onsets
#   
#                                                           # The onsets are actually a ring so the index will wrap around. This
#                                                           # means that if there are only 8 onsets in a sample, specifying an
#                                                           # onset of 100 will still return one of the 8 onsets. This means we
#                                                           # can use tick to work through each onset in sequence. This allows us
#                                                           # to redefine the rhythm and tempo of a sample
#   
#   
#   live_loop :tabla do
#     use_bpm 50                                            # We can choose our own BPM here - it doesn't need to match the sample
#     sample :loop_tabla, onset: tick                       # tick through each onset in sequence
#     sleep [0.125, 0.25].choose                            # randomly choose a delay between onset triggers
#   end
#
# @example
#   # Random Onset Triggering
#                                                           # We can easily pick a random onset using the pick fn
#   use_bpm 50
#   live_loop :tabla do
#     sample :loop_tabla, onset: pick                       # Each time round the live loop we now trigger a random onset
#     sleep [0.125, 0.25].choose                            # creating an infinite stream of randomly selected drums
#   end
#
# @example
#   # Repeatable Random Onsets
#                                                           # Instead of an infinite stream of choices, we can combine iteration
#                                                           # and use_random_seed to create repeatable riffs:
#   live_loop :tabla do
#     use_random_seed 30000                                 # every 8 times, reset the random seed, this resets the riff
#     8.times do
#       sample :loop_tabla, onset: pick
#       sleep [0.125, 0.25].choose
#     end
#   end
#
# @example
#   #  Random Onset Duration
#                                                               # Each onset has a variable length (determined by the sample contents).
#                                                               # Therefore, if you wish to ensure each onset has a specific length it
#                                                               # is necessary to use the sample's amplitude envelope.
#                                                               # As the sample's envelope automatically changes the sustain: value to
#                                                               # match the duration - you also need to override this with a value of 0.
#   live_loop :tabla do
#     sample :loop_tabla, onset: pick, sustain: 0, release: 0.1 # Each drum onset will now be no longer than 0.1. Note that the envelope
#                                                               # for a sample only determines the maximum duration of a sample trigger.
#                                                               # If the actual audible duration of the onset is smaller than 0.1 then
#                                                               # it will *not* be extended.
#     sleep [0.125, 0.25].choose
#   end
#
# @example
#   # Onset lambdas
#   
#                                                           # The onset index can be a lambda as well as an integer. If a lambda is
#                                                           # given, it will be passed a ring of all of the onsets as an argument.
#                                                           # This will be a ring of maps:
#   
#   l = lambda {|c| puts c ; c[0]}                          # define a lambda which accepts a single argument, prints it and
#                                                           # returns the first value. This particular example is essentially
#                                                           # the same as using onset: 0 with the side effect of also printing out
#                                                           # the full ring of onsets:
#   
#   sample :loop_tabla, onset: l                            # (ring {:start=>0.0, :finish=>0.0076}, {:start=>0.0076, :finish 0.015}...)
#   
#                                                           # We are therefore free to define this lambda to do anything we want.
#                                                           # This gives us very powerful control over the choice of onset. It is
#                                                           # unlikely you will use this frequently, but it is a powerful tool
#                                                           # that's there when you need it.
#
def sample(_name_or_path = nil, rate: nil, beat_stretch: nil, pitch_stretch: nil, attack: nil, sustain: nil, release: nil, start: nil, finish: nil, pan: nil, amp: nil, pre_amp: nil, onset: nil, slice: nil, num_slices: nil, norm: nil, lpf: nil, lpf_init_level: nil, lpf_attack_level: nil, lpf_decay_level: nil, lpf_sustain_level: nil, lpf_release_level: nil, lpf_attack: nil, lpf_decay: nil, lpf_sustain: nil, lpf_release: nil, lpf_min: nil, lpf_env_curve: nil, hpf: nil, hpf_init_level: nil, hpf_attack_level: nil, hpf_decay_level: nil, hpf_sustain_level: nil, hpf_release_level: nil, hpf_attack: nil, hpf_decay: nil, hpf_sustain: nil, hpf_release: nil, hpf_env_curve: nil, hpf_max: nil, rpitch: nil, pitch: nil, window_size: nil, pitch_dis: nil, time_dis: nil, compress: nil, threshold: nil, slope_below: nil, slope_above: nil, clamp_time: nil, relax_time: nil, slide: nil, path: nil)
  #This is a stub, used for indexing
end

# Get sample data
# Alias for the `load_sample` method. Loads sample if necessary and returns buffer information.
# @param _path [string]
# @accepts_block false
# @introduced 2.0.0
# @example
#   see load_sample
#
def sample_buffer(_path = nil)
  #This is a stub, used for indexing
end

# Get duration of sample in beats
# Given the name of a loaded sample, or a path to a `.wav`, `.wave`, `.aif`, `.aiff`, `.ogg`, `.oga` or `.flac` file returns the length of time in beats that the sample would play for. `sample_duration` understands and accounts for all the opts you can pass to `sample` which have an effect on the playback duration such as `rate:`. The time returned is scaled to the current BPM.
# 
# *Note:* avoid using `sample_duration` to set the sleep time in `live_loop`s, prefer stretching the sample with the `beat_stretch:` opt or changing the BPM instead. See the examples below for details.
# @param _path [string]
# @param rate Rate modifier. For example, doubling the rate will halve the duration.
# @param start Start position of sample playback as a value from 0 to 1
# @param finish Finish position of sample playback as a value from 0 to 1
# @param attack Duration of the attack phase of the envelope.
# @param decay Duration of the decay phase of the envelope.
# @param sustain Duration of the sustain phase of the envelope.
# @param release Duration of the release phase of the envelope.
# @param beat_stretch Change the rate of the sample so that its new duration matches the specified number of beats.
# @param pitch_stretch Change the rate of the sample so that its new duration matches the specified number of beats but attempt to preserve pitch.
# @param rpitch Change the rate to shift the pitch up or down the specified number of MIDI notes.
# @accepts_block false
# @introduced 2.0.0
# @example
#   # Simple use
#   puts sample_duration(:loop_garzul) # returns 8.0 because this sample is 8 seconds long
#
# @example
#   # The result is scaled to the current BPM
#   use_bpm 120
#   puts sample_duration(:loop_garzul) # => 16.0
#   use_bpm 90
#   puts sample_duration(:loop_garzul) # => 12.0
#   use_bpm 21
#   puts sample_duration(:loop_garzul) # => 2.8
#
# @example
#   # Avoid using sample_duration to set the sleep time in live_loops
#   
#   live_loop :avoid_this do               # It is possible to use sample_duration to drive the frequency of a live loop.
#     with_fx :slicer do                   # However, if you're using a rhythmical sample such as a drum beat and it isn't
#       sample :loop_amen                  # in the same BPM as the current BPM, then the FX such as this slicer will be
#       sleep sample_duration(:loop_amen)  # badly out of sync. This is because the slicer slices at the current BPM and
#     end                                  # this live_loop is looping at a different BPM (that of the sample)
#   end
#   
#   live_loop :prefer_this do              # Instead prefer to set the BPM of the live_loop to match the sample. It has
#     use_sample_bpm :loop_amen            # two benefits. Now our sleep is a nice and simple 1 (as it's one beat).
#     with_fx :slicer do                   # Also, our slicer now works with the beat and sounds much better.
#       sample :loop_amen
#       sleep 1
#     end
#   end
#   
#   live_loop :or_this do                  # Alternatively we can beat_stretch the sample to match the current BPM. This has the
#     with_fx :slicer do                   # side effect of changing the rate of the sample (and hence the pitch). However, the
#       sample :loop_amen, beat_stretch: 1 # FX works nicely in time and the sleep time is also a simple 1.
#       sleep 1
#     end
#   end
#
# @example
#   # The standard sample opts are also honoured
#   
#                                                                     # Playing a sample at standard speed will return standard length
#   sample_duration :loop_garzul, rate: 1                             # => 8.0
#   
#                                                                     # Playing a sample at half speed will double duration
#   sample_duration :loop_garzul, rate: 0.5                           # => 16.0
#   
#                                                                     # Playing a sample at double speed will halve duration
#   sample_duration :loop_garzul, rate: 2                             # => 4.0
#   
#                                                                     # Playing a sample backwards at double speed will halve duration
#   sample_duration :loop_garzul, rate: -2                            # => 4.0
#   
#                                                                     # Without an explicit sustain: opt attack: just affects amplitude not duration
#   sample_duration :loop_garzul, attack: 1                           # => 8.0
#   sample_duration :loop_garzul, attack: 100                         # => 8.0
#   sample_duration :loop_garzul, attack: 0                           # => 8.0
#   
#                                                                     # Without an explicit sustain: opt release: just affects amplitude not duration
#   sample_duration :loop_garzul, release: 1                          # => 8.0
#   sample_duration :loop_garzul, release: 100                        # => 8.0
#   sample_duration :loop_garzul, release: 0                          # => 8.0
#   
#                                                                     # Without an explicit sustain: opt decay: just affects amplitude not duration
#   sample_duration :loop_garzul, decay: 1                            # => 8.0
#   sample_duration :loop_garzul, decay: 100                          # => 8.0
#   sample_duration :loop_garzul, decay: 0                            # => 8.0
#   
#                                                                     # With an explicit sustain: opt, if the attack + decay + sustain + release envelope
#                                                                     # duration is less than the sample duration time, the envelope will shorten the
#                                                                     # sample time.
#   sample_duration :loop_garzul, sustain: 0, attack: 0.5             # => 0.5
#   sample_duration :loop_garzul, sustain: 0, decay: 0.1              # => 0.1
#   sample_duration :loop_garzul, sustain: 0, release: 1              # => 1.0
#   sample_duration :loop_garzul, sustain: 2, attack: 0.5, release: 1 # => 3.5
#   
#                                                                     # If the envelope duration is longer than the sample it will not affect the
#                                                                     # sample duration
#   sample_duration :loop_garzul, sustain: 0, attack: 8, release: 3   # => 8
#   
#   
#                                                                     # All other opts are taken into account before the comparison with the envelope opts.
#   sample_duration :loop_garzul, rate: 10                            # => 0.8
#   sample_duration :loop_garzul, sustain: 0, attack: 0.9, rate: 10   # => 0.8 (The duration of the sample is less than the envelope length so wins)
#   
#   
#                                                                     # The rpitch: opt will modify the rate to shift the pitch of the sample up and down
#                                                                     # and therefore affects duration.
#   sample_duration :loop_garzul, rpitch: 12                          # => 4.0
#   sample_duration :loop_garzul, rpitch: -12                         # => 16
#   
#                                                                     # The rpitch: and rate: opts combine together.
#   sample_duration :loop_garzul, rpitch: 12, rate: 2                 # => 2.0
#   
#                                                                     # The beat_stretch: opt stretches the sample so that its duration matches the value.
#                                                                     # It also combines with rate:
#   sample_duration :loop_garzul, beat_stretch: 3                     # => 3.0
#   sample_duration :loop_garzul, beat_stretch: 3, rate: 0.5          # => 6.0
#   
#                                                                     # The pitch_stretch: opt acts identically to beat_stretch when just considering sample
#                                                                     # duration.
#   sample_duration :loop_garzul, pitch_stretch: 3                    # => 3.0
#   sample_duration :loop_garzul, pitch_stretch: 3, rate: 0.5         # => 6.0
#   
#                                                                     # The start: and finish: opts can also shorten the sample duration and also combine
#                                                                     # with other opts such as rate:
#   sample_duration :loop_garzul, start: 0.5                          # => 4.0
#   sample_duration :loop_garzul, start: 0.5, finish: 0.75            # => 2.0
#   sample_duration :loop_garzul, finish: 0.5, start: 0.75            # => 2.0
#   sample_duration :loop_garzul, rate: 2, finish: 0.5, start: 0.75 # => 1.0
#
# @example
#   # Triggering samples one after another
#   
#   sample :loop_amen                    # start the :loop_amen sample
#   sleep sample_duration(:loop_amen)    # wait for the duration of :loop_amen before
#   sample :loop_amen                    # starting it again
#
def sample_duration(_path = nil, rate: nil, start: nil, finish: nil, attack: nil, decay: nil, sustain: nil, release: nil, beat_stretch: nil, pitch_stretch: nil, rpitch: nil)
  #This is a stub, used for indexing
end

# Free a sample on the synth server
# Frees the memory and resources consumed by loading the sample on the server. Subsequent calls to `sample` and friends will re-load the sample on the server.
# 
# You may also specify the same set of source and filter pre-args available to `sample` itself. `sample_free` will then free all matching samples. See `sample`'s docs for more information.
# @param _path [string]
# @accepts_block false
# @introduced 2.9.0
# @example
#   sample :loop_amen # The Amen break is now loaded into memory and played
#   sleep 2
#   sample :loop_amen # The Amen break is not loaded but played from memory
#   sleep 2
#   sample_free :loop_amen # The Amen break is freed from memory
#   sample :loop_amen # the Amen break is re-loaded and played
#
# @example
#   puts sample_info(:loop_amen).to_i # This returns the buffer id of the sample i.e. 1
#   puts sample_info(:loop_amen).to_i # The buffer id remains constant whilst the sample
#                                     # is loaded in memory
#   sample_free :loop_amen
#   puts sample_info(:loop_amen).to_i # The Amen break is re-loaded and gets a *new* id.
#
# @example
#   sample :loop_amen
#   sample :ambi_lunar_land
#   sleep 2
#   sample_free :loop_amen, :ambi_lunar_land
#   sample :loop_amen                        # re-loads and plays amen
#   sample :ambi_lunar_land                  # re-loads and plays lunar land
#
# @example
#   # Using source and filter pre-args
#   dir = "/path/to/sample/dir"
#   sample_free dir # frees any loaded samples in "/path/to/sample/dir"
#   sample_free dir, 1 # frees sample with index 1 in "/path/to/sample/dir"
#   sample_free dir, :foo # frees sample with name "foo" in "/path/to/sample/dir"
#   sample_free dir, /[Bb]ar/ # frees sample which matches regex /[Bb]ar/ in "/path/to/sample/dir"
#
def sample_free(_path = nil)
  #This is a stub, used for indexing
end

# Free all loaded samples on the synth server
# Unloads all samples therefore freeing the memory and resources consumed. Subsequent calls to `sample` and friends will re-load the sample on the server.
# @accepts_block false
# @introduced 2.9.0
# @example
#   sample :loop_amen        # load and play :loop_amen
#   sample :ambi_lunar_land  # load and play :ambi_lunar_land
#   sleep 2
#   sample_free_all
#   sample :loop_amen        # re-loads and plays amen
#
def sample_free_all
  #This is a stub, used for indexing
end

# Get all sample groups
# Return a list of all the sample groups available
# @accepts_block false
# @introduced 2.0.0
def sample_groups
  #This is a stub, used for indexing
end

# Get sample information
# Alias for the `load_sample` method. Loads sample if necessary and returns sample information.
# @param _path [string]
# @accepts_block false
# @introduced 2.0.0
# @example
#   see load_sample
#
def sample_info(_path = nil)
  #This is a stub, used for indexing
end

# Test if sample was pre-loaded
# Given a path to a `.wav`, `.wave`, `.aif`, `.aiff`, `.ogg`, `.oga` or `.flac` file, returns `true` if the sample has already been loaded.
# @param _path [string]
# @accepts_block false
# @introduced 2.2.0
# @example
#   load_sample :elec_blip # :elec_blip is now loaded and ready to play as a sample
#   puts sample_loaded? :elec_blip # prints true because it has been pre-loaded
#   puts sample_loaded? :misc_burp # prints false because it has not been loaded
#
def sample_loaded?(_path = nil)
  #This is a stub, used for indexing
end

# Get sample names
# Return a ring of sample names for the specified group
# @param _group [symbol]
# @accepts_block false
# @introduced 2.0.0
def sample_names(_group = nil)
  #This is a stub, used for indexing
end

# Sample Pack Filter Resolution
# Accepts the same pre-args and opts as `sample` and returns a ring of matched sample paths.
# @param _pre_args [source_and_filter_types]
# @accepts_block false
# @introduced 2.10.0
# @example
#   sample_paths "/path/to/samples/" #=> ring of all top-level samples in /path/to/samples
#
# @example
#   sample_paths "/path/to/samples/**" #=> ring of all nested samples in /path/to/samples
#
# @example
#   sample_paths "/path/to/samples/", "foo" #=> ring of all samples in /path/to/samples
#                                                   containing the string "foo" in their filename.
#
def sample_paths(_pre_args = nil)
  #This is a stub, used for indexing
end

# Create scale
# Creates a ring of MIDI note numbers when given a tonic note and a scale name. Also takes an optional `num_octaves:` parameter (octave `1` is the default). If only passed the scale name, the tonic defaults to 0. See examples.
# @param _tonic [symbol]
# @param _name [symbol]
# @param num_octaves The number of octaves you'd like the scale to consist of. More octaves means a larger scale. Default is 1.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts (scale :C, :major) # returns the following ring of MIDI note numbers: (ring 60, 62, 64, 65, 67, 69, 71, 72)
#
# @example
#   # anywhere you can use a list or ring of notes, you can also use scale
#   play_pattern (scale :C, :major)
#
# @example
#   # you can use the :num_octaves parameter to get more notes
#   play_pattern (scale :C, :major, num_octaves: 2)
#
# @example
#   # Scales can start with any note:
#   puts (scale 50, :minor) #=> (ring 50, 52, 53, 55, 57, 58, 60, 62)
#   puts (scale 50.1, :minor) #=> (ring 50.1, 52.1, 53.1, 55.1, 57.1, 58.1, 60.1, 62.1)
#   puts (scale :minor) #=> (ring 0, 2, 3, 5, 7, 8, 10, 12)
#
# @example
#   # scales are also rings
#   live_loop :scale_player do
#     play (scale :Eb3, :super_locrian).tick, release: 0.1
#     sleep 0.125
#   end
#
# @example
#   # scales starting with 0 are useful in combination with sample's rpitch:
#   live_loop :scaled_sample do
#     sample :bass_trance_c, rpitch: (scale 0, :minor).tick
#     sleep 1
#   end
#
# @example
#   # Sonic Pi supports a large range of scales:
#   
#   (scale :C, :diatonic)
#   (scale :C, :ionian)
#   (scale :C, :major)
#   (scale :C, :dorian)
#   (scale :C, :phrygian)
#   (scale :C, :lydian)
#   (scale :C, :mixolydian)
#   (scale :C, :aeolian)
#   (scale :C, :minor)
#   (scale :C, :locrian)
#   (scale :C, :hex_major6)
#   (scale :C, :hex_dorian)
#   (scale :C, :hex_phrygian)
#   (scale :C, :hex_major7)
#   (scale :C, :hex_sus)
#   (scale :C, :hex_aeolian)
#   (scale :C, :minor_pentatonic)
#   (scale :C, :yu)
#   (scale :C, :major_pentatonic)
#   (scale :C, :gong)
#   (scale :C, :egyptian)
#   (scale :C, :shang)
#   (scale :C, :jiao)
#   (scale :C, :zhi)
#   (scale :C, :ritusen)
#   (scale :C, :whole_tone)
#   (scale :C, :whole)
#   (scale :C, :chromatic)
#   (scale :C, :harmonic_minor)
#   (scale :C, :melodic_minor_asc)
#   (scale :C, :hungarian_minor)
#   (scale :C, :octatonic)
#   (scale :C, :messiaen1)
#   (scale :C, :messiaen2)
#   (scale :C, :messiaen3)
#   (scale :C, :messiaen4)
#   (scale :C, :messiaen5)
#   (scale :C, :messiaen6)
#   (scale :C, :messiaen7)
#   (scale :C, :super_locrian)
#   (scale :C, :hirajoshi)
#   (scale :C, :kumoi)
#   (scale :C, :neapolitan_major)
#   (scale :C, :bartok)
#   (scale :C, :bhairav)
#   (scale :C, :locrian_major)
#   (scale :C, :ahirbhairav)
#   (scale :C, :enigmatic)
#   (scale :C, :neapolitan_minor)
#   (scale :C, :pelog)
#   (scale :C, :augmented2)
#   (scale :C, :scriabin)
#   (scale :C, :harmonic_major)
#   (scale :C, :melodic_minor_desc)
#   (scale :C, :romanian_minor)
#   (scale :C, :hindu)
#   (scale :C, :iwato)
#   (scale :C, :melodic_minor)
#   (scale :C, :diminished2)
#   (scale :C, :marva)
#   (scale :C, :melodic_major)
#   (scale :C, :indian)
#   (scale :C, :spanish)
#   (scale :C, :prometheus)
#   (scale :C, :diminished)
#   (scale :C, :todi)
#   (scale :C, :leading_whole)
#   (scale :C, :augmented)
#   (scale :C, :purvi)
#   (scale :C, :chinese)
#   (scale :C, :lydian_minor)
#   (scale :C, :blues_major)
#   (scale :C, :blues_minor)
#
def scale(_tonic = nil, _name = nil, num_octaves: nil)
  #This is a stub, used for indexing
end

# All scale names
# Returns a ring containing all scale names known to Sonic Pi
# @accepts_block false
# @introduced 2.6.0
# @example
#   puts scale_names #=>  prints a list of all the scales
#
def scale_names
  #This is a stub, used for indexing
end

# Return information about the internal SuperCollider sound server
# Create a map of information about the running audio synthesiser SuperCollider. 
# @accepts_block false
# @introduced 2.11.0
# @example
#   puts scsynth_info  #=>  (map sample_rate: 44100.0,
#                               #         sample_dur: 2.2675736545352265e-05,
#                               #         radians_per_sample: 0.00014247585204429924,
#                               #         control_rate: 689.0625,
#                               #         control_dur: 0.001451247138902545,
#                               #         subsample_offset: 0.0,
#                               #         num_output_busses: 16.0,
#                               #         num_input_busses: 16.0,
#                               #         num_audio_busses: 1024.0,
#                               #         num_control_busses: 4096.0,
#                               #         num_buffers: 4096.0)
#
def scsynth_info
  #This is a stub, used for indexing
end

# Globally modify audio latency
# On some systems with certain configurations (such as wireless speakers, and even a typical Windows environment with the default audio drivers) the audio latency can be large. If all the user is doing is generating audio via calls such as `play`, `synth` and `sample`, then this latency essentially adds to the schedule ahead time and for the most part can be ignored. However, if the user is combining audio with external MIDI/OSC triggered events, this latency can result in a noticeable offset. This function allows you to address this offset by moving the audio events forwards and backwards in time.
# 
# So, for example, if your audio system has an audio latency of 150ms, you can compensate for this by setting Sonic Pi's latency to be a negative value: `set_audio_latency! -150`.
# @param _milliseconds [number]
# @accepts_block false
# @introduced 3.1.0
# @example
#   set_audio_latency! 100 # Audio events will now be scheduled 100ms
#                                                     # after the schedule ahead time
#
# @example
#   set_audio_latency! -200 # Audio events will now be scheduled 200ms
#                                                     # before the schedule ahead time
#
def set_audio_latency!(_milliseconds = nil)
  #This is a stub, used for indexing
end

# Global Cent tuning
# Globally tune Sonic Pi to play with another external instrument.
# 
# Uniformly tunes your music by shifting all notes played by the specified number of cents. To shift up by a cent use a cent tuning of 1. To shift down use negative numbers. One semitone consists of 100 cents.
# 
# See `use_cent_tuning` for setting the cent tuning value locally for a specific thread or `live_loop`. This is a global value and will shift the tuning for *all* notes. It will also persist for the entire session.
# 
# Important note: the cent tuning set by `set_cent_tuning!` is independent of any thread-local cent tuning values set by `use_cent_tuning` or `with_cent_tuning`. 
# @param _cent_shift [number]
# @accepts_block false
# @introduced 2.10.0
# @example
#   play 50 # Plays note 50
#   set_cent_tuning! 1
#   play 50 # Plays note 50.01
#
def set_cent_tuning!(_cent_shift = nil)
  #This is a stub, used for indexing
end

# Set control delta globally
# Specify how many seconds between successive modifications (i.e. trigger then controls) of a specific node on a specific thread. Set larger if you are missing control messages sent extremely close together in time.
# @param _time [number]
# @accepts_block false
# @introduced 2.1.0
# @example
#   set_control_delta! 0.1                 # Set control delta to 0.1
#   
#   s = play 70, release: 8, note_slide: 8 # Play a note and set the slide time
#   control s, note: 82                    # immediately start sliding note.
#                                          # This control message might not be
#                                          # correctly handled as it is sent at the
#                                          # same virtual time as the trigger.
#                                          # If you don't hear a slide, try increasing the
#                                          # control delta until you do.
#
def set_control_delta!(_time = nil)
  #This is a stub, used for indexing
end

# Control master mixer
# The master mixer is the final mixer that all sound passes through. This fn gives you control over the master mixer allowing you to manipulate all the sound playing through Sonic Pi at once. For example, you can sweep a lpf or hpf over the entire sound. You can reset the controls back to their defaults with `reset_mixer!`.
# @param pre_amp Controls the amplitude of the signal prior to the FX stage of the mixer (prior to lpf/hpf stages). Has slide opts. Default 1.
# @param amp Controls the amplitude of the signal after the FX stage. Has slide opts. Default 1.
# @param hpf Global hpf FX. Has slide opts. Default 0.
# @param lpf Global lpf FX. Has slide opts. Default 135.5.
# @param hpf_bypass Bypass the global hpf. 0=no bypass, 1=bypass. Default 0.
# @param lpf_bypass Bypass the global lpf. 0=no bypass, 1=bypass. Default 0.
# @param limiter_bypass Bypass the final limiter. 0=no bypass, 1=bypass. Default 0.
# @param leak_dc_bypass Bypass the final DC leak correction FX. 0=no bypass, 1=bypass. Default 0.
# @accepts_block false
# @introduced 2.7.0
# @example
#   set_mixer_control! lpf: 30, lpf_slide: 16 # slide the global lpf to 30 over 16 beats.
#
def set_mixer_control!(pre_amp: nil, amp: nil, hpf: nil, lpf: nil, hpf_bypass: nil, lpf_bypass: nil, limiter_bypass: nil, leak_dc_bypass: nil)
  #This is a stub, used for indexing
end

# Set the bit depth for recording wav files
# When you hit the record button, Sonic Pi saves all the audio you can hear into a wav file. By default, this file uses a resolution of 16 bits which is the same as CD audio and good enough for most use cases. However, when working with professional equipment, it is common to want to work with even higher quality files such as 24 bits and even 32 bits. This function allows you to switch the default from 16 to one of 8, 16, 24 or 32.
# @param _bit_depth [number]
# @accepts_block false
# @introduced 2.11.0
# @example
#   set_recording_bit_depth! 24                 # Set recording bit depth to 24
#
def set_recording_bit_depth!(_bit_depth = nil)
  #This is a stub, used for indexing
end

# Set sched ahead time globally
# Specify how many seconds ahead of time the synths should be triggered. This represents the amount of time between pressing 'Run' and hearing audio. A larger time gives the system more room to work with and can reduce performance issues in playing fast sections on slower platforms. However, a larger time also increases latency between modifying code and hearing the result whilst live coding.
# @param _time [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   set_sched_ahead_time! 1 # Code will now run approximately 1 second ahead of audio.
#
def set_sched_ahead_time!(_time = nil)
  #This is a stub, used for indexing
end

# Set Volume globally
# Set the main system volume to `vol`. Accepts a value between `0` and `5` inclusive. Vols greater or smaller than the allowed values are trimmed to keep them within range. Default is `1`.
# @param _vol [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   set_volume! 2 # Set the main system volume to 2
#
# @example
#   set_volume! -1 # Out of range, so sets main system volume to 0
#
# @example
#   set_volume! 7 # Out of range, so sets main system volume to 5
#
def set_volume!(_vol = nil)
  #This is a stub, used for indexing
end

# Randomise order of a list
# Returns a new list with the same elements as the original but with their order shuffled. Also works for strings
# @param _list [array]
# @accepts_block false
# @introduced 2.1.0
# @example
#   shuffle [1, 2, 3, 4] #=> Would return something like: [3, 4, 2, 1]
#
# @example
#   shuffle "foobar"  #=> Would return something like: "roobfa"
#
def shuffle(_list = nil)
  #This is a stub, used for indexing
end

# Wait for beat duration
# Wait for a number of beats before triggering the next command. Beats are converted to seconds by scaling to the current bpm setting.
# @param _beats [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   # Without calls to sleep, all sounds would happen at once:
#   
#     play 50  # This is actually a chord with all notes played simultaneously
#     play 55
#     play 62
#   
#     sleep 1  # Create a gap, to allow a moment's pause for reflection...
#   
#     play 50  # Let's try the chord again, but this time with sleeps:
#     sleep 0.5 # With the sleeps, we turn a chord into an arpeggio
#     play 55
#     sleep 0.5
#     play 62
#
# @example
#   # The amount of time sleep pauses for is scaled to match the current bpm. The default bpm is 60. Let's double it:
#   
#     use_bpm 120
#     play 50
#     sleep 1 # This actually sleeps for 0.5 seconds as we're now at double speed
#     play 55
#     sleep 1
#     play 62
#   
#     # Let's go down to half speed:
#   
#     use_bpm 30
#     play 50
#     sleep 1 # This now sleeps for 2 seconds as we're now at half speed.
#     play 55
#     sleep 1
#     play 62
#
def sleep(_beats = nil)
  #This is a stub, used for indexing
end

# Print a string representing a list of numeric values as a spark graph/bar chart
# Given a list of numeric values, this method turns them into a string of bar heights and prints them out. Useful for quickly graphing the shape of an array.
# @accepts_block false
# @introduced 2.5.0
# @example
#   spark (range 1, 5)    #=> ▁▃▅█
#
# @example
#   spark (range 1, 5).shuffle #=> ▃█▅▁
#
def spark
  #This is a stub, used for indexing
end

# Returns a string representing a list of numeric values as a spark graph/bar chart
# Given a list of numeric values, this method turns them into a string of bar heights. Useful for quickly graphing the shape of an array. Remember to use puts so you can see the output. See `spark` for a simple way of printing a spark graph.
# @accepts_block false
# @introduced 2.5.0
# @example
#   puts (spark_graph (range 1, 5))    #=> ▁▃▅█
#
# @example
#   puts (spark_graph (range 1, 5).shuffle) #=> ▃█▅▁
#
def spark_graph
  #This is a stub, used for indexing
end

# Euclidean distribution for beats
# Creates a new ring of boolean values which space a given number of accents as evenly as possible throughout a bar. This is an implementation of the process described in 'The Euclidean Algorithm Generates Traditional Musical Rhythms' (Toussaint 2005).
# @param _num_accents [number]
# @param _size [number]
# @param rotate rotate to the next strong beat allowing for easy permutations of the original rhythmic grouping (see example)
# @accepts_block false
# @introduced 2.4.0
# @example
#   (spread 3, 8)    #=> (ring true, false, false, true, false, false, true, false) a spacing of 332
#
# @example
#   (spread 3, 8, rotate: 1) #=> (ring true, false, false, true, false, true, false, false) a spacing of 323
#
# @example
#   # Easily create interesting polyrhythmic beats
#     live_loop :euclid_beat do
#       sample :elec_bong, amp: 1.5 if (spread 3, 8).tick # Spread 3 bongs over 8
#       sample :perc_snap, amp: 0.8 if (spread 7, 11).look # Spread 7 snaps over 11
#       sample :bd_haus, amp: 2 if (spread 1, 4).look # Spread 1 bd over 4
#       sleep 0.125
#     end
#
# @example
#   # Spread descriptions from
#     # 'The Euclidean Algorithm Generates Traditional Musical Rhythms' (Toussaint 2005).
#     (spread 2, 5)  # A thirteenth century Persian rhythm called Khafif-e-ramal.
#   
#     (spread 3, 4)  # The archetypal pattern of the Cumbria from Columbia, as well
#                    # as a Calypso rhythm from Trinidad
#   
#     (spread 3, 5)  # When started on the second onset, is another thirteenth
#                    # century Persian rhythm by the name of Khafif-e-ramal, as well
#                    # as a Romanian folk-dance rhythm.
#   
#     (spread 3, 7)  # A ruchenitza rhythm used in a Bulgarian folk-dance.
#   
#     (spread 3, 8)  # The Cuban tresillo pattern
#   
#     (spread 4, 7)  # Another Ruchenitza Bulgarian folk-dance rhythm
#   
#     (spread 4, 9)  # The Aksak rhythm of Turkey.
#   
#     (spread 4, 11) # The metric pattern used by Frank Zappa in his piece Outside Now
#   
#     (spread 5, 6)  # Yields the York-Samai pattern, a popular Arab rhythm, when
#                    # started on the second onset.
#   
#     (spread 5, 7)  # The Nawakhat pattern, another popular Arab rhythm.
#   
#     (spread 5, 8)  # The Cuban cinquillo pattern.
#   
#     (spread 5, 9)  # A popular Arab rhythm called Agsag-Samai.
#   
#     (spread 5, 11) # The metric pattern used by Moussorgsky in Pictures at an
#                    # Exhibition
#   
#     (spread 5, 12) # The Venda clapping pattern of a South African children's
#                    # song.
#   
#     (spread 5, 16) # The Bossa-Nova rhythm necklace of Brazil.
#   
#     (spread 7, 8)  # A typical rhythm played on the Bendir (frame drum)
#   
#     (spread 7, 12) # A common West African bell pattern.
#   
#     (spread 7, 16) # A Samba rhythm necklace from Brazil.
#   
#     (spread 9, 16) # A rhythm necklace used in the Central African Republic.
#   
#     (spread 11, 24) # A rhythm necklace of the Aka Pygmies of Central Africa.
#   
#     (spread 13, 24) # Another rhythm necklace of the Aka Pygmies of the upper
#                     # Sangha.
#
def spread(_num_accents = nil, _size = nil, rotate: nil)
  #This is a stub, used for indexing
end

# Get server status
# This returns a Hash of information about the synthesis environment. Mostly used for debugging purposes.
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts status # Returns something similar to:
#               # {
#               #   :ugens=>10,
#               #   :synths=>1,
#               #   :groups=>7,
#               #   :sdefs=>61,
#               #   :avg_cpu=>0.20156468451023102,
#               #   :peak_cpu=>0.36655542254447937,
#               #   :nom_samp_rate=>44100.0,
#               #   :act_samp_rate=>44099.9998411752,
#               #   :audio_busses=>2,
#               #   :control_busses=>0
#               # }
#
def status
  #This is a stub, used for indexing
end

# Stop current thread or run
# Stops the current thread or if not in a thread, stops the current run. Does not stop any running synths triggered previously in the run/thread or kill any existing sub-threads.
# @accepts_block false
# @introduced 2.5.0
# @example
#   sample :loop_amen #=> this sample is played until completion
#     sleep 0.5
#     stop                #=> signal to stop executing this run
#     sample :loop_garzul #=> this never executes
#
# @example
#   in_thread do
#       play 60      #=> this note plays
#       stop
#       sleep 0.5    #=> this sleep never happens
#       play 72      #=> this play never happens
#     end
#   
#     play 80  #=> this plays as the stop only affected the above thread
#
# @example
#   # Stopping live loops
#     live_loop :foo
#       sample :bd_haus
#       sleep 1
#       stop               # live loop :foo will now stop and no longer loop
#     end
#   
#     live_loop :bar       # live loop :bar will continue looping
#       sample :elec_blip
#       sleep 0.25
#     end
#
def stop
  #This is a stub, used for indexing
end

# Stretch a sequence of values
# Stretches a list of values each value repeated count times. Always returns a ring regardless of the type of the list that is stretched. To preserve type, consider using `.stretch` i.e. `(ramp 1, 2, 3).stretch(2) #=> (ramp 1, 1, 2, 2, 3, 3)`
# @param _list [anything]
# @param _count [number]
# @accepts_block false
# @introduced 2.6.0
# @example
#   (stretch [1,2], 3)    #=> (ring 1, 1, 1, 2, 2, 2)
#
# @example
#   (stretch [:e2, :c3], 1, [:c2, :d3], 2) #=> (ring :e2, :c3, :c2, :c2, :d3, :d3)
#
def stretch(_list = nil, _count = nil)
  #This is a stub, used for indexing
end

# Sync with other threads
# Pause/block the current thread until a `cue` heartbeat with a matching `cue_id` is received. When a matching `cue` message is received, unblock the current thread, and continue execution with the virtual time set to match the thread that sent the `cue` heartbeat. The current thread is therefore synced to the `cue` thread. If multiple cue ids are passed as arguments, it will `sync` on the first matching `cue_id`. The BPM of the cueing thread can optionally be inherited by using the bpm_sync: opt.
# @param _cue_id [symbol]
# @param bpm_sync Inherit the BPM of the cueing thread. Default is false
# @accepts_block false
# @introduced 2.0.0
# @example
#   in_thread do
#       sync :foo # this parks the current thread waiting for a foo sync message to be received.
#       sample :ambi_lunar_land
#     end
#   
#     sleep 5
#   
#     cue :foo # We send a sync message from the main thread.
#               # This then unblocks the thread above and we then hear the sample
#
# @example
#   in_thread do   # Start a metronome thread
#       loop do      # Loop forever:
#         cue :tick # sending tick heartbeat messages
#         sleep 0.5  # and sleeping for 0.5 beats between ticks
#       end
#     end
#   
#     # We can now play sounds using the metronome.
#     loop do                    # In the main thread, just loop
#       sync :tick               # waiting for :tick sync messages
#       sample :drum_heavy_kick  # after which play the drum kick sample
#     end
#
# @example
#   sync :foo, :bar # Wait for either a :foo or :bar cue
#
# @example
#   in_thread do   # Start a metronome thread
#       loop do      # Loop forever:
#         cue [:foo, :bar, :baz].choose # sending one of three tick heartbeat messages randomly
#         sleep 0.5  # and sleeping for 0.5 beats between ticks
#       end
#     end
#   
#     # We can now play sounds using the metronome:
#   
#     in_thread do
#       loop do                    # In the main thread, just loop
#         sync :foo               # waiting for :foo sync messages
#         sample :elec_beep  # after which play the elec beep sample
#       end
#     end
#   
#     in_thread do
#       loop do                    # In the main thread, just loop
#         sync :bar               # waiting for :bar sync messages
#         sample :elec_flip  # after which play the elec flip sample
#       end
#     end
#   
#     in_thread do
#       loop do                    # In the main thread, just loop
#         sync :baz               # waiting for :baz sync messages
#         sample :elec_blup  # after which play the elec blup sample
#       end
#     end
#
def sync(_cue_id = nil, bpm_sync: nil)
  #This is a stub, used for indexing
end

# Sync and inherit BPM from other threads 
# An alias for `sync` with the `bpm_sync:` opt set to true.
# @param _cue_id [symbol]
# @accepts_block false
# @introduced 2.10.0
# @example
#   See examples for sync
#
def sync_bpm(_cue_id = nil)
  #This is a stub, used for indexing
end

# Trigger specific synth
# Trigger specified synth with given opts. Bypasses `current_synth` value, yet still honours `current_synth_defaults`. When using `synth`, the note is no longer an explicit argument but an opt with the key `note:`.
# 
# If note: opt is `nil`, `:r` or `:rest`, play is ignored and treated as a rest. Also, if the `on:` opt is specified and returns `false`, or `nil` then play is similarly ignored and treated as a rest.
# 
# If the synth name is `nil` behaviour is identical to that of `play` in that the `current_synth` will determine the actual synth triggered.
# 
# If a block is given, it is assumed to take one arg which will be the controllable synth node and the body of the block is run in an implicit `in_thread`. This allows for asynchronous control of the synth without interferring with time. For synchronous control capture the result of `synth` as a variable and use that.
# 
# Note that the default opts listed are only a guide to the most common opts across all the synths. Not all synths support all the default opts and each synth typically supports many more opts specific to that synth. For example, the `:tb303` synth supports 45 unique opts. For a full list of a synth's opts see its documentation in the Help system. This can be accessed directly by clicking on the name of the synth and using the shortcut `C-i`
# @param _synth_name [symbol]
# @param amp The amplitude of the note
# @param amp_slide The duration in beats for amplitude changes to take place
# @param pan The stereo position of the sound. -1 is left, 0 is in the middle and 1 is on the right. You may use a value in between -1 and 1 such as 0.25
# @param pan_slide The duration in beats for the pan value to change
# @param attack Amount of time (in beats) for sound to reach full amplitude (attack_level). A short attack (i.e. 0.01) makes the initial part of the sound very percussive like a sharp tap. A longer attack (i.e 1) fades the sound in gently.
# @param decay Amount of time (in beats) for the sound to move from full amplitude (attack_level) to the sustain amplitude (sustain_level).
# @param sustain Amount of time (in beats) for sound to remain at sustain level amplitude. Longer sustain values result in longer sounds. Full length of sound is attack + decay + sustain + release.
# @param release Amount of time (in beats) for sound to move from sustain level amplitude to silent. A short release (i.e. 0.01) makes the final part of the sound very percussive (potentially resulting in a click). A longer release (i.e 1) fades the sound out gently.
# @param attack_level Amplitude level reached after attack phase and immediately before decay phase
# @param decay_level Amplitude level reached after decay phase and immediately before sustain phase. Defaults to sustain_level unless explicitly set
# @param sustain_level Amplitude level reached after decay phase and immediately before release phase.
# @param env_curve Select the shape of the curve between levels in the envelope. 1=linear, 2=exponential, 3=sine, 4=welch, 6=squared, 7=cubed
# @param slide Default slide time in beats for all slide opts. Individually specified slide opts will override this value
# @param pitch Pitch adjustment in semitones. 1 is up a semitone, 12 is up an octave, -12 is down an octave etc.  Decimal numbers can be used for fine tuning.
# @param on If specified and false/nil/0 will stop the synth from being played. Ensures all opts are evaluated.
# @accepts_block true
# @introduced 2.0.0
# @example
#   use_synth :beep            # Set current synth to :beep
#   play 60                    # Play note 60 with opt defaults
#   
#   synth :dsaw, note: 60    # Bypass current synth and play :dsaw
#                            # with note 60 and opt defaults
#
# @example
#   synth :fm, note: 60, amp: 0.5 # Play note 60 of the :fm synth with an amplitude of 0.5
#
# @example
#   use_synth_defaults release: 5
#   synth :dsaw, note: 50 # Play note 50 of the :dsaw synth with a release of 5
#
# @example
#   # You can play chords with the notes: opt:
#   synth :dsaw, notes: (chord :e3, :minor)
#
# @example
#   # on: vs if
#   notes = (scale :e3, :minor_pentatonic, num_octaves: 2)
#   
#   live_loop :rhyth do
#     8.times do
#       trig = (spread 3, 7).tick(:rhyth)
#       synth :tri, on: trig, note: notes.tick, release: 0.1  # Here, we're calling notes.tick
#                                                             # every time we attempt to play the synth
#                                                             # so the notes rise faster than rhyth2
#       sleep 0.125
#     end
#   end
#   
#   
#   live_loop :rhyth2 do
#     8.times do
#       trig = (spread 3, 7).tick(:rhyth)
#       synth :saw, note: notes.tick, release: 0.1 if trig  # Here, we're calling notes.tick
#                                                           # only when the spread says to play
#                                                           # so the notes rise slower than rhyth
#       sleep 0.125
#     end
#   end
#
# @example
#   # controlling a synth synchronously
#   s = synth :beep, note: :e3, release: 4
#   sleep 1
#   control s, note: :e5
#   sleep 0.5
#   synth :dsaw, note: :e3   # This is triggered after 1.5s from start
#
# @example
#   # Controlling a synth asynchronously
#   synth :beep, note: :e3, release: 4 do |s|
#     sleep 1                                               # This block is run in an implicit in_thread
#     control s, note: :e5                                  # and therefore is asynchronous
#   end
#   
#   sleep 0.5
#   synth :dsaw, note: :e3 # This is triggered after 0.5s from start
#
def synth(_synth_name = nil, amp: nil, amp_slide: nil, pan: nil, pan_slide: nil, attack: nil, decay: nil, sustain: nil, release: nil, attack_level: nil, decay_level: nil, sustain_level: nil, env_curve: nil, slide: nil, pitch: nil, on: nil)
  #This is a stub, used for indexing
end

# Get all synth names
# Return a list of all the synths available
# @accepts_block false
# @introduced 2.9.0
def synth_names
  #This is a stub, used for indexing
end

# Increment a tick and return value
# Increment the default tick by 1 and return value. Successive calls to `tick` will continue to increment the default tick. If a `key` is specified, increment that specific tick. If an increment `value` is specified, increment key by that value rather than 1. Ticks are `in_thread` and `live_loop` local, so incrementing a tick only affects the current thread's version of that tick. See `tick_reset` and `tick_set` for directly manipulating the tick vals.
# @param _key [symbol]
# @param step The amount to tick up by. Default is 1.
# @param offset Offset to add to index returned. Useful when calling tick on lists, rings and vectors to offset the returned value. Default is 0.
# @accepts_block false
# @introduced 2.6.0
# @example
#   puts tick #=> 0
#     puts tick #=> 1
#     puts tick #=> 2
#     puts tick #=> 3
#
# @example
#   puts tick(:foo) #=> 0 # named ticks have their own counts
#     puts tick(:foo) #=> 1
#     puts tick(:foo) #=> 2
#     puts tick(:bar) #=> 0 # tick :bar is independent of tick :foo
#
# @example
#   # Each_live loop has its own separate ticks
#     live_loop :fast_tick do
#       puts tick   # the fast_tick live_loop's tick will
#       sleep 2     # be updated every 2 seconds
#     end
#   
#     live_loop :slow_tick do
#       puts tick   # the slow_tick live_loop's tick is
#       sleep 4     # totally independent from the fast_tick
#                   # live loop and will be updated every 4
#                   # seconds
#     end
#
# @example
#   live_loop :regular_tick do
#       puts tick   # the regular_tick live_loop's tick will
#       sleep 1     # be updated every second
#     end
#   
#     live_loop :random_reset_tick do
#       if one_in 3 # randomly reset tick
#         tick_reset
#         puts "reset tick!"
#       end
#       puts tick   # this live_loop's tick is totally
#       sleep 1     # independent and the reset only affects
#                   # this tick.
#     end
#
# @example
#   # Ticks work directly on lists, and will tick through each element
#     # However, once they get to the end, they'll return nil
#     live_loop :scale do
#       play [:c, :d, :e, :f, :g].tick   # play all notes just once, then rests
#       sleep 1
#     end
#
# @example
#   # Normal ticks interact directly with list ticks
#     live_loop :odd_scale do
#       tick  # Increment the default tick
#       play [:c, :d, :e, :f, :g, :a].tick   # this now play every *other* note just once,
#                                            # then rests
#       sleep 1
#     end
#
# @example
#   # Ticks work wonderfully with rings
#     # as the ring ensures the tick wraps
#     # round internally always returning a
#     # value
#     live_loop :looped_scale do
#       play (ring :c, :d, :e, :f, :g).tick   # play all notes just once, then repeats
#       sleep 1
#     end
#
# @example
#   # Ticks work wonderfully with scales
#     # which are also rings
#     live_loop :looped_scale do
#       play (scale :e3, :minor_pentatonic).tick   # play all notes just once, then repeats
#       sleep 0.25
#     end
#
def tick(_key = nil, step: nil, offset: nil)
  #This is a stub, used for indexing
end

# Reset tick to 0
# Reset default tick to 0. If a `key` is referenced, set that tick to 0 instead. Same as calling tick_set(0)
# @accepts_block false
# @introduced 2.6.0
# @example
#   # increment default tick a few times
#     tick
#     tick
#     tick
#     puts look #=> 2 (default tick is now 2)
#     tick_set 0 # default tick is now 0
#     puts look #=> 0 (default tick is now 0
#
# @example
#   # increment tick :foo a few times
#     tick :foo
#     tick :foo
#     tick :foo
#     puts look(:foo) #=> 2 (tick :foo is now 2)
#     tick_set 0 # default tick is now 0
#     puts look(:foo) #=> 2 (tick :foo is still 2)
#     tick_set :foo, 0 #  reset tick :foo
#     puts look(:foo) #=> 0 (tick :foo is now 0)
#
def tick_reset
  #This is a stub, used for indexing
end

# Reset all ticks
# Reset all ticks - default and keyed
# @accepts_block false
# @introduced 2.6.0
# @example
#   tick      # increment default tick and tick :foo
#     tick
#     tick :foo
#     tick :foo
#     tick :foo
#     puts look #=> 1
#     puts look(:foo) #=> 2
#     tick_reset_all
#     puts look #=> 0
#     puts look(:foo) #=> 0
#
def tick_reset_all
  #This is a stub, used for indexing
end

# Set tick to a specific value
# Set the default tick to the specified `value`. If a `key` is referenced, set that tick to `value` instead. Next call to `look` will return `value`.
# @param _value [number]
# @accepts_block false
# @introduced 2.6.0
# @example
#   tick_set 40 # set default tick to 40
#     puts look   #=> 40
#
# @example
#   tick_set :foo, 40 # set tick :foo to 40
#     puts look(:foo)   #=> 40 (tick :foo is now 40)
#     puts look         #=> 0 (default tick is unaffected)
#
def tick_set(_value = nil)
  #This is a stub, used for indexing
end

# Shift time forwards or backwards for the given block
# The code within the given block is executed with the specified delta time shift specified in beats. For example, if the delta value is 0.1 then all code within the block is executed with a 0.1 beat delay. Negative values are allowed which means you can move a block of code *backwards in time*. For example a delta value of -0.1 will execute the code in the block 0.1 beats ahead of time. The time before the block started is restored after the execution of the block.
# 
# Given a list of times, run the block once after waiting each given time. If passed an optional params list, will pass each param individually to each block call. If size of params list is smaller than the times list, the param values will act as rings (rotate through). If the block is given 1 arg, the times are fed through. If the block is given 2 args, both the times and the params are fed through. A third block arg will receive the index of the time.
# 
# Note that the code within the block is executed synchronously with the code before and after, so all thread locals will be modified inline - as is the case for `with_fx`. However, as time is always restored to the value before `time_warp` started, you can use it to schedule events for the future in a similar fashion to a thread (via `at` or `in_thread`) without having to use an entirely fresh and distinct set of thread locals - see examples.
# 
# Also, note that you cannot travel backwards in time beyond the `current_sched_ahead_time`.
# 
# If the `time_warp` block is within a `density` block, the delta time is not affected (although all the other times such as sleep and phase durations will be affected) - see example.
# 
# `time_warp` is ahead-of-time scheduling within the current thread. See `at` for just-in-time scheduling using multiple isolated threads.
# @param _delta_time [number]
# @accepts_block true
# @introduced 2.11.0
# @example
#   # shift forwards in time
#   play 70            #=> plays at time 0
#   sleep 1
#   play 75            #=> plays at time 1
#   
#   time_warp 0.1 do
#                      # time shifts forward by 0.1 beats
#     play 80          #=> plays at 1.1
#     sleep 0.5
#     play 80          #=> plays at 1.6
#                      # time shifts back by 0.1 beats
#                      # however, the sleep 0.5 is still accounted for
#   end
#                      # we now honour the original sleep 1 and the
#                      # sleep 0.5 within the time_warp block, but
#                      # any time shift delta has been removed
#   play 70            #=> plays at 1.5
#
# @example
#   # shift backwards in time
#   
#   play 70            #=> plays at time 0
#   sleep 1
#   play 75            #=> plays at time 1
#   
#   time_warp -0.1 do
#                      # time shifts backwards by 0.1 beats
#     play 80          #=> plays at 0.9
#     sleep 0.5
#     play 80          #=> plays at 1.4
#                      # time shifts forward by 0.1 beats
#                      # however, the sleep 0.5 is still accounted for
#   end
#                      # we now honour the original sleep 1 and the
#                      # sleep 0.5 within the time_warp block, but
#                      # any time shift delta has been removed
#   play 70            #=> plays at 1.5
#
# @example
#   # Ticks count linearly through time_warp
#   
#   puts tick          #=> prints 0 (at time 0)
#   
#   sleep 1
#   
#   time_warp 2 do
#     puts tick        #=> prints 1 (at time 3)
#   end
#   
#   sleep 0.5
#   
#   puts tick          #=> prints 2 (at time 1.5)
#
# @example
#   # Comparing time_warp with at
#   
#   puts tick          #=> prints 0 (at time 0)
#   sleep 0.5
#   puts tick          #=> prints 1 (at time 0.5)
#   
#   time_warp 2 do
#     puts tick        #=> prints 2 (at time 2.5)
#     sleep 0.5
#     puts tick        #=> prints 3 (at time 3)
#   end
#   
#   at 3 do            # the at will reset all thread locals
#     puts tick        #=> prints 0 (At time 3.5)
#     sleep 0.5
#     puts tick        #=> prints 1 (At time 4)
#   end
#   
#   sleep 0.5
#   
#   puts tick          #=> prints 4 (at time 1)
#
# @example
#   # Time Warp within Density
#   density 2 do                        # Typically this will double the BPM and affect all times
#                                       # in addition to looping the internal block twice
#     time_warp 0.5 do                  # However, this time is *not* affected and will remain 0.5
#       with_fx :slicer, phase: 0.5 do  # This phase duration *is* affected and will be 0.25
#         play 60
#         sleep 1                       # This time *will* be affected by the density and be 0.5
#       end
#     end
#   
#   end
#
# @example
#   # Time Warp with lists of times
#   
#   time_warp [0, 1, 2, 3] do
#     puts "hello"                # Will print "hello" at 0, 1, 2, and 3 seconds
#   end
#                                   # Notice that the run completes before all the
#                                   # messages have been delivered. This is because it
#                                   # schedules all the messages at once so the program
#                                   # can complete immediately. This is unlike at which
#                                   # would appear to behave similarly, but would wait
#                                   # for all messages to be delivered (on time) before
#                                   # allowing the program to complete.
#
# @example
#   time_warp [1, 2, 4] do  # plays a note after waiting 1 beat,
#       play 75                # then after 1 more beat,
#     end                      # then after 2 more beats (4 beats total)
#
# @example
#   time_warp [1, 2, 3], [75, 76, 77] do |n|  # plays 3 different notes
#       play n
#     end
#
# @example
#   time_warp [1, 2, 3],
#         [{:amp=>0.5}, {:amp=> 0.8}] do |p| # alternate soft and loud
#       sample :drum_cymbal_open, p          # cymbal hits three times
#     end
#
# @example
#   time_warp [0, 1, 2] do |t| # when no params are given to at, the times are fed through to the block
#       puts t #=> prints 0, 1, then 2
#     end
#
# @example
#   time_warp [0, 1, 2], [:a, :b] do |t, b|  # If you specify the block with 2 args, it will pass through both the time and the param
#       puts [t, b] #=> prints out [0, :a], [1, :b], then [2, :a]
#     end
#
# @example
#   time_warp [0, 0.5, 2] do |t, idx|  # If you specify the block with 2 args, and no param list to at, it will pass through both the time and the index
#       puts [t, idx] #=> prints out [0, 0], [0.5, 1], then [2, 2]
#     end
#
# @example
#   time_warp [0, 0.5, 2], [:a, :b] do |t, b, idx|  # If you specify the block with 3 args, it will pass through the time, the param and the index
#       puts [t, b, idx] #=> prints out [0, :a, 0], [0.5, :b, 1], then [2, :a, 2]
#     end
#
# @example
#   # time_warp consumes & interferes with the outer random stream
#   puts "main: ", rand  # 0.75006103515625
#   rand_back
#   time_warp 1 do         # the random stream inside the at block is the
#                          # same as the one in the outer block
#     puts "time_warp:", rand # 0.75006103515625
#     puts "time_warp:", rand # 0.733917236328125
#     rand_back           # undo last call to rand
#   end
#   
#   sleep 2
#   puts "main: ", rand # value is now 0.733917236328125 again
#
# @example
#   # Each block run inherits the same thread locals from the previous one.
#               # This means things like the thread local counters can flow through
#               # time warp iterations:
#   time_warp [0, 2] do
#               # first time round (after 1 beat) prints:
#     puts tick # 0
#     puts tick # 1
#   end
#               # second time round (after 2 beats) prints:
#               # 2
#               # 3
#
def time_warp(_delta_time = nil)
  #This is a stub, used for indexing
end

# Block level comment ignoring
# Evaluates all of the code within the block. Use to reverse the effect of the comment without having to explicitly remove it.
# @accepts_block true
# @introduced 2.0.0
# @example
#   uncomment do # starting a block level comment:
#       play 50 # played
#       sleep 1 # sleep happens
#       play 62 # played
#     end
#
def uncomment
  #This is a stub, used for indexing
end

# Enable and disable BPM scaling
# Turn synth argument bpm scaling on or off for the current thread. This is on by default. Note, using `rt` for args will result in incorrect times when used after turning arg bpm scaling off.
# @param _bool [boolean]
# @accepts_block false
# @introduced 2.0.0
# @example
#   use_bpm 120
#   play 50, release: 2 # release is actually 1 due to bpm scaling
#   sleep 2             # actually sleeps for 1 second
#   use_arg_bpm_scaling false
#   play 50, release: 2 # release is now 2
#   sleep 2             # still sleeps for 1 second
#
# @example
#   # Interaction with rt
#   use_bpm 120
#   play 50, release: rt(2) # release is 2 seconds
#   sleep rt(2)             # sleeps for 2 seconds
#   use_arg_bpm_scaling false
#   play 50, release: rt(2) # ** Warning: release is NOT 2 seconds! **
#   sleep rt(2)             # still sleeps for 2 seconds
#
def use_arg_bpm_scaling(_bool = nil)
  #This is a stub, used for indexing
end

# Enable and disable arg checks
# When triggering synths, each argument is checked to see if it is sensible. When argument checking is enabled and an argument isn't sensible, you'll see an error in the debug pane. This setting allows you to explicitly enable and disable the checking mechanism. See with_arg_checks for enabling/disabling argument checking only for a specific `do`/`end` block.
# @param _true_or_false [boolean]
# @accepts_block false
# @introduced 2.0.0
# @example
#   play 50, release: 5 # Args are checked
#   use_arg_checks false
#   play 50, release: 5 # Args are not checked
#
def use_arg_checks(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Set the tempo
# Sets the tempo in bpm (beats per minute) for everything afterwards. Affects all subsequent calls to `sleep` and all temporal synth arguments which will be scaled to match the new bpm. If you wish to bypass scaling in calls to sleep, see the fn `rt`. Also, if you wish to bypass time scaling in synth args see `use_arg_bpm_scaling`. See also `with_bpm` for a block scoped version of `use_bpm`.
# 
#   For dance music here's a rough guide for which BPM to aim for depending on your genre:
# 
#   * Dub: 60-90 bpm
#   * Hip-hop: 60-100 bpm
#   * Downtempo: 90-120 bpm
#   * House: 115-130 bpm
#   * Techno/trance: 120-140 bpm
#   * Dubstep: 135-145 bpm
#   * Drum and bass: 160-180 bpm
# @param _bpm [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   # default tempo is 60 bpm
#     4.times do
#       play 50, attack: 0.5, release: 0.25 # attack is 0.5s and release is 0.25s
#       sleep 1 # sleep for 1 second
#     end
#   
#     sleep 2  # sleep for 2 seconds
#   
#     # Let's make it go faster...
#     use_bpm 120  # double the bpm
#     4.times do
#       play 62, attack: 0.5, release: 0.25 # attack is scaled to 0.25s and release is now 0.125s
#       sleep 1 # actually sleeps for 0.5 seconds
#     end
#   
#     sleep 2 # sleep for 1 second
#   
#     # Let's make it go even faster...
#     use_bpm 240  #  bpm is 4x original speed!
#     8.times do
#       play 62, attack: 0.5, release: 0.25 # attack is scaled to 0.125s and release is now 0.0625s
#       sleep 1 # actually sleeps for 0.25 seconds
#     end
#
def use_bpm(_bpm = nil)
  #This is a stub, used for indexing
end

# Set new tempo as a multiple of current tempo
# Sets the tempo in bpm (beats per minute) as a multiplication of the current tempo. Affects all containing calls to `sleep` and all temporal synth arguments which will be scaled to match the new bpm. See also `use_bpm`
# @param _mul [number]
# @accepts_block false
# @introduced 2.3.0
# @example
#   use_bpm 60   # Set the BPM to 60
#     play 50
#     sleep 1      # Sleeps for 1 seconds
#     play 62
#     sleep 2      # Sleeps for 2 seconds
#     use_bpm_mul 0.5 # BPM is now (60 * 0.5) == 30
#     play 50
#     sleep 1           # Sleeps for 2 seconds
#     play 62
#
def use_bpm_mul(_mul = nil)
  #This is a stub, used for indexing
end

# Cent tuning
# Uniformly tunes your music by shifting all notes played by the specified number of cents. To shift up by a cent use a cent tuning of 1. To shift down use negative numbers. One semitone consists of 100 cents.
# 
# See `with_cent_tuning` for setting the cent tuning value only for a specific `do`/`end` block. To transpose entire semitones see `use_transpose`.
# @param _cent_shift [number]
# @accepts_block false
# @introduced 2.9.0
# @example
#   play 50 # Plays note 50
#   use_cent_tuning 1
#   play 50 # Plays note 50.01
#
def use_cent_tuning(_cent_shift = nil)
  #This is a stub, used for indexing
end

# Enable and disable cue logging
# Enable or disable log messages created on cues. This does not disable the cues themselves, it just stops them from being printed to the log
# @param _true_or_false [boolean]
# @accepts_block false
# @introduced 2.6.0
# @example
#   use_cue_logging true # Turn on cue messages
#
# @example
#   use_cue_logging false # Disable cue messages
#
def use_cue_logging(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Enable and disable debug
# Enable or disable messages created on synth triggers. If this is set to false, the synths will be silent until debug is turned back on. Silencing debug messages can reduce output noise and also increase performance on slower platforms. See `with_debug` for setting the debug value only for a specific `do`/`end` block.
# @param _true_or_false [boolean]
# @accepts_block false
# @introduced 2.0.0
# @example
#   use_debug true # Turn on debug messages
#
# @example
#   use_debug false # Disable debug messages
#
def use_debug(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Merge MIDI defaults
# Specify new default values to be used by all subsequent calls to `midi_*` fns. Merges the specified values with any previous defaults, rather than replacing them
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_note_on :e1 # Sends MIDI :e1 note_on with default opts
#   
#   use_midi_defaults channel: 3, port: "foo"
#   
#   midi_note_on :e3 # Sends MIDI :e3 note_on to channel 3 on port "foo"
#   
#   use_merged_midi_defaults channel: 1
#   
#   midi_note_on :e2 # Sends MIDI :e2 note_on to channel 1 on port "foo".
#                    # This is because the call to use_merged_midi_defaults overrode the
#                    # channel but not the port which got merged in.
#
def use_merged_midi_defaults
  #This is a stub, used for indexing
end

# Merge new sample defaults
# Specify new default values to be used by all subsequent calls to `sample`. Merges the specified values with any previous defaults, rather than replacing them.
# @accepts_block false
# @introduced 2.9.0
# @example
#   sample :loop_amen # plays amen break with default arguments
#   
#   use_merged_sample_defaults amp: 0.5, cutoff: 70
#   
#   sample :loop_amen # plays amen break with an amp of 0.5, cutoff of 70 and defaults for rest of args
#   
#   use_merged_sample_defaults cutoff: 90
#   
#   sample :loop_amen  # plays amen break with a cutoff of 90 and and an amp of 0.5 with defaults for rest of args
#
def use_merged_sample_defaults
  #This is a stub, used for indexing
end

# Merge synth defaults
# Specify synth arg values to be used by any following call to play. Merges the specified values with any previous defaults, rather than replacing them.
# @accepts_block false
# @introduced 2.0.0
# @example
#   play 50 #=> Plays note 50
#   
#   use_merged_synth_defaults amp: 0.5
#   play 50 #=> Plays note 50 with amp 0.5
#   
#   use_merged_synth_defaults cutoff: 80
#   play 50 #=> Plays note 50 with amp 0.5 and cutoff 80
#   
#   use_merged_synth_defaults amp: 0.7
#   play 50 #=> Plays note 50 with amp 0.7 and cutoff 80
#
# @example
#   use_synth_defaults amp: 0.5, cutoff: 80, pan: -1
#   use_merged_synth_defaults amp: 0.7
#   play 50 #=> Plays note 50 with amp 0.7, cutoff 80 and pan -1
#
def use_merged_synth_defaults
  #This is a stub, used for indexing
end

# Use new MIDI defaults
# Specify new default values to be used by all subsequent calls to `midi_*` fns. Will remove and override any previous defaults.
# @accepts_block false
# @introduced 3.0.0
# @example
#   midi_note_on :e1 # Sends MIDI :e1 note_on with default opts
#   
#   use_midi_defaults channel: 3, port: "foo"
#   
#   midi_note_on :e3 # Sends MIDI :e3 note_on to channel 3 on port "foo"
#   
#   use_midi_defaults channel: 1
#   
#   midi_note_on :e2 # Sends MIDI :e2 note_on to channel 1. Note that the port is back to the default and no longer "foo".
#
def use_midi_defaults
  #This is a stub, used for indexing
end

# Enable and disable MIDI logging
# Enable or disable log messages created on MIDI functions. This does not disable the MIDI functions themselves, it just stops them from being printed to the log
# @param _true_or_false [boolean]
# @accepts_block false
# @introduced 3.0.0
# @example
#   use_midi_logging true # Turn on MIDI logging
#
# @example
#   use_midi_logging false # Disable MIDI logging
#
def use_midi_logging(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Note octave transposition
# Transposes your music by shifting all notes played by the specified number of octaves. To shift up by an octave use a transpose of 1. To shift down use negative numbers. See `with_octave` for setting the octave shift only for a specific `do`/`end` block. For transposing the notes within the octave range see `use_transpose`.
# @param _octave_shift [number]
# @accepts_block false
# @introduced 2.9.0
# @example
#   play 50 # Plays note 50
#   use_octave 1
#   play 50 # Plays note 62
#
# @example
#   # You may change the transposition multiple times:
#   play 62 # Plays note 62
#   use_octave -1
#   play 62 # Plays note 50
#   use_octave 2
#   play 62 # Plays note 86
#
def use_octave(_octave_shift = nil)
  #This is a stub, used for indexing
end

# Set the default hostname and port number for outgoing OSC messages.
# Sets the destination host and port that `osc` will send messages to. If no port number is specified - will default to port 4559 (Sonic Pi's default OSC listening port).
# 
# OSC (Open Sound Control) is a simple way of passing messages between two separate programs on the same computer or even on different computers via a local network or even the internet. `use_osc` allows you to specify which computer (`hostname`) and program (`port`) to send messages to.
# 
# It is possible to send messages to the same computer by using the host name `"localhost"`
# 
# This is a thread-local setting - therefore each thread (or live loop) can have their own separate `use_osc` values.
# 
# Note that calls to `osc_send` will ignore these values.
# 
# @param _hostname [string]
# @param _port [number]
# @accepts_block false
# @introduced 3.0.0
# @example
#   # Send a simple OSC message to another program on the same machine
#   
#   use_osc "localhost", 7000  # Specify port 7000 on this machine
#   osc "/foo/bar"             # Send an OSC message with path "/foo/bar"
#                                # and no arguments
#
# @example
#   # Send an OSC messages with arguments to another program on the same machine
#   
#   use_osc "localhost", 7000        # Specify port 7000 on this machine
#   osc "/foo/bar" 1, 3.89, "baz"  # Send an OSC message with path "/foo/bar"
#                                      # and three arguments:
#                                      # 1) The whole number (integer) 1
#                                      # 2) The fractional number (float) 3,89
#                                      # 3) The string "baz"
#
# @example
#   # Send an OSC messages with arguments to another program on a different machine
#   
#   use_osc "10.0.1.5", 7000         # Specify port 7000 on the machine with address 10.0.1.5
#   osc "/foo/bar" 1, 3.89, "baz"  # Send an OSC message with path "/foo/bar"
#                                      # and three arguments:
#                                      # 1) The whole number (integer) 1
#                                      # 2) The fractional number (float) 3,89
#                                      # 3) The string "baz"
#
# @example
#   # use_osc only affects calls to osc until the next call to use_osc
#   
#   use_osc "localhost", 7000  # Specify port 7000 on this machine
#   osc "/foo/bar"             # Send an OSC message to port 7000
#   osc "/foo/baz"             # Send another OSC message to port 7000
#   
#   use_osc "localhost", 7005  # Specify port 7000 on this machine
#   osc "/foo/bar"             # Send an OSC message to port 7005
#   osc "/foo/baz"             # Send another OSC message to port 7005
#
# @example
#   # threads may have their own use_osc value
#   
#   use_osc "localhost", 7000  # Specify port 7000 on this machine
#   
#   live_loop :foo do
#     osc "/foo/bar"             # Thread inherits outside use_osc values
#     sleep 1                      # and therefore sends OSC messages to port 7000
#   end
#   
#   live_loop :bar do
#     use_osc "localhost", 7005  # Override OSC hostname and port for just this
#                                  # thread (live loop :bar). Live loop :foo is
#                                  # unaffected.
#   
#     osc "/foo/bar"             # Send OSC messages to port 7005
#     sleep 1
#   end
#   
#   use_osc "localhost", 7010  # Specify port 7010
#   osc "/foo/baz"             # Send another OSC message to port 7010
#                                # Note that neither live loops :foo or :bar
#                                # are affected (their use_osc values are
#                                # independent and isolated.
#
def use_osc(_hostname = nil, _port = nil)
  #This is a stub, used for indexing
end

# Enable and disable OSC logging
# Enable or disable log messages created on OSC functions. This does not disable the OSC functions themselves, it just stops them from being printed to the log
# @param _true_or_false [boolean]
# @accepts_block false
# @introduced 3.0.0
# @example
#   use_osc_logging true # Turn on OSC logging
#
# @example
#   use_osc_logging false # Disable OSC logging
#
def use_osc_logging(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Set random seed generator to known seed
# Resets the random number generator to the specified seed. All subsequently generated random numbers and randomisation functions such as `shuffle` and `choose` will use this new generator and the current generator is discarded. Use this to change the sequence of random numbers in your piece in a way that can be reproduced. Especially useful if combined with iteration. See examples.
# @param _seed [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   ## Basic usage
#   
#     use_random_seed 1 # reset random seed to 1
#     puts rand # => 0.417022004702574
#     use_random_seed 1 # reset random seed back to 1
#     puts rand  #=> 0.417022004702574
#
# @example
#   ## Generating melodies
#     notes = (scale :eb3, :minor_pentatonic)  # Create a set of notes to choose from.
#                                              # Scales work well for this
#   
#     with_fx :reverb do
#       live_loop :repeating_melody do         # Create a live loop
#   
#         use_random_seed 300                  # Set the random seed to a known value every
#                                              # time around the loop. This seed is the key
#                                              # to our melody. Try changing the number to
#                                              # something else. Different numbers produce
#                                              # different melodies
#   
#         8.times do                           # Now iterate a number of times. The size of
#                                              # the iteration will be the length of the
#                                              # repeating melody.
#   
#           play notes.choose, release: 0.1    # 'Randomly' choose a note from our ring of
#                                              # notes. See how this isn't actually random
#                                              # but uses a reproducible method! These notes
#                                              # are therefore repeated over and over...
#           sleep 0.125
#         end
#       end
#     end
#
def use_random_seed(_seed = nil)
  #This is a stub, used for indexing
end

# Set sched ahead time to 0 for the current thread
# 
# Set sched ahead time to 0 for the current thread. Shorthand for `use_sched_ahead_time 0`.
# 
# See `use_sched_ahead_time` for a version of this function which allows you to set the schedule ahead time to any arbitrary value. Note, `use_real_time` will override any value set with `set_sched_ahead_time!` for the current thread.
# 
# @accepts_block false
# @introduced 3.0.0
# @example
#   use_real_time 1 # Code will now run approximately 1 second ahead of audio.
#
def use_real_time
  #This is a stub, used for indexing
end

# Sample-duration-based bpm modification
# Modify bpm so that sleeping for 1 will sleep for the duration of the sample.
# @param _string_or_number [sample_name_or_duration]
# @param num_beats The number of beats within the sample. By default this is 1.
# @accepts_block false
# @introduced 2.1.0
# @example
#   use_sample_bpm :loop_amen  #Set bpm based on :loop_amen duration
#   
#   live_loop :dnb do
#     sample :bass_dnb_f
#     sample :loop_amen
#     sleep 1                  #`sleep`ing for 1 actually sleeps for duration of :loop_amen
#   end
#
# @example
#   use_sample_bpm :loop_amen, num_beats: 4  # Set bpm based on :loop_amen duration
#                                            # but also specify that the sample duration
#                                            # is actually 4 beats long.
#   
#   live_loop :dnb do
#     sample :bass_dnb_f
#     sample :loop_amen
#     sleep 4                  #`sleep`ing for 4 actually sleeps for duration of :loop_amen
#                              # as we specified that the sample consisted of
#                              # 4 beats
#   end
#
def use_sample_bpm(_string_or_number = nil, num_beats: nil)
  #This is a stub, used for indexing
end

# Use new sample defaults
# Specify new default values to be used by all subsequent calls to `sample`. Will remove and override any previous defaults.
# @accepts_block false
# @introduced 2.5.0
# @example
#   sample :loop_amen # plays amen break with default arguments
#   
#   use_sample_defaults amp: 0.5, cutoff: 70
#   
#   sample :loop_amen # plays amen break with an amp of 0.5, cutoff of 70 and defaults for rest of args
#   
#   use_sample_defaults cutoff: 90
#   
#   sample :loop_amen  # plays amen break with a cutoff of 90 and defaults for rest of args - note that amp is no longer 0.5
#
def use_sample_defaults
  #This is a stub, used for indexing
end

# Set sched ahead time for the current thread
# Specify how many seconds ahead of time the synths should be triggered. This represents the amount of time between pressing 'Run' and hearing audio. A larger time gives the system more room to work with and can reduce performance issues in playing fast sections on slower platforms. However, a larger time also increases latency between modifying code and hearing the result whilst live coding.
# 
# See `set_sched_ahead_time!` for a global version of this function. Note, `use_sched_ahead_time` will override any value set with `set_sched_ahead_time!` for the current thread.
# 
# See `use_real_time` for a simple way of setting the schedule ahead time to 0.
# @param _time [number]
# @accepts_block false
# @introduced 3.0.0
# @example
#   use_sched_ahead_time 1 # Code will now run approximately 1 second ahead of audio.
#
# @example
#   # Each thread can have its own sched ahead time
#   live_loop :foo do
#     use_sched_ahead_time 1
#     play 70                 # Note 70 will be played with 1 second latency
#     sleep 1
#   end
#   
#   live_loop :foo do
#     use_sched_ahead_time 0.5 # Note 70 will be played with 0.5 second latency
#     play 82
#     sleep 1
#   end
#
def use_sched_ahead_time(_time = nil)
  #This is a stub, used for indexing
end

# Switch current synth
# Switch the current synth to `synth_name`. Affects all further calls to `play`. See `with_synth` for changing the current synth only for a specific `do`/`end` block.
# @param _synth_name [symbol]
# @accepts_block false
# @introduced 2.0.0
# @example
#   play 50 # Plays with default synth
#   use_synth :mod_sine
#   play 50 # Plays with mod_sine synth
#
def use_synth(_synth_name = nil)
  #This is a stub, used for indexing
end

# Use new synth defaults
# Specify new default values to be used by all subsequent calls to `play`. Will remove and override any previous defaults.
# @accepts_block false
# @introduced 2.0.0
# @example
#   play 50 # plays note 50 with default arguments
#   
#   use_synth_defaults amp: 0.5, cutoff: 70
#   
#   play 50 # plays note 50 with an amp of 0.5, cutoff of 70 and defaults for rest of args
#   
#   use_synth_defaults cutoff: 90
#   
#   play 50 # plays note 50 with a cutoff of 90 and defaults for rest of args - note that amp is no longer 0.5
#
def use_synth_defaults
  #This is a stub, used for indexing
end

# Inhibit synth triggers if too late
# If set to true, synths will not trigger if it is too late. If false, some synth triggers may be late.
# @param _bool [true_or_false]
# @accepts_block true
# @introduced 2.10.0
# @example
#   use_timing_guarantees true
#   
#   sample :loop_amen  #=> if time is behind by any margin, this will not trigger
#
# @example
#   use_timing_guarantees false
#   
#   sample :loop_amen  #=> unless time is too far behind, this will trigger even when late.
#
def use_timing_guarantees(_bool = nil)
  #This is a stub, used for indexing
end

# Note transposition
# Transposes your music by shifting all notes played by the specified amount. To shift up by a semitone use a transpose of 1. To shift down use negative numbers. See `with_transpose` for setting the transpose value only for a specific `do`/`end` block. To transpose entire octaves see `use_octave`.
# @param _note_shift [number]
# @accepts_block false
# @introduced 2.0.0
# @example
#   play 50 # Plays note 50
#   use_transpose 1
#   play 50 # Plays note 51
#
# @example
#   # You may change the transposition multiple times:
#   play 62 # Plays note 62
#   use_transpose -12
#   play 62 # Plays note 50
#   use_transpose 3
#   play 62 # Plays note 65
#
def use_transpose(_note_shift = nil)
  #This is a stub, used for indexing
end

# Use alternative tuning systems
# In most music we make semitones by dividing the octave into 12 equal parts, which is known as equal temperament. However there are lots of other ways to tune the 12 notes. This method adjusts each midi note into the specified tuning system. Because the ratios between notes aren't always equal, be careful to pick a centre note that is in the key of the music you're making for the best sound. Currently available tunings are `:just`, `:pythagorean`, `:meantone` and the default of `:equal`
# @param _tuning [symbol]
# @param _fundamental_note [symbol_or_number]
# @accepts_block false
# @introduced 2.6.0
# @example
#   play :e4 # Plays note 64
#   use_tuning :just, :c
#   play :e4 # Plays note 63.8631
#   # transparently changes midi notes too
#   play 64 # Plays note 63.8631
#
# @example
#   # You may change the tuning multiple times:
#   play 64 # Plays note 64
#   use_tuning :just
#   play 64 # Plays note 63.8631
#   use_tuning :equal
#   play 64 # Plays note 64
#
def use_tuning(_tuning = nil, _fundamental_note = nil)
  #This is a stub, used for indexing
end

# Create a vector
# Create a new immutable vector from args. Out of range indexes return nil.
# @param _list [array]
# @accepts_block false
# @introduced 2.6.0
# @example
#   (vector 1, 2, 3)[0] #=> 1
#
# @example
#   (vector 1, 2, 3)[1] #=> 2
#
# @example
#   (vector 1, 2, 3)[2] #=> 3
#
# @example
#   (vector 1, 2, 3)[3] #=> nil
#
# @example
#   (vector 1, 2, 3)[1000] #=> nil
#
# @example
#   (vector 1, 2, 3)[-1] #=> nil
#
# @example
#   (vector 1, 2, 3)[-1000] #=> nil
#
def vector(_list = nil)
  #This is a stub, used for indexing
end

# Get current version information
# Return information representing the current version of Sonic Pi. This information may be further inspected with `version.major`, `version.minor`, `version.patch` and `version.dev`
# @accepts_block false
# @introduced 2.0.0
# @example
#   puts version # => Prints out the current version such as v2.0.1
#
# @example
#   puts version.major # => Prints out the major version number such as 2
#
# @example
#   puts version.minor # => Prints out the minor version number such as 0
#
# @example
#   puts version.patch # => Prints out the patch level for this version such as 0
#
def version
  #This is a stub, used for indexing
end

# Get virtual time
# Get the virtual time of the current thread.
# @accepts_block false
# @introduced 2.1.0
# @example
#   puts vt # prints 0
#      sleep 1
#      puts vt # prints 1
#
def vt
  #This is a stub, used for indexing
end

# Wait for duration
# Synonym for `sleep` - see `sleep`
# @param _beats [number]
# @accepts_block false
# @introduced 2.0.0
def wait(_beats = nil)
  #This is a stub, used for indexing
end

# Block-level enable and disable BPM scaling
# Turn synth argument bpm scaling on or off for the supplied block. Note, using `rt` for args will result in incorrect times when used within this block.
# @accepts_block true
# @introduced 2.0.0
# @example
#   use_bpm 120
#   play 50, release: 2 # release is actually 1 due to bpm scaling
#   with_arg_bpm_scaling false do
#     play 50, release: 2 # release is now 2
#   end
#
# @example
#   # Interaction with rt
#   use_bpm 120
#   play 50, release: rt(2)   # release is 2 seconds
#   sleep rt(2)               # sleeps for 2 seconds
#   with_arg_bpm_scaling false do
#     play 50, release: rt(2) # ** Warning: release is NOT 2 seconds! **
#     sleep rt(2)             # still sleeps for 2 seconds
#   end
#
def with_arg_bpm_scaling
  #This is a stub, used for indexing
end

# Block-level enable and disable arg checks
# Similar to `use_arg_checks` except only applies to code within supplied `do`/`end` block. Previous arg check value is restored after block.
# @param _true_or_false [boolean]
# @accepts_block true
# @introduced 2.0.0
# @example
#   # Turn on arg checking:
#   use_arg_checks true
#   
#   play 80, cutoff: 100 # Args are checked
#   
#   with_arg_checks false do
#     #Arg checking is now disabled
#     play 50, release: 3 # Args are not checked
#     sleep 1
#     play 72             # Arg is not checked
#   end
#   
#   # Arg checking is re-enabled
#   play 90 # Args are checked
#
def with_arg_checks(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Set the tempo for the code block
# Sets the tempo in bpm (beats per minute) for everything in the given block. Affects all containing calls to `sleep` and all temporal synth arguments which will be scaled to match the new bpm. See also `use_bpm`
# 
#   For dance music here's a rough guide for which BPM to aim for depending on your genre:
# 
#   * Dub: 60-90 bpm
#   * Hip-hop: 60-100 bpm
#   * Downtempo: 90-120 bpm
#   * House: 115-130 bpm
#   * Techno/trance: 120-140 bpm
#   * Dubstep: 135-145 bpm
#   * Drum and bass: 160-180 bpm
#   
# @param _bpm [number]
# @accepts_block true
# @introduced 2.0.0
# @example
#   # default tempo is 60 bpm
#     4.times do
#       sample :drum_bass_hard
#       sleep 1 # sleeps for 1 second
#     end
#   
#     sleep 5 # sleeps for 5 seconds
#   
#     # with_bpm sets a tempo for everything between do ... end (a block)
#     # Hear how it gets faster?
#     with_bpm 120 do  # set bpm to be twice as fast
#       4.times do
#         sample :drum_bass_hard
#         sleep 1 # now sleeps for 0.5 seconds
#       end
#     end
#   
#     sleep 5
#   
#     # bpm goes back to normal
#     4.times do
#       sample :drum_bass_hard
#       sleep 1 # sleeps for 1 second
#     end
#
def with_bpm(_bpm = nil)
  #This is a stub, used for indexing
end

# Set new tempo as a multiple of current tempo for block
# Sets the tempo in bpm (beats per minute) for everything in the given block as a multiplication of the current tempo. Affects all containing calls to `sleep` and all temporal synth arguments which will be scaled to match the new bpm. See also `with_bpm`
# @param _mul [number]
# @accepts_block true
# @introduced 2.3.0
# @example
#   use_bpm 60   # Set the BPM to 60
#     play 50
#     sleep 1      # Sleeps for 1 second
#     play 62
#     sleep 2      # Sleeps for 2 seconds
#     with_bpm_mul 0.5 do # BPM is now (60 * 0.5) == 30
#       play 50
#       sleep 1           # Sleeps for 2 seconds
#       play 62
#     end
#     sleep 1            # BPM is now back to 60, therefore sleep is 1 second
#
def with_bpm_mul(_mul = nil)
  #This is a stub, used for indexing
end

# Block-level cent tuning
# Similar to `use_cent_tuning` except only applies cent shift to code within supplied `do`/`end` block. Previous cent tuning value is restored after block. One semitone consists of 100 cents. To transpose entire semitones see `with_transpose`.
# @param _cent_shift [number]
# @accepts_block true
# @introduced 2.9.0
# @example
#   use_cent_tuning 1
#   play 50 # Plays note 50.01
#   
#   with_cent_tuning 2 do
#     play 50 # Plays note 50.02
#   end
#   
#   # Original cent tuning value is restored
#   play 50 # Plays note 50.01
#
def with_cent_tuning(_cent_shift = nil)
  #This is a stub, used for indexing
end

# Block-level enable and disable cue logging
# Similar to use_cue_logging except only applies to code within supplied `do`/`end` block. Previous cue log value is restored after block.
# @param _true_or_false [boolean]
# @accepts_block true
# @introduced 2.6.0
# @example
#   # Turn on debugging:
#     use_cue_logging true
#   
#     cue :foo # cue message is printed to log
#   
#     with_cue_logging false do
#       #Cue logging is now disabled
#       cue :bar # cue *is* sent but not displayed in log
#     end
#     sleep 1
#     # Debug is re-enabled
#     cue :quux # cue is displayed in log
#
def with_cue_logging(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Block-level enable and disable debug
# Similar to use_debug except only applies to code within supplied `do`/`end` block. Previous debug value is restored after block.
# @param _true_or_false [boolean]
# @accepts_block true
# @introduced 2.0.0
# @example
#   # Turn on debugging:
#   use_debug true
#   
#   play 80 # Debug message is sent
#   
#   with_debug false do
#     #Debug is now disabled
#     play 50 # Debug message is not sent
#     sleep 1
#     play 72 # Debug message is not sent
#   end
#   
#   # Debug is re-enabled
#   play 90 # Debug message is sent
#
def with_debug(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Use Studio FX
# This applies the named effect (FX) to everything within a given `do`/`end` block. Effects may take extra parameters to modify their behaviour. See FX help for parameter details.
# 
# For advanced control, it is also possible to modify the parameters of an effect within the body of the block. If you define the block with a single argument, the argument becomes a reference to the current effect and can be used to control its parameters (see examples).
# @param _fx_name [symbol]
# @param reps Number of times to repeat the block in an iteration.
# @param kill_delay Amount of time to wait after all synths triggered by the block have completed before stopping and freeing the effect synthesiser.
# @accepts_block true
# @introduced 2.0.0
# @example
#   # Basic usage
#   with_fx :distortion do # Use the distortion effect with default parameters
#     play 50 # => plays note 50 with distortion
#     sleep 1
#     sample :loop_amen # => plays the loop_amen sample with distortion too
#   end
#
# @example
#   # Specify effect parameters
#   with_fx :level, amp: 0.3 do # Use the level effect with the amp parameter set to 0.3
#     play 50
#     sleep 1
#     sample :loop_amen
#   end
#
# @example
#   # Controlling the effect parameters within the block
#   with_fx :reverb, mix: 0.1 do |fx|
#     # here we set the reverb level quite low to start with (0.1)
#     # and we can change it later by using the 'fx' reference we've set up
#   
#     play 60 # plays note 60 with a little bit of reverb
#     sleep 2
#   
#     control fx, mix: 0.5 # change the parameters of the effect to add more reverb
#     play 60 # again note 60 but with more reverb
#     sleep 2
#   
#     control fx, mix: 1 # change the parameters of the effect to add more reverb
#     play 60 # plays note 60 with loads of reverb
#     sleep 2
#   end
#
# @example
#   # Repeat the block 16 times internally
#   with_fx :reverb, reps: 16 do
#     play (scale :e3, :minor_pentatonic), release: 0.1
#     sleep 0.125
#   end
#   
#   # The above is a shorthand for this:
#   with_fx :reverb do
#     16.times do
#       play (scale :e3, :minor_pentatonic), release: 0.1
#       sleep 0.125
#     end
#   end
#
def with_fx(_fx_name = nil, reps: nil, kill_delay: nil)
  #This is a stub, used for indexing
end

# Block-level merge midi defaults
# Specify opt values to be used by any following call to the `midi_*` fns within the specified `do`/`end` block. Merges the specified values with any previous midi defaults, rather than replacing them. After the `do`/`end` block has completed, previous defaults (if any) are restored.
# @accepts_block true
# @introduced 3.0.0
# @example
#   midi_note_on :e1 # Sends MIDI :e1 note_on with default opts
#   
#   use_midi_defaults channel: 3, port: "foo"
#   
#   midi_note_on :e3 # Sends MIDI :e3 note_on to channel 3 on port "foo"
#   
#   with_merged_midi_defaults channel: 1 do
#   
#     midi_note_on :e2 # Sends MIDI :e2 note_on to channel 1 on port "foo".
#                      # This is because the call to use_merged_midi_defaults overrode the
#                      # channel but not the port which got merged in.
#   end
#   
#   midi_note_on :e2 # Sends MIDI :e2 note_on to channel 3 on port "foo".
#                    # This is because the previous defaults were restored after
#                    # the call to with_merged_midi_defaults.
#
def with_merged_midi_defaults
  #This is a stub, used for indexing
end

# Block-level use merged sample defaults
# Specify new default values to be used by all subsequent calls to `sample` within the `do`/`end` block.  Merges the specified values with any previous sample defaults, rather than replacing them. After the `do`/`end` block has completed, the previous sampled defaults (if any) are restored.
# @accepts_block false
# @introduced 2.9.0
# @example
#   sample :loop_amen # plays amen break with default arguments
#   
#   use_merged_sample_defaults amp: 0.5, cutoff: 70
#   
#   sample :loop_amen # plays amen break with an amp of 0.5, cutoff of 70 and defaults for rest of args
#   
#   with_merged_sample_defaults cutoff: 90 do
#     sample :loop_amen  # plays amen break with a cutoff of 90 and amp of 0.5
#   end
#   
#   sample :loop_amen  # plays amen break with a cutoff of 70 and amp is 0.5 again as the previous defaults are restored.
#
def with_merged_sample_defaults
  #This is a stub, used for indexing
end

# Block-level merge synth defaults
# Specify synth arg values to be used by any following call to play within the specified `do`/`end` block. Merges the specified values with any previous synth defaults, rather than replacing them. After the `do`/`end` block has completed, previous defaults (if any) are restored.
# @accepts_block true
# @introduced 2.0.0
# @example
#   with_merged_synth_defaults amp: 0.5, pan: 1 do
#     play 50 # => plays note 50 with amp 0.5 and pan 1
#   end
#
# @example
#   play 50 #=> plays note 50
#   with_merged_synth_defaults amp: 0.5 do
#     play 50 #=> plays note 50 with amp 0.5
#   
#     with_merged_synth_defaults pan: -1 do
#       with_merged_synth_defaults amp: 0.7 do
#         play 50 #=> plays note 50 with amp 0.7 and pan -1
#       end
#     end
#     play 50 #=> plays note 50 with amp 0.5
#   end
#
def with_merged_synth_defaults
  #This is a stub, used for indexing
end

# Block-level use new MIDI defaults
# Specify new default values to be used by all calls to `midi_*` fns within the `do`/`end` block. After the `do`/`end` block has completed the previous MIDI defaults (if any) are restored.
# @accepts_block true
# @introduced 3.0.0
# @example
#   midi_note_on :e1 # Sends MIDI :e1 note on with default opts
#   
#   with_midi_defaults channel: 3, port: "foo" do
#     midi_note_on :e3 # Sends MIDI :e3 note on to channel 3 on port "foo"
#   end
#   
#   use_midi_defaults channel: 1   # this will be overridden by the following
#   
#   with_midi_defaults channel: 5 do
#     midi_note_on :e2 # Sends MIDI :e2 note on to channel 5.
#                      # Note that the port is back to the default
#   end
#   
#     midi_note_on :e4 # Sends MIDI :e4 note on to channel 1
#                      # Note that the call to use_midi_defaults is now honoured.
#
def with_midi_defaults
  #This is a stub, used for indexing
end

# Block-level enable and disable MIDI logging
# Similar to use_midi_logging except only applies to code within supplied `do`/`end` block. Previous MIDI log value is restored after block.
# @param _true_or_false [boolean]
# @accepts_block true
# @introduced 3.0.0
# @example
#   # Turn on MIDI logging:
#     use_midi_logging true
#   
#     midi :e1 #  message is printed to log
#   
#     with_midi_logging false do
#       #MIDI logging is now disabled
#       midi :f2 # MIDI message *is* sent but not displayed in log
#     end
#     sleep 1
#     # Debug is re-enabled
#     midi :G3 # message is displayed in log
#
def with_midi_logging(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Block level octave transposition
# Transposes your music by shifting all notes played by the specified number of octaves within the specified block. To shift up by an octave use a transpose of 1. To shift down use negative numbers. For transposing the notes within the octave range see `with_transpose`.
# @param _octave_shift [number]
# @accepts_block true
# @introduced 2.9.0
# @example
#   play 50 # Plays note 50
#   sleep 1
#   with_octave 1 do
#    play 50 # Plays note 62
#   end
#   sleep 1
#   play 50 # Plays note 50
#
def with_octave(_octave_shift = nil)
  #This is a stub, used for indexing
end

# Block-level setting for the default hostname and port number of outgoing OSC messages.
# Sets the destination host and port that `osc` will send messages to for the given do/end block.
# @param _hostname [string]
# @param _port [number]
# @accepts_block true
# @introduced 3.0.0
# @example
#   use_osc "localhost", 7000  # Specify port 7010
#   osc "/foo/baz"             # Send an OSC message to port 7000
#   
#   with_osc "localhost", 7010 do # set hostname and port for the duration
#                                   # of this do/end block
#      osc "/foo/baz"             # Send an OSC message to port 7010
#   end
#   
#   osc "/foo/baz"             # Send an OSC message to port 7000
#                                # as old setting is restored outside
#                                # do/end block
#
def with_osc(_hostname = nil, _port = nil)
  #This is a stub, used for indexing
end

# Block-level enable and disable OSC logging
# Similar to use_osc_logging except only applies to code within supplied `do`/`end` block. Previous OSC log value is restored after block.
# @param _true_or_false [boolean]
# @accepts_block true
# @introduced 3.0.0
# @example
#   # Turn on OSC logging:
#     use_osc_logging true
#   
#     osc "/foo" #  message is printed to log
#   
#     with_osc_logging false do
#       #OSC logging is now disabled
#       osc "/foo" # OSC message *is* sent but not displayed in log
#     end
#     sleep 1
#     # Debug is re-enabled
#     osc "/foo" # message is displayed in log
#
def with_osc_logging(_true_or_false = nil)
  #This is a stub, used for indexing
end

# Specify random seed for code block
# Resets the random number generator to the specified seed for the specified code block. All generated random numbers and randomisation functions such as `shuffle` and `choose` within the code block will use this new generator. Once the code block has completed, the original generator is restored and the code block generator is discarded. Use this to change the sequence of random numbers in your piece in a way that can be reproduced. Especially useful if combined with iteration. See examples.
# @param _seed [number]
# @accepts_block true
# @introduced 2.0.0
# @example
#   use_random_seed 1 # reset random seed to 1
#     puts rand # => 0.417022004702574
#     puts rand  #=> 0.7203244934421581
#     use_random_seed 1 # reset it back to 1
#     puts rand # => 0.417022004702574
#     with_random_seed 1 do # reset seed back to 1 just for this block
#       puts rand # => 0.417022004702574
#       puts rand #=> 0.7203244934421581
#     end
#     puts rand # => 0.7203244934421581
#               # notice how the original generator is restored
#
# @example
#   ## Generating melodies
#     notes = (scale :eb3, :minor_pentatonic, num_octaves: 2)  # Create a set of notes to choose from.
#                                              # Scales work well for this
#   
#     with_fx :reverb do
#       live_loop :repeating_melody do         # Create a live loop
#   
#         with_random_seed 300 do              # Set the random seed to a known value every
#                                              # time around the loop. This seed is the key
#                                              # to our melody. Try changing the number to
#                                              # something else. Different numbers produce
#                                              # different melodies
#   
#           8.times do                         # Now iterate a number of times. The size of
#                                              # the iteration will be the length of the
#                                              # repeating melody.
#   
#             play notes.choose, release: 0.1  # 'Randomly' choose a note from our ring of
#                                              # notes. See how this isn't actually random
#                                              # but uses a reproducible method! These notes
#                                              # are therefore repeated over and over...
#             sleep 0.125
#           end
#         end
#   
#         play notes.choose, amp: 1.5, release: 0.5 # Note that this line is outside of
#                                                   # the with_random_seed block and therefore
#                                                   # the randomisation never gets reset and this
#                                                   # part of the melody never repeats.
#       end
#     end
#
def with_random_seed(_seed = nil)
  #This is a stub, used for indexing
end

# Sets sched ahead time to 0 within the block for the current thread
# 
# 
# Sets sched ahead time to 0 within the block for the current thread. Shorthand for `with_sched_ahead_time 0`.
# 
# See `with_sched_ahead_time` for a version of this function which allows you to set the schedule ahead time to any arbitrary value. Note, `with_real_time` will override any value set with `set_sched_ahead_time!` for the current thread.
# 
# @accepts_block false
# @introduced 3.0.0
# @example
#   use_real_time 1 # Code will now run approximately 1 second ahead of audio.
#
def with_real_time
  #This is a stub, used for indexing
end

# Block-scoped sample-duration-based bpm modification
# Block-scoped modification of bpm so that sleeping for 1 will sleep for the duration of the sample.
# @param _string_or_number [sample_name_or_duration]
# @param num_beats The number of beats within the sample. By default this is 1.
# @accepts_block true
# @introduced 2.1.0
# @example
#   live_loop :dnb do
#     with_sample_bpm :loop_amen do #Set bpm based on :loop_amen duration
#       sample :bass_dnb_f
#       sample :loop_amen
#       sleep 1                     #`sleep`ing for 1 sleeps for duration of :loop_amen
#     end
#   end
#
# @example
#   live_loop :dnb do
#     with_sample_bpm :loop_amen, num_beats: 4 do # Set bpm based on :loop_amen duration
#                                                 # but also specify that the sample duration
#                                                 # is actually 4 beats long.
#       sample :bass_dnb_f
#       sample :loop_amen
#       sleep 4                     #`sleep`ing for 4 sleeps for duration of :loop_amen
#                                   # as we specified that the sample consisted of
#                                   # 4 beats
#     end
#   end
#
def with_sample_bpm(_string_or_number = nil, num_beats: nil)
  #This is a stub, used for indexing
end

# Block-level use new sample defaults
# Specify new default values to be used by all subsequent calls to `sample` within the `do`/`end` block. After the `do`/`end` block has completed, the previous sampled defaults (if any) are restored. For the contents of the block, will remove and override any previous defaults.
# @accepts_block false
# @introduced 2.5.0
# @example
#   sample :loop_amen # plays amen break with default arguments
#   
#   use_sample_defaults amp: 0.5, cutoff: 70
#   
#   sample :loop_amen # plays amen break with an amp of 0.5, cutoff of 70 and defaults for rest of args
#   
#   with_sample_defaults cutoff: 90 do
#     sample :loop_amen  # plays amen break with a cutoff of 90 and defaults for rest of args - note that amp is no longer 0.5
#   end
#   
#   sample :loop_amen  # plays amen break with a cutoff of 70 and amp is 0.5 again as the previous defaults are restored.
#
def with_sample_defaults
  #This is a stub, used for indexing
end

# Block-level set sched ahead time for the current thread
# Specify how many seconds ahead of time the synths should be triggered for the block. See `use_sched_ahead_time` for further information.
# 
# See `set_sched_ahead_time!` for a global version of this function. Note, `with_sched_ahead_time` will override any value set with `set_sched_ahead_time!` for the given block within the current thread.
# 
# See `with_real_time` for a simple way of setting the schedule ahead time to 0.
# @param _time [number]
# @accepts_block false
# @introduced 3.0.0
# @example
#   with_sched_ahead_time 1 do
#     play 70  # Sound will happen with a latency of 1
#   end
#   
#   play 70  # Sound will happen with the default latency (0.5s)
#
def with_sched_ahead_time(_time = nil)
  #This is a stub, used for indexing
end

# Add swing to successive calls to do/end block
# Runs block within a `time_warp` except for once every `pulse` consecutive runs (defaulting to 4). When used for rhythmical purposes this results in one in every `pulse` calls of the block being 'on beat' and the rest shifted forward or backwards in time by `shift` beats.
# @param _shift [beats]
# @param _pulse [number]
# @param _tick [symbol]
# @param shift How much time to delay/forward the block. Greater values produce more emphasised swing. Defaults to 0.1 beats.
# @param pulse How often to apply the swing. Defaults to 4.
# @param tick A key for the tick with which to count pulses. Override this if you have more than one `with_swing` block in your `live_loop` or thread to stop them interfering with each other.
# @param offset Count offset - before modding the count with the pulse size - integer offset to add to the result of calling `tick` with the specified tick key (via the `tick:` opt)
# @accepts_block false
# @introduced 3.0.0
# @example
#   live_loop :foo do
#     with_swing 0.1 do
#       sample :elec_beep      # plays the :elec_beep sample late except for every 4th time
#     end
#     sleep 0.25
#   end
#
# @example
#   live_loop :foo do
#     with_swing -0.1 do
#       sample :elec_beep      # plays the :elec_beep sample slightly early
#     end                      # except for every 4th time
#     sleep 0.25
#   end
#
# @example
#   live_loop :foo do
#     with_swing -0.1, pulse: 8 do
#       sample :elec_beep      # plays the :elec_beep sample slightly early
#     end                      # except for every 8th time
#     sleep 0.25
#   end
#
# @example
#   # Use unique tick names if you plan on using with_swing
#   # more than once in any given live_loop or thread.
#   live_loop :foo do
#     with_swing 0.14, tick: :a do
#       sample :elec_beep      # plays the :elec_beep sample slightly late
#     end                      # except for every 4th time
#   
#     with_swing -0.1, tick: :b do
#       sample :elec_beep, rate: 2  # plays the :elec_beep sample at double rate
#     end                           #  slightly early except for every 4th time
#     sleep 0.25
#   end
#
# @example
#   live_loop :foo do
#     with_swing 0.1 do
#       cue :tick              # send out cue messages with swing timing
#     end
#     sleep 0.25
#   end
#   
#   live_loop :bar do
#     sync :tick
#     sample :elec_beep       # sync on the swing cue messages to bring the swing into
#                             # another live loop (sync will match the timing and clock of
#                             # the sending live loop)
#   end
#
def with_swing(_shift = nil, _pulse = nil, _tick = nil, shift: nil, pulse: nil, tick: nil, offset: nil)
  #This is a stub, used for indexing
end

# Block-level synth switching
# Switch the current synth to `synth_name` but only for the duration of the `do`/`end` block. After the `do`/`end` block has completed, the previous synth is restored.
# @param _synth_name [symbol]
# @accepts_block true
# @introduced 2.0.0
# @example
#   play 50 # Plays with default synth
#   sleep 2
#   use_synth :supersaw
#   play 50 # Plays with supersaw synth
#   sleep 2
#   with_synth :saw_beep do
#     play 50 # Plays with saw_beep synth
#   end
#   sleep 2
#   # Previous synth is restored
#   play 50 # Plays with supersaw synth
#
def with_synth(_synth_name = nil)
  #This is a stub, used for indexing
end

# Block-level use new synth defaults
# Specify new default values to be used by all calls to `play` within the `do`/`end` block. After the `do`/`end` block has completed the previous synth defaults (if any) are restored.
# @accepts_block true
# @introduced 2.0.0
# @example
#   play 50 # plays note 50 with default arguments
#   
#   use_synth_defaults amp: 0.5, pan: -1
#   
#   play 50 # plays note 50 with an amp of 0.5, pan of -1 and defaults for rest of args
#   
#   with_synth_defaults amp: 0.6, cutoff: 80 do
#     play 50 # plays note 50 with an amp of 0.6, cutoff of 80 and defaults for rest of args (including pan)
#   end
#   
#   play 60 # plays note 60 with an amp of 0.5, pan of -1 and defaults for rest of args
#
def with_synth_defaults
  #This is a stub, used for indexing
end

# Block-scoped inhibition of synth triggers if too late
# For the given block, if set to true, synths will not trigger if it is too late. If false, some synth triggers may be late. After the block has completed, the previous value is restored. 
# @param _bool [true_or_false]
# @accepts_block true
# @introduced 2.10.0
# @example
#   with_timing_guarantees true
#     sample :loop_amen  #=> if time is behind by any margin, this will not trigger
#   end
#
# @example
#   with_timing_guarantees false
#     sample :loop_amen  #=> unless time is too far behind, this will trigger even when late.
#   end
#
def with_timing_guarantees(_bool = nil)
  #This is a stub, used for indexing
end

# Block-level note transposition
# Similar to use_transpose except only applies to code within supplied `do`/`end` block. Previous transpose value is restored after block. To transpose entire octaves see `with_octave`.
# @param _note_shift [number]
# @accepts_block true
# @introduced 2.0.0
# @example
#   use_transpose 3
#   play 62 # Plays note 65
#   
#   with_transpose 12 do
#     play 50 # Plays note 62
#     sleep 1
#     play 72 # Plays note 84
#   end
#   
#   # Original transpose value is restored
#   play 80 # Plays note 83
#
def with_transpose(_note_shift = nil)
  #This is a stub, used for indexing
end

# Block-level tuning modification
# Similar to use_tuning except only applies to code within supplied `do`/`end` block. Previous tuning value is restored after block.
# @param _tuning [symbol]
# @param _fundamental_note [symbol_or_number]
# @accepts_block true
# @introduced 2.6.0
# @example
#   use_tuning :equal, :c
#   play :e4 # Plays note 64
#   with_tuning :just, :c do
#     play :e4 # Plays note 63.8631
#     sleep 1
#     play :c4 # Plays note 60
#   end
#   # Original tuning value is restored
#   play :e4 # Plays note 64
#
def with_tuning(_tuning = nil, _fundamental_note = nil)
  #This is a stub, used for indexing
end

