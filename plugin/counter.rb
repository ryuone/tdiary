# counter.rb $Revision: 1.2 $
#
# ������ɽ���ץ饰����
#
# counter: ���Ƥ�ˬ��Կ���ɽ������
#	�ѥ�᥿��
#	 figure: ɽ�������̤�������5�塣
#	 filetype: �ե��������(��ĥ��)��jpg, gif, png����
#						 ̤������ϡ�""(�����ϻȤ�ʤ���CSS�ǳ������Ѥ���)��
#	 init_num: ����͡�̤�������0��
#
# counter_today: ������ˬ��Կ���ɽ������
# counter_yesterday: ������ˬ��Կ���ɽ������
#	�ѥ�᥿��
#	 figure: ɽ�������̤�������5�塣
#	 filetype: �ե��������(��ĥ��)��jpg, gif, png����
#						 ̤������ϡ�""(�����ϻȤ�ʤ���CSS�ǳ������Ѥ���)��
#
# �㡧
# counter
# counter 3
# coutner 3, "jpg"
# counter 5, "", 100
# counter_today 4, "jpg"
# counter_yesterday
#
# CSS���饹:�ʳƥơ��ޤ�CSS�ե����������Ƥ�����������ά�ġ�
#	 counter: �о�ʸ��������(����)
#	 counter-today: �о�ʸ��������(����)
#	 counter-yesterday: �о�ʸ��������(����)
#	 counter-0, ... : 1��ʬ(������)
#	 counter-num-0, ... 9: ����
#
# ����¾�ξ���� 
#   http://home2.highway.ne.jp/mutoh/tools/ruby/ja/counter.html
# �򻲾Ȥ��Ƥ���������
#
# Copyright (c) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
# 
=begin ChangeLog
2002-04-27 MUTOH Masao  <mutoh@highway.ne.jp>
	* add_header_proc��Ȥ�ʤ��褦�ˤ���
	* @options["counter.timer"]��ͭ���ˤʤ�ʤ��Զ��ν���
	* @options["counter.log"]�ɲá�true����ꤹ���counter.dat
	   ��Ʊ���ǥ��쥯�ȥ��counter.log�Ȥ����ե�����������
	   1�����Υ�����������Ͽ����褦�ˤ���
	* cookie���ͤȤ��ƥС�������ֹ�������褦�ˤ���
	* version 1.1.0

2002-04-25 MUTOH Masao  <mutoh@highway.ne.jp>
	* HEAD�ǥ������������ä����˺Ƥӥ�����Ȥ����褦��
		�ʤäƤ��ޤäƤ����Զ��ν���(by NT<nt@24i.net>)
	* version 1.0.4

2002-04-24 MUTOH Masao  <mutoh@highway.ne.jp>
	* �ĥå��ߤ����줿�Ȥ��˥��顼��ȯ�������Զ��ν���
	* version 1.0.3

2002-04-23 MUTOH Masao	<mutoh@highway.ne.jp>
	* �ǡ����ե���������塢���å�����ͭ���������ü������
		����������������@today��0�ˤʤ��Զ��ν���
	* ���������줿�Ȥ��˿�����ɽ������ʤ��Զ��ν���
	* HEAD�ǥ������������ä����ϥ�����Ȥ��ʤ��褦�ˤ���
		(reported by NT<nt@24i.net>, suggested a solution 
			by TADA Tadashi <sho@spc.gr.jp>)
	* version 1.0.2

2002-04-21 MUTOH Masao	<mutoh@highway.ne.jp>
	* CSS��_��ȤäƤ���Ȥ����-��ľ����(reported by NT<nt@24i.net>)
	* TDiaryCountData#up��@all��+1����ʤ��Զ��ν���
	* version 1.0.1

2002-04-14 MUTOH Masao	<mutoh@highway.ne.jp>
	* version 1.0.0
=end

if ["latest", "month", "day", "comment"].include?(@mode) and
		@cgi.request_method =~ /POST|GET/

require 'date'

eval(<<TOPLEVEL_CLASS, TOPLEVEL_BINDING)
class TDiaryCountData
	attr_reader :today, :yesterday, :all, :newestday, :timer

	def initialize
		@today, @yesterday, @all = 0, 0, 0
		@newestday = nil
	end

	def up(now, cache_path, log)
		if now == @newestday
			@today += 1
		else
			log(@newestday, @today, cache_path) if log
			@yesterday = ((now - 1) == @newestday) ? @today : 0
			@today = 1
			@newestday = now
		end
		@all += 1
	end

	def log(day, value, path)
		return unless day
		open(path + "/counter.log", "a") do |io|
			io.print day, " : ", value, "\n"
		end
	end
end
TOPLEVEL_CLASS

module TDiaryCounter
	@version = "1.1.0"

	def run(cache_path, cgi, options)
		timer = options["counter.timer"] if options
		timer = 12 unless timer	# 12 hour
		dir = cache_path + "/counter"
		path = dir + "/counter.dat"
		cookie = nil
	
		Dir.mkdir(dir, 0700) unless FileTest.exist?(dir)
	
		db = PStore.new(path)
		db.transaction do
			begin
				@cnt = db["countdata"]
			rescue PStore::Error
				@cnt = TDiaryCountData.new
				cgi.cookies = nil
			end
			if ! cgi.cookies or ! cgi.cookies.keys.include?("tdiary_counter")
				@cnt.up(Date.today, dir, (options and options["counter.log"]))
				cookie = CGI::Cookie.new({"name" => "tdiary_counter", 
													"value" => @version, 
													 "expires" => Time.now + timer * 3600})
				db["countdata"] = @cnt
			end
		end
		cookie
	end

	def format(classtype, theme_url, cnt, figure = 5, filetype = "", init_num = 0, &proc)
		str = "%0#{figure}d" % (cnt + init_num)
		result = %Q[<span class="counter#{classtype}">]
		depth = 0
		str.scan(/./).each do |num|
			if block_given?
				result << %Q[<img src="#{theme_url}/#{yield(num)}" alt="#{num}" />]
			elsif filetype == ""
				result << %Q[<span class="counter-#{depth}"><span class="counter-num-#{num}">#{num}</span></span>]
			else 
				result << %Q[<img src="#{theme_url}/#{num}.#{filetype}" alt="#{num}" />]
			end
			depth += 1
		end
		result << "</span>"
	end

	def called?; @called; end
	def called; @called = true; end
	def all; @cnt.all; end
	def today; @cnt.today; end
	def yesterday; @cnt.yesterday; end

	module_function :all, :today, :yesterday, :format, :run
end

def counter(figure = 5, filetype = "", init_num = 0, &proc)
	TDiaryCounter.format("", theme_url, TDiaryCounter.all, figure, filetype, init_num, &proc)
end

def counter_today(figure = 5, filetype = "", &proc)
	TDiaryCounter.format("-today", theme_url, TDiaryCounter.today, figure, filetype, 0, &proc)
end

def counter_yesterday(figure = 5, filetype = "", &proc)
	TDiaryCounter.format("-yesterday", theme_url, TDiaryCounter.yesterday, figure, filetype, 0, &proc)
end

tdiary_counter_cookie = TDiaryCounter.run(@cache_path, @cgi, @options)
if tdiary_counter_cookie
	if defined?(add_cookie)
		add_cookie(tdiary_counter_cookie)
	else
		@cookie = tdiary_counter_cookie if tdiary_counter_cookie
	end
end

end
