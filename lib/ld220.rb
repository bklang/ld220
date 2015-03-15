# encoding: utf-8
require 'rubyserial'

class LD220
  attr_accessor :debug

  def initialize(device, mode, options = {})
    extend mode
    options[:speed] ||= 9600
    @debug = options[:debug]
    @display = Serial.new device, options[:speed]
  end

  def type(string, delay = 0.1)
    clear
    sleep delay
    string.split('').each do |char|
      write char
      sleep delay
    end
  end

  def write(data)
    data = data.encode Encoding::US_ASCII
    puts "Sending: #{data.inspect}" if @debug
    @display.write data
  end
end
