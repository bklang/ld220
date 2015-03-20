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

  def type(messages, delay = 0.1)
    clear
    sleep delay
    Array(messages).each do |message|
      message.split('').each do |char|
        write char
        sleep delay
      end
      # Print a cr/lf only if the message hasn't wrapped
      write "\r\n" if message.length < 20
      display_line :bottom, " " * 20
    end
  end

  def write(data)
    data = data.encode Encoding::US_ASCII
    puts "Sending: #{data.inspect}" if @debug
    @display.write data
  end
end
