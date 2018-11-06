#!/usr/bin/ruby

require_relative 'msgclt'

$leds=['i','j','k','l','n','o','p']

$f=File.open('/dev/ttyACM0','w')

sleep 1

$leds.each do |g|
  $f.puts "64,16,0,8#{g}"
  sleep 0.1
end

$f.puts ',127D'

a='ws://soctestgit.verigy.net/msg/ws'
a='ws://socrepo.advantest.com:3042/msg/ws'
a='wss://beta.apk.li/msg/ws'

def do_led(col,d)
  g=$leds.delete_at(rand(3))
  $leds.push(g)
  $f.puts "0,#{col}#{g}#{d},0,0,0#{g}"
end

msgclt_run a do |a,d,t|
  if a == ['blnk']
    puts d.inspect
    if d =~ /\d+,\d+,\d+/
      col=$&
      d=50
      if $' =~ /^,(\d+)/
	d=$1
      end
      do_led(col,d)
    end
  end
end
