#!/usr/bin/env ruby

require 'osc-ruby'
require 'listen'

target = ARGV[0].to_s
unless File.exists?(target)
  fail "Usage: ./autoreload.rb FILENAME"
end

client   = OSC::Client.new('localhost', 4557)
listener = Listen.to(
  File.dirname(target),
  only: /#{Regexp.quote(File.basename(target))}/
) do
  puts "#{Time.now} reloading #{target}"
  client.send(OSC::Message.new('/stop-all-jobs'))
  sleep 0.5
  client.send(OSC::Message.new('/run-code', '0', File.read(target)))
end
listener.start
sleep