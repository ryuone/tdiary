#!/usr/bin/env ruby
# yasqueeze.rb $Revision: 1.14 $
# -pv-
#
# ̾�Ρ�
# Yet Another squeeze.rb(squeeze.rb�γ�ĥ��)
# 
# ���ס�
# tDiary�Υǡ����١����������̤�HTML�ե��������������
# Ǥ�դΥǥ��쥯�ȥ����¸���ޤ���
# �������󥸥�(���Namazu)�Ǥλ��Ѥ����ꤷ�Ƥ��ޤ���
#
# �Ȥ���:
# ɬ�פ˱����ơ�tdiary.conf�˰ʲ���������ɲä��Ƥ�������(���ƾ�ά��ǽ�Ǥ�)��
#
#	----- (��������) -----
#	# ������ǥ��쥯�ȥ�(��ά��: (tdiary.conf��@data_path)/cache/html)
#	@options['yasqueeze.output_path'] = '/home/hoge/tdiary/html/'
# 
#	#��ɽ�����������оݤȤ��뤫�ɤ���
#	#�оݤȤ������true��false�ˤ���������ɽ���������Ͻ��Ϥ��������ġ�
#	#���Ǥ˽��ϺѤߤΥե����뤬¸�ߤ������Ϻ�����ޤ���
#	#�������󥸥�ǻ��Ѥ��뤳�Ȥ����ꤷ����硢������true�ˤ��Ƥ��ޤ���
#	#�����Ƥ���Ĥ��������⸡���оݤˤʤäƤ��ޤ��Τ���դ�ɬ�פǤ���
#  #(��ά���� false)
#	@options['yasqueeze.all_data'] = false
#
#	#tDiary Text���ϸߴ��⡼��
#	#squeeze.rb��tDiaryɸ���Ʊ��������Υǥ��쥯�ȥ깽���ˤ������true
#  #(��ά���� false)
#	@options['yasqueeze.compat_path'] = false
#	----- (�����ޤ�) -----
#
# ����¾��
# �ץ饰����Ȥ��ƤǤϤʤ���CGI�䥳�ޥ�ɥ١����Ȥ��ơ����դ����Ƥ�������
# HTML�����뤳�Ȥ�Ǥ��ޤ���
# �ܤ����� http://home2.highway.ne.jp/mutoh/tools/ruby/ja/yasqueeze.html
# �򻲾Ȥ��Ƥ���������
#
# ����ˤĤ��ơ�
# Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
#
# The original version of this file was distributed with squeeze 
# version 1.0.4 by TADA Tadashi <sho@spc.gr.jp> with GPL2.
#
=begin ChangeLog
2002-08-22 TADA Tadashi <sho@spc.gr.jp>
	* add tdiary path to $:.

2002-08-16 TADA Tadashi <sho@spc.gr.jp>
	* ignore parser cache.
	* hide comment form.

2002-08-13 TADA Tadashi <sho@spc.gr.jp>
	* for tDiary 1.5. thanks NISHIO Mizuho <gha@intrastore.cdc.com>.

2002-05-19 MUTOH Masao	<mutoh@highway.ne.jp>
	* �ɥ�����ȥ��åץǡ���

2002-04-29 MUTOH Masao	<mutoh@highway.ne.jp>
	* yasqueeze.rb���Ȥ�ʸ�������ɤ�ISO-2022-JP���ä��Τ�EUC-JP��ľ����
	* version 1.3.1

2002-04-14 MUTOH Masao	<mutoh@highway.ne.jp>
	* @options����ꤷ�ʤ��Ƥ�ǥե���Ȥ�ư��򤹤�褦�ˤ���
		- output_path = (@data_path)/cache/html
		- all_data = false
		- compat_path = false
	* version 1.3.0

2002-04-01 MUTOH Masao	<mutoh@highway.ne.jp>
	* �ɥ�����Ⱥ��
	* �ܥե�����Υإå���ʬ�Υɥ�����Ȥ򽼼¤�����

2002-03-31 MUTOH Masao	<mutoh@highway.ne.jp>
	* TAB �� ���ڡ���
	* �ɥ�����ȥ����å�����

2002-03-29 MUTOH Masao	<mutoh@highway.ne.jp>
	* ���ϥե���������դξ���ǥ����Ȥ���褦�ˤ���
	* squeeze.rb��Ʊ�ͤΥ��ޥ�ɥ��ץ����򥵥ݡ��Ȥ���
	 �ʤ����� --delete���ץ����Ϥʤ������--all���ץ������Ѱա�
	* ���ޥ�ɥ饤�󥪥ץ������ɲä������Ȥ����פˤʤä�--nohtml���ץ����
	  ��ʤ�����
	* �ɥ�����ȺƸ�ľ��
	* tdiary.conf��@options�б�
	* add_update_proc do ����end �б�
	* version 1.2.0

2002-03-21 MUTOH Masao	<mutoh@highway.ne.jp>
	* ��ɽ��������������оݤ˴ޤ�뤫�ɤ���������Ǥ���褦�ˤ���
	* �ե��������¸�ǥ��쥯�ȥ�ι�����tDiaryɸ��Τ�Τ�version 1.0.0
	  �Τ�Τ�����Ǥ���褦�ˤ���
	* �ɥ�����Ȥ򥽡��������ɤ��Ф���
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
			puts "yasqueeze $Revision: 1.14 $"
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
		$:.unshift tdiary_path
		require "#{tdiary_path}/tdiary"
	rescue LoadError
		$stderr.print "yasqueeze.rb: cannot load tdiary.rb. <#{tdiary_path}/tdiary>\n"
		exit
	end
end

#
# Dairy Squeeze
#
module TDiary
	class YATDiarySqueeze < TDiaryBase
		def initialize(diary, dest, all_data, compat, conf)
			@ignore_parser_cache = true
	
			super(nil, 'day.rhtml', conf)
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
end

#
# Main
#
module TDiary
	class YATDiarySqueezeMain < TDiaryBase
		def initialize(dest, all_data, compat, conf)
			@ignore_parser_cache = true
			eval <<-DIARY_CLASS, TOPLEVEL_BINDING
				module TDiary
					module DiaryBase
						alias :__eval_rhtml :eval_rhtml
						def eval_rhtml(opt, path)
							opt['hide_comment_form'] = true
							__eval_rhtml(opt, path)
						end
					end
				end
			DIARY_CLASS
	
			super(nil, 'day.rhtml', conf)
			calendar
			@years.keys.sort.each do |year|
				@years[year.to_s].sort.each do |month|
					@io.transaction(Time::local(year.to_i, month.to_i)) do |diaries|
						diaries.sort.each do |day, diary|
							print YATDiarySqueeze.new(diary, dest, all_data, compat, conf).execute + " "
						end
						false
					end
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
			<p>$Revision: 1.14 $</p>
			<p>Copyright (C) 2002 MUTOH Masao&lt;mutoh@highway.ne.jp&gt;</p></div>
			<br><br>Start!</p><hr>
		]
	end

	begin
		conf = TDiary::Config::new
		conf.header = ''
		conf.footer = ''
		conf.show_comment = true
		conf.show_referer = false
		TDiary::YATDiarySqueezeMain.new(output_path, all_data, compat, conf)
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
		conf = @conf.clone
		conf.header = ''
		conf.footer = ''
		conf.show_comment = true
		conf.show_referer = false

		diary = @diaries[@date.strftime('%Y%m%d')]
		dir = @options['yasqueeze.output_path']
		dir = @cache_path + "/html" unless dir
		Dir.mkdir(dir, 0755) unless File.directory?(dir)
		TDiary::YATDiarySqueeze.new(diary, dir, @options['yasqueeze.all_data'],
											@options['yasqueeze.compat_path'], conf).execute
	end
end

