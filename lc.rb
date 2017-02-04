leds=['i','j','k','l','n','o','p']

f=File.open('/dev/ttyACM0','w')
while true do
	r=STDIN.gets
	STDERR.puts r
	if r =~ /\d*,\d*,\d*/
		col=$&
		g=leds.delete_at(rand(3))
		leds.push(g)
		d=50
		if $' =~ /^,(\d+)/
			d=$1
		end
		f.puts "0,#{col}#{g}#{d},0,0,0#{g}"
	end
end
