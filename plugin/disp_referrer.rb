# disp_referrer.rb $Revision: 1.6 $
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
2002-08-22 TADA Tadashi <sho@spc.gr.jp>
	* support AlltheWeb search.

2002-08-21 TADA Tadashi <sho@spc.gr.jp>
	* support tDiary 1.5.

2002-08-08  MUTOH Masao <mutoh@highway.ne.jp>
   * ������̤�ɽ����ˡ���ѹ����Ƹ������󥸥���˸���ʸ�����ɽ������褦�ˤ���
   * ���������������ʤ��褦�ˤ���(smbd������˾)
   * ����HTML�����
   * AOL�����ɲ�
   * Lycos��������
   * version 2.1.0

2002-08-07  MUTOH Masao <mutoh@highway.ne.jp>
   * ɽ���оݤΤ���ν���
   * version 2.0.1

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
module DiaryBase
   def referers
     newer_referer
     @referers
   end
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

unless (@options['disp_referrer.old'] or @mode == "edit") #NEW VERSION

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
	["^http://.*lycos.*/.*?(query|q)=([^&]*).*", " \\2"]],
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
    [["AOL����", "http://www.aol.com/"],
	["^http://search.*aol.com/.*query=([^&]*).*", " \\1"]],
    [["DION������", "http://www.dion.ne.jp/"],
	["^http://dir.dion.ne.jp/LookSmartSearch.jsp.*(key|QueryString)=([^&]*).*", " \\2"]],
    [["AlltheWeb����","http://www.alltheweb.com/"],
	["^http://www.alltheweb.com/.*?q=([^&]*).*", " \\1"]],
  ]

  result = %Q[<div class="refererlist"><p class="referertitle">#{referer_today}</p>\n]
  result << %Q[<ul class="referer">\n]

  regexp = Regexp.new(search_tables.collect{|item| 
						item[1..-1].collect{|v| v[0]}
					  }.join("|"), Regexp::IGNORECASE)

  refs = diary.referers
  search_refs = refs.select {|item| regexp.match(item.to_a[1][1])}.collect{|item| item[1..2].flatten}.sort.reverse

  refs = refs.collect{|item| item[1..2].flatten} - search_refs

  refs.sort.reverse.each do |cnt, ref|
	result << %Q[<li>#{cnt} <a href="#{CGI::escapeHTML(ref)}">#{CGI::escapeHTML(diary.disp_referer(@referer_table, ref))}</a></li>\n]
  end
  result << "</ul>\n<ul class=\"referer\">"

  search_result = Array.new
  search_tables.each do |title, *table|
	array = nil
	table.each do |regval, val|
	  array = search_refs.select{|item| /#{regval}/i =~ item[1]
	  }.collect{|item| [item[0], diary.disp_referer([[regval, val]], item[1])]}
	end
	if array and array.size > 0
	  sum = 0
	  query = ""
	  array.each do |cnt, str|
		sum += cnt
		query << str
		query << " x" << cnt.to_s if cnt > 1
		query << ", "
	  end
	  query.gsub!(/, $/, "")
	  query = CGI::escapeHTML(query)
	  result << %Q[<li>#{sum} <a href="#{CGI::escapeHTML(title[1])}">#{title[0]}</a> : #{query}</li>\n]
      search_refs -= array
    end
  end

  result << "</ul></div>"
end

end
