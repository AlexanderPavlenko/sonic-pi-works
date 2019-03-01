#!/usr/bin/env ruby

src  = '/Users/Shared/sonic-pi'
lang = "#{src}/app/server/ruby/lib/sonicpi/lang"

# %w[kramdown activesupport fast_osc* rubame websocket-ruby* hamster* ruby-aubio*].each do |lib|
#   $LOAD_PATH << Dir["#{src}/app/server/ruby/vendor/#{lib}/lib"][0]
# end

module Docs
  RAW = []

  def doc(**args)
    RAW << args
  end
end

module Sandbox

  module_function

  def require_relative(*)
    true
  end

  def require(*)
    true
  end

  module SonicPi
    Version = Struct.new(:x, :y, :z)
    module Util
      ;
    end
    module Lang
      module Core
        extend Docs
      end
      module Midi
        extend Docs
      end
      module Minecraft
        extend Docs
      end
      module Pattern
        extend Docs
      end
      module Sound
        extend Docs
      end
      module Support
        module DocSystem
          ;
        end
      end
    end
    module Core
      ;
    end
  end
end

Dir["#{lang}/*.rb"].sort.each do |file|
  Sandbox.class_eval File.read(file)
end

require 'yaml'
dump = File.open('dump.yml', File::WRONLY | File::CREAT)
dump.write YAML.dump(Docs::RAW)

Docs::RAW.sort_by! { |item| item[:name] }
args_prefix = '_'
Docs::RAW.each do |item|
  args   = item[:args]&.map { |arg| "#{args_prefix}#{arg[0]}" }&.join(', ')
  opts   = item[:opts]&.keys&.map { |k| "#{k}: nil" }&.join(', ')
  method = "#{item[:name]}(#{[args, opts].compact.reject(&:empty?).join(', ')})"
  puts "# #{item[:summary]}"
  item[:doc].each_line do |line|
    puts "# #{line}"
  end
  item[:args]&.each { |arg| puts "# @param #{args_prefix}#{arg[0]} [#{arg[1]}]" }
  item[:opts]&.each { |opt, desc| puts "# @option opts #{opt.inspect} #{desc}" }
  puts "# @accepts_block #{item[:accepts_block]}"
  puts "# @introduced #{item[:introduced]&.values&.join('.')}"
  item[:examples]&.each do |example|
    puts "# @example"
    example.strip.each_line do |line|
      puts "#   #{line.strip}"
    end
    puts "#"
  end
  puts <<-EOF
def #{method}
  #This is a stub, used for indexing
end

  EOF
end