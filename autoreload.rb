#!/usr/bin/env ruby

# @see https://github.com/samaaron/sonic-pi/blob/master/app/server/ruby/bin/sonic-pi-server.rb#L274
require 'osc-ruby'
require 'listen'
require 'fileutils'

path = File.expand_path(ARGV[0].to_s, __dir__)
name = File.basename(path)
unless File.exists?(path)
  fail "Usage: ./autoreload.rb FILENAME"
end

gui_id      = '0'
buffer_id   = 'workspace_nine'
project_dir = (ENV['SONIC_PI_HOME'] || Dir.home) + '/.sonic-pi/store/default'
FileUtils.ln_s(path, "#{project_dir}/#{buffer_id}.spi", force: true)

client    = OSC::Client.new('localhost', 4557)
on_change = Proc.new do
  puts "#{Time.now} reloading #{path}"
  client.send(OSC::Message.new('/stop-all-jobs'))
  client.send(OSC::Message.new('/load-buffer', gui_id, buffer_id))
  sleep 0.5
  client.send(OSC::Message.new('/run-code', gui_id, File.read(path)))
end

Listen.to(
  File.dirname(path),
  only: /#{Regexp.quote(name)}/,
  &on_change
).start

on_change.call
sleep