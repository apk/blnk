#!/usr/bin/ruby

require 'rubygems'
require 'websocket-client-simple'
require 'json'

$leds=['i','j','k','l','n','o','p']

$f=File.open('/dev/ttyACM0','w')

def proc_msg(x)
  begin
    j=JSON.parse(x)
    if j['a'] == ['blnk']
      r=j['d']
      puts r.inspect
      if r =~ /\d*,\d*,\d*/
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
    # puts j.inspect
  rescue => e
    puts "E: #{e.inspect}"
  end
end

a='ws://soctestgit.verigy.net/msg/ws'
a='ws://socrepo.advantest.com:3042/msg/ws'
a='wss://beta.apk.li/msg/ws'

ws = WebSocket::Client::Simple.connect a

ws.on :message do |msg|
  # puts msg.data
  proc_msg(msg.data)
end

ws.on :open do
  puts "Opened"
  # ws.send 'hello!!!'
end

ws.on :close do |e|
  puts "Closed"
  p e
  exit 1
end

ws.on :error do |e|
  puts "Error!"
  p e
  exit 1
end

loop do
  sleep 150
  ws.send Time.now.to_s
end
