# disp_referrer.rb $Revision: 1.2 $
# -pv-
#
# ̾�Ρ�
# �����Υ�󥯸������ץ饰����
#
# ���ס�
# �����Υ�󥯸��ǥ��������󥸥�θ���ʸ����ʸ��������ľ���ޤ���
# �ޤ������������󥸥�θ�����̤�¾�Υ�󥯸��β��ˤޤȤ��ɽ�����ޤ��ʥǥե���Ȼ��ˡ�
#
# �Ȥ�����
# ʸ��������ľ���Τߡ�ɽ����tDiary��ɸ�����Ʊ�ͤ��¤Ӥˤ���ˤξ��ϡ�tdiary.conf��
# �ʲ����ɲä��Ƥ���������
# @options['disp_referrer.old'] = true
#
# ���¡�
# EUC-JP��ɽ���Ǥ��ʤ�ʸ����ɽ���Ǥ��ޤ���
#
# ����ˤĤ��ơ�
# Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
#
=begin ChangeLog
2002-08-06  MUTOH Masao <mutoh@highway.ne.jp>
   * google, Yahoo, Infoseek, Lycos, goo, OCN, excite, 
     msn, BIGLOBE, ODN, DION������⸡����̤�Ʊ����������ñ�̤ǥ�󥯰�����
     ��¦�ˤޤȤ��ɽ������褦�ˤ����������ɽ����̤ˤ���������
     @options['disp_referrer.old'] = true�����ꤹ�롣
   * version 2.0.0

2002-07-24  MUTOH Masao <mutoh@highway.ne.jp>
   * alltheweb�б�
   * jp.aol.com, aol.com�б�
   * ʸ�����Ѵ��ν�����ѹ�
   * version 1.1.0

2002-07-20  MUTOH Masao <mutoh@highway.ne.jp>
   * version 1.0.0
=end

require 'uconv'

eval(<<TOPLEVEL_CLASS, TOPLEVEL_BINDING)
def Uconv.unknown_unicode_handler(unicode)
   if unicode == 0xff5e
      "��"
   else
      "?"
   end
end
class Diary
   def disp_referer( table, ref )
      ref = CGI::unescape( ref )
      if /((e|cs)=utf-?8|jp.aol.com)/i =~ ref
         begin
            ref = Uconv.u8toeuc(ref)
         rescue Uconv::Error
         end
      elsif /&#[0-9]+/ =~ ref
         ref.gsub!(/&#([0-9]+);/){|v|
            Uconv.u8toeuc([$1.to_i].pack("U"))
         }
      elsif NKF.guess(ref) == NKF::SJIS
         ref = ref.to_euc
      end
      str = nil
      table.each do |url, name|
         regexp = Regexp.new(url, Regexp::IGNORECASE)
         if regexp =~ ref then
            str = ref.gsub(regexp, name)
            break
         end
      end
      str ? str : ref
   end   
end
TOPLEVEL_CLASS

unless @options['disp_referrer.old'] #NEW VERSION

def referer_of_today_long( diary, limit )
  return '' if not diary or diary.count_referers == 0

  search_tables = [
    [["google����","http://www.google.com/"],
	["^http://216.239.3...../search.*q=([^&]*).*", " \\1"],
    ["^http://www.google..*/.*q=([^&]*).*", " \\1"]],
    [["Yahoo��google����","http://www.yahoo.co.jp/"],
	["^http://google.yahoo.*/.*?p=([^&]*).*", " \\1"]],
    [["Infoseek����","http://www.infoseek.co.jp/"],
	["^http://www.infoseek.co.jp/.*?qt=([^&]*).*", " \\1"]],
    [["Lycos����","http://www.lycos.co.jp/"],
	["^http://.*lycos.*/.*?query=([^&]*).*", " \\1"]],
    [["goo����","http://www.goo.ne.jp/"],
	["^http://(www|search).goo.ne.jp/.*?MT=([^&]*).*", " \\2"]],
    [["@nifty����", "http://www.nifty.com/"],
	["^http://(search|asearch|www).nifty.com/.*?(q|Text)=([^&]*).*", " \\3"]],
    [["OCN����", "http://www.ocn.ne.jp/"],
	["^http://ocn.excite.co.jp/search.gw.*search=([^&]*).*", " \\1"]],
    [["excite����", "http://www.excite.co.jp/"],
	["^http://.*excite.*/.*?(search|s)=([^&]*).*", " \\2"]],
    [["msn����", "http://www.msn.co.jp/home.htm"],
	["^http://search.msn.co.jp/.*?(q|MT)=([^&]*).*", " \\2"]],
    [["BIGLOBE����", "http://www.biglobe.ne.jp/"],
	["^http://cgi.search.biglobe.ne.jp/cgi-bin/search.*?q=([^&]*).*", " \\1"]],
    [["�ƥ쥳�ॵ����", "http://www.odn.ne.jp/"],
	["^http://search.odn.ne.jp/LookSmartSearch.jsp.*(key|QueryString)=([^&]*).*", " \\2"]],
    [["DION������", "http://www.dion.ne.jp/"],
	["^http://dir.dion.ne.jp/LookSmartSearch.jsp.*(key|QueryString)=([^&]*).*", " \\2"]]
  ]

  result = %Q[<div class="refererlist"><p class="referertitle">#{referer_today}</p>\n]
  result << %Q[<ul class="referer">\n]
  data = Array.new
  num = 0
  str = ""
  before_count = 0
  before_url = "aaaaaa"
  before_table = nil
  search_table = nil
  first = true
  search_result = ""
  diary.each_referer( limit ) do |count, ref|
	if ref =~ /#{before_url}/
	  search_table = before_table
	  same_before = true
	else
	  search_tables.each do |table|
		table[1..-1].each do |url|
		  if ref =~ /#{url[0]}/
			search_table = table
			before_url = url[0]
			before_table = search_table
			break
		  end
		end
	  end
	  same_before = false
	end

	if search_table
	  if (same_before and before_count == count) or first
		first = false if first
	  else
		str.gsub!(/,$/, "")
		search_result << %Q[<li>#{before_count} x #{num} <a href="#{CGI::escapeHTML(search_table[0][1])}">[#{search_table[0][0]}] #{CGI::escapeHTML( str )}</a></li>\n]
		num = 0
		str = ""
	    first = true
      end
	  str << diary.disp_referer( search_table[1..-1], ref )
	  str << ","
	  num += 1
	  before_count = count
    else
  	  result << %Q[<li>#{count} <a href="#{CGI::escapeHTML( ref )}">#{CGI::escapeHTML( diary.disp_referer( @referer_table, ref ) )}</a></li>\n]
    end
    search_table = nil
  end
  result << "<br />"
  result << search_result
  result + '</ul></div>'
end

end

