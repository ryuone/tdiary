# a.rb
# -pv-
#
# ̾�Ρ�
# ���󥫡���ư�����ץ饰����
#
# ���ס�
# �����˴�Ť����󥫡���ư�������ޤ���
# �ޤ��ϡ�����ե�����˴�Ť����󥫡���ư�������ޤ�(tDiary-1.4.1�ʹ�)��
#
# �Ȥ���ꡧ
# ��ʸ���إå����⤷���ϥեå�
#
# �Ȥ�����
# 1. a(key, option_or_name = "", name = nil)
#	  key - ���󥫡��Υ���̾��(���������פ��ʤ����Ϥ��켫�Ȥ�URL�ˤʤ�)
#	  option_or_name - ���Ū���ɲä���Ǥ�դ�ʸ����ʾ�ά��ǽ��
#									 ���������פ��ʤ�����ɽ��ʸ����ˤʤ�
#    name - ɽ��ʸ���󡣼���ե�����Ȥϰ㤦̾�����դ������Ȥ��˻Ȥ��ʾ�ά��ǽ��
#
# a "home"
# a "home", "20020329.html", "������"
# a "http://www.hoge.com/diary/", "Hoge Diary"
#
# 2. a("name|key:option")
#    �������1.��1�Ĥ�ʸ����ˤޤȤ᤿�����Ǥ������Ͽ�������ΤǴ�����
#    �Ȥ��䤹���Ǥ���key��option�δ֤�':'��name��key�δ֤�'|'�Ƕ��ڤ�
#    �ޤ���name��option�Ͼ�ά��ǽ�Ǥ���
#    �ޤ���key�ˤϥ�����ɤ�URL������ޤ���YYYYMM...�Ȥ���������������
#    my�Ȥۤ�Ʊ��ư��򤷤ޤ�(title��ɽ���Ǥ��ޤ���)��
#    (���) 1.����ˡ��name�ΰ��֤��ۤʤ�ΤǺ��𤷤ʤ��褦�ˤ��Ƥ���������
#
# a "key"
# a "key:20020329.html"
# a "key:20020329.html|������"
# a "Hoge Diary|http://www.hoge.com/diary/"
# a "Hoge Diary|20020201.html#p01"  #=> my��Ʊ���Ǥ�(�����ϵդ�����)��
#
# ����¾�Υ��ץ����:
# @options['a.tlink'] = true
#  true�˻��ꤹ��ȡ�title°���ͤȤ��ƥ����ξ����ɽ�����ޤ���
#  �����������Υ��ץ�����ͭ���ˤ�����硢��󡢥����ؤΥ���������
#  ȯ�����ޤ�����󥿥륵�������ǻ��Ѥ�����٤��⤯�ʤäƤ��ޤä�
#  ����false�ˤ��Ƥ������������ꤷ�ʤ�����false�Ǥ���
#
# @options['a.path'] = "/home/hoge/"
#  ����ե������Ȥ����ϡ�����ե������path����ꤷ�ޤ���
#  ���ꤷ�ʤ����ϡ�@data_path/cache/a.dat�ˤʤ�ޤ���
#
# ����ե������Խ���CGI�ƤӽФ��ܥ���:
# ����ե������Խ���CGI�ƤӽФ��ܥ������ꤷ�ޤ����إå����⤷���ϥեå����֤���
# ����������
#
# navi_a(name = "a.rb����") - ����ե������Խ�CGI��ƤӽФ��ޤ���
#	name - �ܥ���̾�Ρʾ�ά�������ϡ�"a.rb����"�ˤʤ��
#
# ����¾��
# ����¾�ξ���� http://home2.highway.ne.jp/mutoh/tools/ruby/ja/a.html 
# �򻲾Ȥ��Ƥ���������
# 
# Copyright (c) 2002,2003 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
# 
=begin ChangeLog
2003-03-03 MUTOH Masao <mutoh@highway.ne.jp>
	* "name|key:option"�����б�
	* my�����б�
	* ����,a.dat�����charsetƳ����option�����ܸ���꤬��ǽ�ˤʤä�(default��euc)
	* version 1.3.0

2002-05-19 MUTOH Masao <mutoh@highway.ne.jp>
	* �ɥ�����ȥ��åץǡ���

2002-05-08 MUTOH Masao <mutoh@highway.ne.jp>
	* URL�Τ߻���ǲ���ɽ������ʤ��Զ��ν���
	* version 1.2.1

2002-05-05 MUTOH Masao <mutoh@highway.ne.jp>
	* @options["a.tlink"]�ɲá�true����ꤹ���tlink��Ȥä�title�����
	  ����褦�ˤʤ롣
	* �ɥ�����ȥ��åץǡ���
	* version 1.2.0

2002-05-01 MUTOH Masao <mutoh@highway.ne.jp>
	* �����ɤΥ��꡼�󥢥åס����󥹥����ѿ��ˤϥץ�ե�����
		a_��Ĥ���褦�ˤ�����
	* ����ե������ɸ���@data_path/cache/a.dat�ˤ���
	* ����ե����������Ѥ�CGI�Ǥ���a_conf.rb���ɲä���
	* �᥽�å�navi_a���ɲä���
	* version 1.1.0

2002-03-29 MUTOH Masao <mutoh@highway.ne.jp>
	* version 1.0.0
=end

require 'nkf'

A_REG_PIPE = /\|/
A_REG_COLON = /\:/
A_REG_URL = /:\/\//
A_REG_CHARSET = /euc|sjis|jis/
A_REG_CHARSET2 = /sjis|jis/
A_REG_MY = /^\d{8}/

if @options and @options["a.path"] 
	a_path = @options["a.path"]
else
	a_path = @cache_path + "/a.dat"
end

@a_anchors = Hash.new
if FileTest::exist?(a_path)
	open(a_path) do |file|
		file.each_line do |line|
			key, baseurl, *data = line.split(/\s+/)
			if data.last =~ A_REG_CHARSET
				charset = data.pop
			else
				charset = ""
			end
			@a_anchors[key] = [baseurl, data.join(" "), charset]
		end
	end
end

def a_separate(word)
	if A_REG_PIPE =~ word
		name, data = $`, $'
	else
		name, data = nil, word
	end

	option = nil
	if data =~ A_REG_URL
		key = data
	elsif data =~ A_REG_COLON
		key, option = $`, $'
	else
		key = data #Error pattern
	end
	[key, option, name]
end

def a_convert_charset(option, charset)
	return "" unless option
	return option unless charset
	if charset =~ A_REG_CHARSET2
		ret = CGI.escape(NKF::nkf("-#{charset[0].chr}", option))
	else
		ret = option
	end
	ret
end

def a_anchor(key)
	data = @a_anchors[key]
	if data
		data.collect{|v| v ? v.dup : nil}
	else
		[nil, nil, nil]
	end
end

def a(key, option_or_name = nil, name = nil, charset = nil)
	url, value, cset = a_anchor(key)
	if url.nil?
		key, option, name = a_separate(key)
		url, value, cset = a_anchor(key)
		option_or_name = option unless option_or_name;
	end
	charset = cset unless charset
	
	value = key if value == ""

	if url.nil?
		url = key
		if name
			value = name
			url += a_convert_charset(option_or_name, charset)
		elsif option_or_name
			value = option_or_name 
		else
			value = key
		end
	else
		url += a_convert_charset(option_or_name, charset)
		value = name if name
	end

   if key =~ A_REG_MY
      option_or_name = key unless option_or_name
      return my(option_or_name, name)
   end

	if @options["a.tlink"] 
		if defined?(tlink)
			url.untaint
			result = tlink(url, value)
		else
			result = "tlink is not available."
		end
	else
		result = %Q[<a href="#{url}">#{value}</a>]
	end
	result
end

def navi_a(name = "a.rb����")
	"<span class=\"adminmenu\"><a href=\"a_conf.rb\">#{name}</a></span>\n"
end

