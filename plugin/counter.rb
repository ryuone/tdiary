# counter.rb $Revision: 1.5 $
#
# ������ɽ���ץ饰���� version 1.2.1
#
# ˬ��Կ�������ơסֺ����סֺ����פ�ʬ����ɽ�����ޤ���
#
# �Ȥ���ꡧ
# �إå����⤷���ϥեå�
# 
# ������ˡ��
# counter: ���Ƥ�ˬ��Կ���ɽ������
#	�ѥ�᥿��
#	 figure: ɽ�������̤�������5�塣
#	 filetype: �ե��������(��ĥ��)��jpg, gif, png����
#						 ̤������ϡ�""(�����ϻȤ�ʤ���CSS�ǳ������Ѥ���)��
#
# counter_today: ������ˬ��Կ���ɽ������
# counter_yesterday: ������ˬ��Կ���ɽ������
#	�ѥ�᥿��
#	 figure: ɽ�������̤�������5�塣
#	 filetype: �ե��������(��ĥ��)��jpg, gif, png����
#              ̤������ϡ�""(�����ϻȤ�ʤ���CSS�ǳ������Ѥ���)��
#
# kiriban?: �����֤λ���true���֤�(����)��
# kiriban_today?: �����֤λ���true���֤�(����)��
#  �ѥ�᥿���ʤ���
#
# �����㡧
# counter
# counter 3
# coutner 3, "jpg"
# counter_today 4, "jpg"
# counter_yesterday
#
# ���ץ����ˤĤ��ơ�
# ˬ��ֳ֤λ���
#   @options["counter.timer"] = 6
# ����ͤλ���
#   @options["counter.init_num"] = 5
# ���μ���
#   @options["counter.log"] = true
# ������ȥ��å�����
#   @options['counter.deny_user_agents'] = ["w3m", "Mozilla/4"]
#   @options['counter.deny_remote_addrs'] = ["127.0", "10.0.?.1", "192.168.1.2"]
# ������
#   @options["counter.kiriban"] = [1000, 3000, 5000, 10000, 15000, 20000]
#   @options["counter.kiriban_today"] = [100, 200, 300, 400, 500, 600]
#
# CSS�ˤĤ���:
#	 counter: �о�ʸ��������(����)
#	 counter-today: �о�ʸ��������(����)
#	 counter-yesterday: �о�ʸ��������(����)
#	 counter-0, ... : 1��ʬ(������)
#	 counter-num-0, ... 9: ����
#	 counter-kiriban: �����֤ο�������ʬ(����)
#	 counter-kiriban-today: �����֤ο�������ʬ(����)
#
# ����¾��
#   http://home2.highway.ne.jp/mutoh/tools/ruby/ja/counter.html
# �򻲾Ȥ��Ƥ���������
#
# ����ɽ����
# Copyright (c) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
# 
=begin ChangeLog
2002-05-05 MUTOH Masao  <mutoh@highway.ne.jp>
	* @debug = true ��� :->
	* �������ѹ�
	* version 1.2.1

2002-05-04 MUTOH Masao  <mutoh@highway.ne.jp>
	* tlink�ץ饰���󤫤�Υ��������򥫥���Ȥ��Ƥ��ޤ��Զ��ν���
	* @options["counter.deny_user_agents"]�ɲ�
	* @options["counter.deny_remote_addrs"]�ɲ�
	* @options["counter.init_num"]�ɲá������ֵ�ǽ�Ȥδط��ǡ�counter
	* �᥽�åɤΰ�����init_num��obsolete�Ȥ��ޤ���
	* @options["counter.kiriban"], @options["counter.kiriban_today"]�ɲ�
	* �����ֵ�ǽ�ɲ�(kiriban?,kiriban_today?�᥽�å��ɲ�)
	* version 1.2.0

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
	attr_reader :today, :yesterday, :all, :newestday, :timer, :ignore_cookie
	attr_writer :ignore_cookie #means ALWAYS ignore a cookie.

	def initialize
		@today, @yesterday, @all = 0, 0, 0
		@newestday = nil
		@ignore_cookie = false
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
	@version = "1.2.0"

	def run(cache_path, cgi, options)
		timer = options["counter.timer"] if options
		timer = 12 unless timer	# 12 hour
		@init_num = options["counter.init_num"] if options
		@init_num = 0 unless @init_num
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

			allow = (cgi.user_agent !~ /tlink/ and
						allow?(cgi.user_agent, options, "user_agents") and
						allow?(cgi.remote_addr, options, "remote_addrs"))
			no_cookie = (! cgi.cookies or ! cgi.cookies.keys.include?("tdiary_counter"))

			if allow 
				changed = false
				if no_cookie || @cnt.ignore_cookie
					@cnt.up(Date.today, dir, (options and options["counter.log"]))
					cookie = CGI::Cookie.new({"name" => "tdiary_counter", 
														"value" => @version, 
														 "expires" => Time.now + timer * 3600})
					changed = true
				end
				if options["counter.kiriban"]
					@kiriban = options["counter.kiriban"].include?(@cnt.all + @init_num) 
				end
 				if ! @kiriban and options["counter.kiriban_today"]
					@kiriban_today = options["counter.kiriban_today"].include?(@cnt.today)
				end

				if @cnt.ignore_cookie
					@cnt.ignore_cookie = false
					changed = true
				end

				#when it is kiriban time, ignore the cookie next access time. 
				if @kiriban or @kiriban_today
					@cnt.ignore_cookie = true
					changed = true
				end

				db["countdata"] = @cnt if changed
			end
		end
		cookie
	end

	def allow?(cgi_value, options, option_name)
		allow = true
		if options and options["counter.deny_" + option_name] 
			options["counter.deny_" + option_name].each do |deny|
				if cgi_value =~ /#{deny}/
					allow = false
					break
				end
			end
		end
		allow 
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
	def all; @cnt.all + @init_num; end
	def today; @cnt.today; end
	def yesterday; @cnt.yesterday; end
	def kiriban?; @kiriban; end
	def kiriban_today?; @kiriban_today; end

	module_function :allow?, :all, :today, :yesterday, :format, :run, :kiriban?, :kiriban_today?
end

#init_num is deprecated.
#please replace it to @options["counter.init_num"]
def counter(figure = 5, filetype = "", init_num = 0, &proc) 
	TDiaryCounter.format("", theme_url, TDiaryCounter.all, figure, filetype, init_num, &proc)
end

def counter_today(figure = 5, filetype = "", &proc)
	TDiaryCounter.format("-today", theme_url, TDiaryCounter.today, figure, filetype, 0, &proc)
end

def counter_yesterday(figure = 5, filetype = "", &proc)
	TDiaryCounter.format("-yesterday", theme_url, TDiaryCounter.yesterday, figure, filetype, 0, &proc)
end

def kiriban?
	TDiaryCounter.kiriban?
end

def kiriban_today?
	TDiaryCounter.kiriban_today?
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
