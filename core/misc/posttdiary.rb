#!/usr/bin/env ruby
$KCODE= 'e'
#
# posttdiary: update tDiary via e-mail. $Revision: 1.8 $
#
# Copyright (C) 2002, All right reserved by TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.

=begin ChangeLog
2003-09-10 TADA Tadashi <sho@spc.gr.jp>
	* unset date to request for tDiary.

2002-09-29 TADA Tadashi <sho@spc.gr.jp>
	* fix bug when boundary has special charactor of Regexp.

2002-04-16 TADA Tadashi <sho@spc.gr.jp>
	* bmp support for feelH". if found Ruby::Magick use it, else use convert.

2002-04-07 TADA Tadashi <sho@spc.gr.jp>
	* fix mojibake: -mQ -> -m0.

2002-04-05 TADA Tadashi <sho@spc.gr.jp>
	* version 0.9.3
	* set permission of image to readable everybody.
	* --image-path and --image-url options.

2002-02-22 Daisuke Kato <dai@kato-agri.com>
	* version 0.9.2
	* support Multipart Mail

2002-01-12 TADA Tadashi <sho@spc.gr.jp>
	* version 0.9.1
	* support null subject.

2002-01-12 TADA Tadashi <sho@spc.gr.jp>
	* version 0.9.0
=end


def usage
	text = <<-TEXT
		#{File::basename __FILE__}: update tDiary via e-mail.
		usage: ruby posttdiary.rb [options] <url> [user] [passwd]
		arguments:
		  url:    update.rb's URL of your diary.
		  user:   user ID of your diary updating.
		  passwd: password of your diary updating.
		          If To: field of the mail likes "user-passwd@example.com",
		          you can omit user and passwd arguments.
		options:
		  --image-path, -i: directory of image saving into.
		  --image-url,  -u: URL of image.
		          You have to specify both options when using images.
  TEXT
  text.gsub( /\t/, '' )
end

def image_list( date, path )
	image_path = []
	Dir.foreach( path ) do |file|
		if file =~ /(\d{8,})_(\d)\.(.*)/ then
			if $1 == date then
				image_path[$2.to_i] = file
			end
		end
	end
	image_path
end

def bmp_to_png( bmp )
	png = bmp.sub( /\.bmp$/, '.png' )
	begin
		require 'magick'
		img = Magick::Image::new( bmp )
		img.write( 'magick' => 'png', 'filename' => png )
	rescue LoadError
		system( "convert #{bmp} #{png}" )
	end
	if FileTest::exist?( png )
		File::delete( bmp )
		png
	else
		bmp
	end
end

begin

	raise usage if ARGV.length < 1

	require 'getoptlong'
	parser = GetoptLong::new
	image_dir = nil
	image_url = nil
	parser.set_options(
		['--image-path', '-i', GetoptLong::REQUIRED_ARGUMENT],
		['--image-url', '-u', GetoptLong::REQUIRED_ARGUMENT]
	)
	begin
		parser.each do |opt, arg|
			case opt
			when '--image-path'
				image_dir = arg
			when '--image-url'
				image_url = arg
			end
		end
	rescue
		raise usage
	end
	raise usage if (image_dir and not image_url) or (not image_dir and image_url)
	if image_dir then
		image_dir << '/' unless %r[/$] =~ image_dir
	end
	if image_url then
		image_url << '/' unless %r[/$] =~ image_url
	end

	url = ARGV.shift
	if %r|http://([^:/]*):?(\d*)(/.*)| =~ url then
		host = $1
		port = $2.to_i
		cgi = $3
		raise 'bad url.' if not host or not cgi
		port = 80 if port == 0
	else
		raise 'bad url.'
	end
	
	user = ARGV.shift
	pass = ARGV.shift

	mail = ARGF.read
	raise "no mail text." if not mail or mail.length == 0
	
	head, body = mail.split( /\n\n/, 2 )

	require 'base64'
	require 'nkf'
	image_name = nil

	if head =~ /Content-Type:\s*Multipart\/Mixed.*boundary=\"(.*?)\"/im then
		if not image_dir or not image_url then
			raise "no --image-path and --image-url options"
		end
	
		bound = "--" + $1
		body_sub = body.split( Regexp.compile( Regexp.escape( bound ) ) )
		body_sub.each do |b|
			sub_head, sub_body = b.split( /\n\n/, 2 )

			next unless sub_head =~ /Content-Type/

			if sub_head =~ %r[^Content-Type:\s*text/plain]i then
				@body = NKF::nkf( '-m0 -Xed', sub_body )
			elsif sub_head =~ %r[^Content-Type:\s*(image/|application/octet-stream).*name=".*(\..*?)"]im
				image_ext = $2
				now = Time::now
				list = image_list( now.strftime( "%Y%m%d" ), image_dir )
				image_name = now.strftime( "%Y%m%d" ) + "_" + list.length.to_s + image_ext
				File::umask( 022 )
				open( image_dir + image_name, "wb" ) do |s|
					s.print decode64( sub_body.strip )
				end
				if /\.bmp$/i =~ image_name then
					bmp_to_png( image_dir + image_name )
					image_name.sub!( /\.bmp$/, '.png' )
				end
				@image_name = [] unless @image_name
				@image_name << image_name
			end
		end
	elsif head =~ /^Content-Type:\s*text\/plain/i 
		@body = NKF::nkf( '-m0 -Xed', body )
	else
		raise "can not read this mail"
	end

	if @image_name then
		img_src = ""
		@image_name.each do |i|
			img_src << %Q[ <img class="photo" src="#{image_url+i}" alt="">]
		end
		@body = "#{@body.sub( /\n+\z/, '' )}\n#{img_src}"
	end

	addr = nil
	if /^To:(.*)$/ =~ head then
		to = $1.strip
		if /.*?\s*<(.*)>/ =~ to then
			addr = $1
		elsif /(.*?)\s*\(.*\)/ =~ to
			addr = $1
		else
			addr = to
		end
	end
	
	if /([^-]+)-(.*)@/ =~ addr then
		user = $1 unless user
		pass = $2 unless pass
	end
	
	raise "no user." unless user
	raise "no passwd." unless pass
	
	title = ''
	if /^Subject:(.*)$/ =~ head then
		title = $1.strip
	end

	require 'cgi'
	require 'nkf'
	data = "title=#{CGI::escape NKF::nkf( '-eXd', title )}"
	data << "&body=#{CGI::escape @body}"
	data << "&append=true"
#	now = Time::now
#	data << "&year=#{now.year}"
#	data << "&month=#{now.month}"
#	data << "&day=#{now.day}"

	require 'net/http'
	Net::HTTP.start( host, port ) do |http|
		auth = ["#{user}:#{pass}"].pack( 'm' ).strip
		res, = http.post( cgi, data, 'Authorization' => "Basic #{auth}" )
	end

rescue
	$stderr.puts $!
	File::delete( image_dir + image_name ) if image_dir and image_name and FileTest::exist?( image_dir + image_name )
	exit 1
end

