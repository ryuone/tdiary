#!/usr/bin/env ruby
# yasqueeze.rb $Revision: 1.8 $
#
# yasqueeze: tDiary-1.3.x$B0J9_$GI8=`$G$D$$$F$/$k(Bsqueeze.rb$B$N3HD%HG(B
#				 tDiary$B$N%G!<%?%Y!<%9$+$iF|JL$K(BHTML$B%U%!%$%k$r@8@.$7!"(B
#				 $BG$0U$N%G%#%l%/%H%j$KJ]B8$7$^$9!#(B
#				 $B8!:w%(%s%8%s(B($B<g$K(BNamazu)$B$G$N;HMQ$rA[Dj$7$F$$$^$9!#(B
#
#	$B%Q%i%a%?(B: $B$J$7(B
#
#	tdiary.conf$B$K$F!"0J2<$N@_Dj$r$7$F$/$@$5$$(B($BA4$F>JN,2DG=$G$9(B)$B!#(B
#
#	----- ($B$3$3$+$i(B) -----
#	# $B=PNO@h%G%#%l%/%H%j(B($B>JN,;~(B: (tdiary.conf$B$N(B@data_path)/cache/html)
#	@options['yasqueeze.output_path'] = '/home/hoge/tdiary/html/'
# 
#	#$BHsI=<($NF|5-$bBP>]$H$9$k$+$I$&$+(B
#	#$BBP>]$H$9$k>l9g$O(Btrue$B!#(Bfalse$B$K$7$?>l9g$OHsI=<($NF|5-$O=PNO$;$:!"$+$D!"(B
#	#$B$9$G$K=PNO:Q$_$N%U%!%$%k$,B8:_$7$?>l9g$O:o=|$7$^$9!#(B
#	#$B8!:w%(%s%8%s$G;HMQ$9$k$3$H$rA[Dj$7$?>l9g!"$3$3$r(Btrue$B$K$7$F$7$^$&$H(B
#	#$B1#$7$F$$$k$D$b$j$NF|5-$b8!:wBP>]$K$J$C$F$7$^$&$N$GCm0U$,I,MW$G$9!#(B
#  #($B>JN,;~!'(B false)
#	@options['yasqueeze.all_data'] = false
#
#	#tDiary Text$B=PNO8_49%b!<%I(B
#	#squeeze.rb$B!"(BtDiary$BI8=`$HF1$8=PNO@h$N%G%#%l%/%H%j9=@.$K$9$k>l9g$O(Btrue
#  #($B>JN,;~!'(B false)
#	@options['yasqueeze.compat_path'] = false
#	----- ($B$3$3$^$G(B) -----
#
# $B%W%i%0%$%s$H$7$F$G$O$J$/!"(BCGI$B$d%3%^%s%I%Y!<%9$H$7$F!"0lJU$KA4$F$NF|5-$r(B
# HTML$B2=$9$k$3$H$b$G$-$^$9!#(B
# $B>\$7$/$O(B http://home2.highway.ne.jp/mutoh/tools/ruby/ja/yasqueeze.html
# $B$r;2>H$7$F$/$@$5$$!#(B
#
# Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
#
# The original version of this file was distributed with squeeze 
# version 1.0.4 by TADA Tadashi <sho@spc.gr.jp> with GPL2.
#
=begin ChangeLog
2002-04-14 MUTOH Masao	<mutoh@highway.ne.jp>
	* @options$B$r;XDj$7$J$/$F$b%G%U%)%k%H$NF0:n$r$9$k$h$&$K$7$?(B
		- output_path = (@data_path)/cache/html
		- all_data = false
		- compat_path = false
	* version 1.3.0

2002-04-01 MUTOH Masao	<mutoh@highway.ne.jp>
	* $B%I%-%e%a%s%H:o=|(B
	* $BK\%U%!%$%k$N%X%C%@ItJ,$N%I%-%e%a%s%H$r=<<B$5$;$?(B

2002-03-31 MUTOH Masao	<mutoh@highway.ne.jp>
	* TAB $B"*(B $B%9%Z!<%9(B
	* $B%I%-%e%a%s%H%A%'%C%/%$%s(B

2002-03-29 MUTOH Masao	<mutoh@highway.ne.jp>
	* $B=PNO%U%!%$%k$rF|IU$N>:=g$G%=!<%H$9$k$h$&$K$7$?(B
	* squeeze.rb$B$HF1MM$N%3%^%s%I%*%W%7%g%s$r%5%]!<%H$7$?(B
	 $B!J$?$@$7(B --delete$B%*%W%7%g%s$O$J$/Be$o$j$K(B--all$B%*%W%7%g%s$rMQ0U!K(B
	* $B%3%^%s%I%i%$%s%*%W%7%g%s$rDI2C$7$?$3$H$GITMW$K$J$C$?(B--nohtml$B%*%W%7%g%s(B
	  $B$r$J$/$7$?(B
	* $B%I%-%e%a%s%H:F8+D>$7(B
	* tdiary.conf$B$N(B@options$BBP1~(B
	* add_update_proc do $B!A!!(Bend $BBP1~(B
	* version 1.2.0

2002-03-21 MUTOH Masao	<mutoh@highway.ne.jp>
	* $BHsI=<($NF|5-$r=PNOBP>]$K4^$a$k$+$I$&$+$r@_Dj$G$-$k$h$&$K$7$?(B
	* $B%U%!%$%k$NJ]B8%G%#%l%/%H%j$N9=@.$r!"(BtDiary$BI8=`$N$b$N$H(Bversion 1.0.0
	  $B$N$b$N$r@_Dj$G$-$k$h$&$K$7$?(B
	* $B%I%-%e%a%s%H$r%=!<%9$+$iDI$$=P$7$?(B
	* version 1.1.0

2002-03-19 MUTOH Masao <mutoh@highway.ne.jp>
	* version 1.0.0
=end


$KCODE= 'e'

mode = ""
if $0 == __FILE__
	mode = ENV["REQUEST_METHOD"]? "CGI" : "CMD"
else
	mode = "PLUGIN"
end

if mode == "CMD" || mode == "CGI"
	output_path = "./html/"
	tdiary_path = "."
	tdiary_conf = "."
	all_data = false
	compat = false
	$stdout.sync = true

	if mode == "CMD"
		def usage
			puts "yasqueeze $Revision: 1.8 $"
			puts " Yet Another making html files from tDiary's database."
			puts " usage: ruby yasqueeze.rb [-p <tDiary path>] [-c <tdiary.conf path>] [-a] [-s] <dest path>"
			exit
		end

		require 'getoptlong'
		parser = GetoptLong::new
		parser.set_options(['--path', '-p', GetoptLong::REQUIRED_ARGUMENT],
											 ['--conf', '-c', GetoptLong::REQUIRED_ARGUMENT],
											 ['--all', '-a', GetoptLong::NO_ARGUMENT],
											 ['--squeeze', '-s', GetoptLong::NO_ARGUMENT])
		begin
			parser.each do |opt, arg|
				case opt
				when '--path'
					tdiary_path = arg
				when '--conf'
					tdiary_conf = arg
				when '--all'
					all_data = true
				when '--squeeze'
					compat = true
				end
			end
		rescue
			usage
		end
		output_path = ARGV.shift
		usage unless output_path
		output_path = File::expand_path(output_path)
		output_path += '/' if /\/$/ !~ output_path
	else
		@options = Hash.new
		File::readlines("tdiary.conf").each {|item| 
			if item =~ /@options/
				eval(item)
			end
		}
		output_path = @options['yasqueeze.output_path']
		all_data = @options['yasqueeze.all_data']
		compat = @options['yasqueeze.compat_path']
	end

	tdiary_conf = tdiary_path unless tdiary_conf
	Dir::chdir( tdiary_conf )

	begin
		ARGV << '' # dummy argument against cgi.rb offline mode.
		require "#{tdiary_path}/tdiary"
	rescue LoadError
		$stderr.print "yasqueeze.rb: cannot load tdiary.rb. <#{tdiary_path}/tdiary>\n"
		exit
	end
end

#
# Dairy Squeeze
#
class YATDiarySqueeze < TDiary
	def initialize(diary, dest, all_data, compat)
		super(nil, 'day.rhtml')
		@header = ''
		@footer = ''
		@show_comment = true
		@show_referer = false
		@diary = diary
		@dest = dest
		@all_data = all_data
		@compat = compat
	end

	def execute
		if @compat
			dir = @dest
			name = @diary.date.strftime('%Y%m%d')
		else
			dir = @dest + "/" + @diary.date.strftime('%Y')
			name = @diary.date.strftime('%m%d')
			Dir.mkdir(dir, 0755) unless File.directory?(dir)
		end
		filename = dir + "/" + name
		if @diary.visible? or @all_data
			if not FileTest::exist?(filename) or 
					File::mtime(filename) < @diary.last_modified
				File::open(filename, 'w'){|f| f.write(eval_rhtml)}
			end
		else
			if FileTest.exist?(filename) and ! @all_data
				name = "remove #{name}"
				File::delete(filename)
			else
				name = ""
			end
		end
		name
	end
	
	protected
	def title
		t = @html_title
		t += "(#{@diary.date.strftime('%Y-%m-%d')})" if @diary
		t
	end

	def cookie_name; ''; end
	def cookie_mail; ''; end
end

#
# Main
#
class YATDiarySqueezeMain < TDiary
	def initialize(dest, all_data, compat)
		super(nil, 'day.rhtml')
		make_years
		@years.keys.sort.each do |year|
			@years[year.to_s].sort.each do |month|
				transaction(Time::local(year.to_i, month.to_i)) do |diaries|
					diaries.sort.each do |day, diary|
						print YATDiarySqueeze.new(diary, dest, all_data, compat).execute + " "
					end
					false
				end
			end
		end
	end
end

if mode == "CGI" || mode == "CMD"
	if mode == "CGI"
		print %Q[Content-type:text/html\n\n
			<html>
			<head>
				<title>Yet Another Squeeze for tDiary</title>
				<link href="./theme/default.css" type="text/css" rel="stylesheet"/>
			</head>
			<body><div style="text-align:center">
			<h1>Yet Another Squeeze for tDiary</h1>
			<p>$Revision: 1.8 $</p>
			<p>Copyright (C) 2002 MUTOH Masao&lt;mutoh@highway.ne.jp&gt;</p></div>
			<br><br>Start!</p><hr>
		]
	end

	begin
		YATDiarySqueezeMain.new(output_path, all_data, compat)
	rescue
		print $!, "\n"
		$@.each do |v|
			print v, "\n"
		end
	end

	if mode == "CGI"
		print "<hr><p>End!</p></body></html>\n"
	else
		print "\n\n"
	end
else
	add_update_proc do
		diary = @diaries[@date.strftime('%Y%m%d')]
		dir = @options['yasqueeze.output_path']
		dir = @cache_path + "/html" unless dir
		Dir.mkdir(dir, 0755) unless File.directory?(dir)
		YATDiarySqueeze.new(diary, dir, @options['yasqueeze.all_data'],
											@options['yasqueeze.compat_path']).execute
	end
end
