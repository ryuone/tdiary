#!/usr/bin/env ruby
$KCODE= 'e'
#
# posttdiary: update tDiary via e-mail. $Revision: 1.3 $
#
# Copyright (C) 2002, All right reserved by TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#
# 2005.1.17: Rev1.3
#  debugged by K.Sakurai (http://ks.nwr.jp)
#

def usage
	text = <<-TEXT
		#{File::basename __FILE__}: update tDiary via e-mail.
		usage: ruby #{File::basename __FILE__} [options] <url> [user] [passwd]
		arguments:
		  url:    update.rb's URL of your diary.
		  user:   user ID of your diary updating.
		  passwd: password of your diary updating.
		          If To: field of the mail likes "user-passwd@example.com",
		          you can omit user and passwd arguments.
		options:
		  --image-path,   -i: directory of image saving into.
		  --image-url,    -u: URL of image.
		          You have to specify both options when using images.
		  --image-format, -f: format of image tag specified image serial
		          number as '$0' and image url as '$1'.
		          default format is ' <img class="photo" src="$1" alt="">'.
		  --use-subject,  -s: use mail subject to subtitle.
		          and insert image between subtitle and body.
  TEXT
  text.gsub( /\t/, '' )
end

def image_list( date, path )
	image_path = []
	Dir.foreach( path ) do |file|
		if file =~ /(\d{8,})_(\d+)\.(.*)/ then
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
	image_format = ' <img class="photo" src="$1" alt="">'
	use_subject = false
	parser.set_options(
		['--image-path', '-i', GetoptLong::REQUIRED_ARGUMENT],
		['--image-url', '-u', GetoptLong::REQUIRED_ARGUMENT],
		['--image-format', '-f', GetoptLong::REQUIRED_ARGUMENT],
		['--use-subject', '-s', GetoptLong::NO_ARGUMENT]
	)
	begin
		parser.each do |opt, arg|
			case opt
			when '--image-path'
				image_dir = arg
			when '--image-url'
				image_url = arg
			when '--image-format'
				image_format = arg
			when '--use-subject'
				use_subject = true
			end
		end
	rescue
		raise usage
	end
	raise usage if (image_dir and not image_url) or (not image_dir and image_url)
	if image_dir then
		image_dir += '/' unless %r[/$] =~ image_dir
	end
	if image_url then
		image_url += '/' unless %r[/$] =~ image_url
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

	require 'base64'
	require 'nkf'
	image_name = nil

	mail = NKF::nkf( '-m0 -Xed', ARGF.read )
	raise "#{File::basename __FILE__}: no mail text." if not mail or mail.length == 0
	
	head, body = mail.split( /\r*\n\r*\n/, 2 )

	if head =~ /Content-Type:\s*Multipart\/Mixed.*boundary=\"(.*?)\"/im then
		if not image_dir or not image_url then
			raise "no --image-path and --image-url options"
		end
	
		bound = "--" + $1
		body_sub = body.split( Regexp.compile( Regexp.escape( bound ) ) )
		body_sub.each do |b|
			sub_head, sub_body = b.split( /\r*\n\r*\n/, 2 )

			next unless sub_head =~ /Content-Type/

			if sub_head =~ %r[^Content-Type:\s*text/plain]i then
				@body = sub_body
			elsif sub_head =~ %r[^Content-Type:\s*(image/|application/octet-stream).*name=".*(\..*?)"]im
				image_ext = $2
				now = Time::now
				list = image_list( now.strftime( "%Y%m%d" ), image_dir )
				image_name = now.strftime( "%Y%m%d" ) + "_" + list.length.to_s + image_ext
				File::umask( 022 )
				open( image_dir + image_name, "wb" ) do |s|
					begin
						s.print Base64::decode64( sub_body.strip )
					rescue NameError
						s.print decode64( sub_body.strip )
					end
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
		@body = body
	else
		raise "can not read this mail"
	end

	if @image_name then
		img_src = ""
		@image_name.each do |i|
			serial = i.sub( /^\d+_(\d+)\..*$/, '\1' )
			img_src += image_format.gsub( /\$0/, serial ).gsub( /\$1/, image_url + i )
		end
		if use_subject then
			@body = "#{img_src}\n#{@body.sub( /\n+\z/, '' )}"
		else
			@body = "#{@body.sub( /\n+\z/, '' )}\n#{img_src}"
		end
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
	
	subject = ''
	nextline = false
	headlines = head.split( /[\r\n]+/ )
	for n in 0 .. headlines.size-1
		if nextline then
			if /^[ \t]/ =~ headlines[n] then
				s = headlines[n].sub( /^[ \t]/, '' )
				subject += NKF::nkf( '-eXd', s )
			else
				break
			end
		end
		if /^Subject:(.*)$/ =~ headlines[n] then
			s = $1.sub( /^\s+/, '' )
			subject = NKF::nkf( '-eXd', s )
			nextline = true
		end
	end
	if use_subject then
		title = ''
		@body = "#{subject}\n#{@body}"
	else
		title = subject
	end

	require 'cgi'
	require 'nkf'
	data = "title=#{CGI::escape title}"
	data << "&body=#{CGI::escape @body}"
	data << "&append=true"

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
