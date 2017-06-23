#!/usr/bin/ruby

require_relative 'msgclt'

$leds=['i','j','k','l','n','o','p']

$f=File.open('/dev/ttyACM0','w')

a='ws://soctestgit.verigy.net/msg/ws'
a='ws://socrepo.advantest.com:3042/msg/ws'
a='wss://beta.apk.li/msg/ws'

msgclt_run a do |a,d,t|
  if a == ['blnk']
    puts d.inspect
    if d =~ /\d+,\d+,\d+/
      col=$&
      g=$leds.delete_at(rand(3))
      $leds.push(g)
      d=50
      if $' =~ /^,(\d+)/
	d=$1
      end
      $f.puts "0,#{col}#{g}#{d},0,0,0#{g}"
    end
  end
end
