#!/usr/bin/ruby
$KCODE= 'e'
#
# yasqueeze version 1.1.0
#
# Yet Another make HTML text files from tDiary's database.
#
# Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
#
# The original version of this file was distributed with squeeze 
# version 1.0.3 by TADA Tadashi <sho@spc.gr.jp> with GPL2.

###########################################################
# CGI�����뤤�ϡ�tDiary��Plugin�ȻȤ����Ͻ�����Υǥ��쥯�ȥ����ꤷ�Ƥ���������
###########################################################
#SQUEEZE_OUTPUT_PATH = "/home/hoge/text/"  #������ǥ��쥯�ȥ�
SQUEEZE_TDIARY_PATH = "."     #tDiary�Υѥ� 
SQUEEZE_TDIARY_CONF = "."     #tdiary.conf��¸�ߤ���ѥ�
SQUEEZE_ALL_DATA    = false   #��ɽ�����������оݤȤ���
SQUEEZE_COMPAT_PATH = false   #squeeze.rb��Ʊ���ǥ��쥯�ȥ깽���ˤ������true

##########################################################
# �ʲ����Խ����ʤ��Ǥ���������
###########################################################
if $0 == __FILE__
  nohtml = false
  nohtml = true if ARGV[0] == "--nohtml"

  $stdout.sync = true

  Dir.chdir(SQUEEZE_TDIARY_CONF)

  begin
	ARGV << '' # dummy argument against cgi.rb offline mode.
	require "#{SQUEEZE_TDIARY_PATH}/tdiary"
  rescue LoadError
	$stderr.puts 'yasqueeze.rb: cannot load tdiary.rb. SQUEEZE_TDIARY_PATH is wrong.'
	exit
  end
end

#
# Dairy Squeeze
#
class YATDiarySqueeze < TDiary
  def initialize(diary, dest)
    super(nil, 'day.rhtml')
    @header = ''
    @footer = ''
	@show_comment = true
	@show_referer = false
	@diary = diary
	@dest = dest
  end

  def execute
	return "" unless @diary.visible? || SQUEEZE_ALL_DATA
	if SQUEEZE_COMPAT_PATH
	  dir = @dest
	  name = @diary.date.strftime('%Y%m%d')
	else
	  dir = @dest + "/" + @diary.date.strftime('%Y')
	  name = @diary.date.strftime('%m%d')
	  Dir.mkdir(dir, 0755) unless File.directory?(dir)
	end
	filename = dir + "/" + name
	if not FileTest::exist?(filename) or 
		File::mtime(filename) < @diary.last_modified
	  File::open(filename, 'w'){|f| f.write(eval_rhtml)}
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
  def initialize(dest)
	super(nil, 'day.rhtml')
	make_years
	@years.keys.sort.each do |year|
	  @years[year.to_s].sort.each do |month|
		transaction(Time::local(year.to_i, month.to_i)) do |diaries|
		  diaries.each do |day, diary|
			$stdout.print YATDiarySqueeze.new(diary, dest).execute + " "
		  end
		  false
		end
	  end
	end
  end
end

if $0 == __FILE__
  unless nohtml
	print "Content-type:text/html\n\n"
    print "<html><head><title>Yet Another Squeeze for tDiary</title></head>\n"
    print "<body><p>Yet Another Squeeze for tDiary<BR><BR>Start!</p><hr>\n"
  end
  begin
	YATDiarySqueezeMain.new(SQUEEZE_OUTPUT_PATH)
  rescue
	print $!, "\n"
	$@.each do |v|
	  print v, "\n"
	end
  end

  unless nohtml
	print "<hr><p>End!</p></body></html>\n"
  end
else
  add_update_proc(Proc.new{
	diary = @diaries[@date.strftime('%Y%m%d')]
	YATDiarySqueeze.new(diary, SQUEEZE_OUTPUT_PATH).execute if diary.visible?
  })
end
