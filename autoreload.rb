#!/usr/bin/env ruby

# @see https://github.com/samaaron/sonic-pi/blob/master/app/server/ruby/bin/sonic-pi-server.rb#L274
require 'osc-ruby'
require 'listen'
require 'fileutils'
require 'logger'

src  = File.expand_path(ARGV[0].to_s, __dir__)
name = File.basename(src)
unless File.exists?(src)
  fail "Usage: ./autoreload.rb FILENAME"
end

# @example in order to control remote host, expose the port
#   while :; do socat -T1 UDP-LISTEN:4557,bind=192.168.2.4 UDP:localhost:4557; done
logger = Logger.new($stdout)
server = URI.parse(ENV['SONIC_PI_URL'] || 'udp://localhost:4557')
logger.debug "Connecting to #{server.inspect}"
client = OSC::Client.new(server.host, server.port)

gui_id    = '0'
buffer_id = 'workspace_nine'
workspace = (ENV['SONIC_PI_HOME'] || Dir.home) + '/.sonic-pi/store/default'
dest      = "#{workspace}/#{buffer_id}.spi"

on_change = Proc.new do
  logger.info "Reloading #{src}"
  client.send(OSC::Message.new('/stop-all-jobs'))
  sleep 0.5
  if server.host == 'localhost'
    logger.debug "Reloading buffer #{gui_id}:#{buffer_id} from #{dest}"
    # FileUtils.ln_s src, dest, force: true
    FileUtils.rm_f dest
    FileUtils.cp src, dest
    client.send(OSC::Message.new('/load-buffer', gui_id, buffer_id))
  end
  client.send(OSC::Message.new('/run-code', gui_id, File.read(src)))
end

Listen.to(
  File.dirname(src),
  only: /#{Regexp.quote(name)}/,
  &on_change
).start

on_change.call
begin
  sleep
rescue Interrupt
  client.send(OSC::Message.new('/stop-all-jobs'))
  exit
end