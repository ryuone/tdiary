# disp_referrer.rb $Revision: 1.24 $
# -pv-
#
# ̾�Ρ�
# �����Υ�󥯸������ץ饰����
#
# ���ס�
# �����Υ�󥯸��ǥ��������󥸥�θ���ʸ����ʸ��������ľ���ޤ���
# �ޤ������������󥸥�θ�����̤�¾�Υ�󥯸��β��ˤޤȤ��ɽ�����ޤ�
# �ʥǥե���Ȼ��ˡ�
# �ʤ���tDiary-1.5.x���ѤǤ���
#
# �Ȥ�����
# ʸ��������ľ���Τߡ�ɽ����tDiary��ɸ�����Ʊ�ͤ��¤Ӥˤ���ˤξ��ϡ�
# tdiary.conf�˰ʲ����ɲä��Ƥ���������
# @options['disp_referrer.old'] = true
#
# ���¡�
# EUC-JP��ɽ���Ǥ��ʤ�ʸ����ɽ���Ǥ��ޤ���
#
# ����¾��
# http://tdiary-users.sourceforge.jp/cgi-bin/wiki.cgi?disp_referrer%2Erb
# �򻲾Ȥ��Ƥ���������
#
# ����ˤĤ��ơ�
# Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
#
=begin ChangeLog
2003-05-06 MUTOH Masao <mutoh@highway.ne.jp>
	* MSN�������� Pointed out by ��ޤ�����, yoshimi����

2002-12-04 TADA Tadashi <sho@spc.gr.jp>
	* document update.
	
2002-10-13 MUTOH Masao <mutoh@highway.ne.jp>
	* Metcha Search��URL���ְ㤨�Ƥ����Τ�����
	
2002-10-12 MUTOH Masao <mutoh@highway.ne.jp>
   * �֤���¾�פ��դ����ˡ��������󥸥�̾�θ��ˡ�:�פ��դ��ʤ��Զ��ν���(pointed out by TADA Tadashi <sho@spc.gr.jp>)
   * goo��������
   * version 2.3.1

2002-10-11 MUTOH Masao <mutoh@highway.ne.jp>
   * @options['disp_referrer.cols']�ɲá����Ĥθ������󥸥��ɽ�����륫���������Ǥ���褦�ˤ���(�ǥե����10��)��
     ������Ķ�������ϡ�����¾�ˤޤȤ��ɽ������롣
   * �������η����֤����������ƤΥ�󥯸�������������ä���롼�פ�ȴ����褦�ʥ��å����ɲá�
     ����ˤ�ꡢ���٤��㤤�������󥸥���ɲä��Ƥ�®��Ū�ˤ��ۤɺ����Фʤ��褦�ˤʤä���
   * TOCC/Search��Metcha Search��metacrawler������DOGPILE������NAXEARCH��overture������
     looksmart������i won_Search��EarthLink������About�����ɲ�
   * Yahoo!��AOL��Google�� Biglobe��Infoseek��Fresheye��Netscape��������
   * version 2.3.0

2002-10-07 Junichiro Kita <kita@kitaj.no-ip.com>
	* add @options['disp_referrer.search_table']

2002-10-07 TADA Tadashi <sho@spc.gr.jp>
	* for tDiary 1.5.0.20021003.

2002-09-09  MUTOH Masao <mutoh@highway.ne.jp>
   * ��ܥåȤ褱�������Ƥ��ʤ��Զ��ν���(pointed out by TADA Tadashi<sho@spc.gr.jp>)
   * ����������ɤ�ʣ���󤢤���Ρ�x2�ס�x3�פ򡢥�󥯤γ��˽Ф���(proposed by TADA Tadashi<sho@spc.gr.jp>)
   * Web.escapeHTML()�ν�����1����ȴ���Ƥ����Τ��ɲ�
   * version 2.2.2

2002-09-08  MUTOH Masao <mutoh@highway.ne.jp>
   * escape�⥸�塼�뤬web/�ǥ��쥯�ȥ��۲��˥��󥹥ȡ��뤵�������б�
   Pointed out by Junichiro KITA <kita@kitaj.no-ip.com>.
	* tDiary-1.5.x��ư��ʤ��ʤäƤ����Х��ν���
   Fixed by Junichiro KITA <kita@kitaj.no-ip.com>.
   * version 2.2.1

2002-09-04  MUTOH Masao <mutoh@highway.ne.jp>
   * ��®�������르�ꥺ�หľ������ӡ�fastescƳ����������(?)�Ǽ¹Ի��֤�Ⱦʬ�ʲ�(45%����)�˺︺�Ǥ�����
   * Netscape��������
	* version 2.2.0

2002-08-30  MUTOH Masao <mutoh@highway.ne.jp>
   * @options['disp_referrer.deny_user_agents']�ɲá���ܥåȤ褱���Ѥ��롣
     ��ܥåȤ褱��referer_of_today_(short|long)�Τɤ���Ǥ�Ԥ��褦�ˤ�����
     �ǥե���Ȥ�Google, Goo, Hatena Antenna���б���
     (Proposed by TADA Tadashi<sho@spc.gr.jp>)
   * @options["disp_referrer.table"]�ɲá�������̤ǤϤʤ��̾�Υ�󥯸��⸡�������ʬƱ��
     ������ñ�̤ǤޤȤ�뤳�Ȥ��Ǥ��롣������ˡ�⸡���ơ��֥��Ʊ�͡�
   * ���Ƥθ�����̤˥�󥯤�Ž��褦�ˤ�����
     (Proposed by TADA Tadashi<sho@spc.gr.jp>)
   * ������̤�����ҥåȿ���¿����˥����Ȥ���褦�ˤ�����
   * Netscape, Fresheye�б�
   * Google, MSNɽ������

2002-08-22 TADA Tadashi <sho@spc.gr.jp>
	* support AlltheWeb search.
	* support tDiary 1.5 HTML.

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
     msn, BIGLOBE, ODN, DION����θ�����̤�Ʊ����������ñ�̤ǥ�󥯰�����
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
require 'nkf'
begin
   require 'escape'
rescue LoadError
   begin
      require 'web/escape'
   end
end

eval(<<TOPLEVEL_CLASS, TOPLEVEL_BINDING)
def Uconv.unknown_unicode_handler(unicode)
   if unicode == 0xff5e
      "��"
   else
      raise Uconv::Error
   end
end
module TDiary
	module DiaryBase
	  @reg_char_utf8 = /&#[0-9]+;/
	  def referers
		newer_referer
		@referers
	  end
	  def disp_referer(table, ref)
		ret = Web.unescape(ref)
		if @reg_char_utf8 =~ ref
		  ret.gsub!(@reg_char_utf8){|v|
			Uconv.u8toeuc([$1.to_i].pack("U"))
		  }
		else
		  begin
			ret = Uconv.u8toeuc(ret)
		  rescue Uconv::Error
			ret = NKF::nkf('-e', ret)
		  end
		end
		
		table.each do |url, name|
		  regexp = Regexp.new(url, Regexp::IGNORECASE)
		  break if ret.gsub!(regexp, name)
		end
		ret
	  end
	end
end
TOPLEVEL_CLASS

# Deny user agents.
deny_user_agents = ["googlebot", "Hatena Antenna", "moget@goo.ne.jp"]
if @options['disp_referrer.deny_user_agents']
  deny_user_agents += @options['disp_referrer.deny_user_agents']
end
@disp_referrer_antibots = Regexp::new("(" + deny_user_agents.join("|") + ")")

def disp_referrer_antibot?
  @disp_referrer_antibots =~ @cgi.user_agent
end

# Short referrer
alias disp_referrer_short referer_of_today_short
def referer_of_today_short(diary, limit)
   return '' if disp_referrer_antibot?
   disp_referrer_short(diary, limit)
end

# Long referrer
unless (@options['disp_referrer.old'] or @mode == "edit") #NEW VERSION

@options['disp_referrer.cols'] = 10 unless @options['disp_referrer.cols']
def disp_referrer_main(diary, refs, reg_table)
  result = Array.new
  reg_table.each do |title, *table|
	a_row = Array.new
	sum = 0
	etc_sum = 0 

    #���å�Ū�ˤϣ��Ĥθ������󥸥��ʣ���θ���������ɽ������ä����λ���
	#��θ���Ƽ㴳̵�̤ʤ���(����all_num�Ǥ��줾�����ʬ���������塢���٥�����
    #�Ⱥ�����ʬ����μ���)�򤷤Ƥ���Τ����
	all_num = @options['disp_referrer.cols']
	table.each do |regval|
	  break if refs.size < 1
	  a_row_ref = refs.select{|item| /#{regval[0]}/i =~ item[1]}
	  if a_row_ref and a_row_ref.size > 0
		if all_num < 0 or all_num > a_row_ref.size
		  a_row_max = a_row_ref.size
		else
		  a_row_max = all_num
		end
		
		refs -= a_row_ref
		a_row += a_row_ref[0...a_row_max].collect{|item|
		  sum += item[0]
		  query = "<a href=\"#{Web.escapeHTML(item[1])}\">"
		  str = diary.disp_referer([regval], item[1])
		  str = "/" if str.size == 0
		  query << Web.escapeHTML(str) << "</a>"
		  query << " x" << item[0].to_s if item[0] > 1
		  [item[0], query]
		}
		if a_row_ref.size >= a_row_max 
		  a_row_ref[a_row_max...a_row_ref.size].each {|item|
			sum += item[0]
			etc_sum += item[0]
		  }
		end
	  end
	end

	a_row.sort!{|a, b| -(a[0] <=> b[0])}

	a_row = a_row[0...all_num] if a_row and a_row.size > all_num and all_num > 0
	div = ":"
	if etc_sum > 0
	  if all_num > 0
		a_row << [0, "<span class=\"disp-referrer-etc\">����¾</span> x#{etc_sum}"]
	  else
		a_row << [0, " "]
		div = ""
	  end
	end
	if a_row and a_row.size > 0
	  result << [sum, %Q[<li>#{sum} <a href="#{Web.escapeHTML(title[1])}">#{Web.escapeHTML(title[0])}</a> #{div} #{a_row.collect{|item| item[1]}.join(", ")}</li>\n]]
    end
  end
  [result, refs]
end

def referer_of_today_long(diary, limit)
  return '' if not diary or diary.count_referers == 0 or disp_referrer_antibot?

  search_table = [
    [["Google����","http://www.google.com/"],
	["^http://.*(216.239|google).*q=([^&]*).*", "\\2"]],
    [["Yahoo����","http://www.yahoo.co.jp/"],
	["^http://.*.yahoo.*?p=([^&]*).*", "\\1"]],
    [["Infoseek����","http://www.infoseek.co.jp/"],
	["^http://.*infoseek.*?qt=([^&]*).*", "\\1"]],
    [["Lycos����","http://www.lycos.co.jp/"],
	["^http://.*lycos.*/.*?(query|q)=([^&]*).*", "\\2"]],
    [["goo����","http://www.goo.ne.jp/"],
	["^http://.*goo.ne.jp/.*?MT=([^&]*).*", "\\1"]],
    [["@nifty����", "http://www.nifty.com/"],
	["^http://(search|asearch|www).nifty.com/.*?(q|Text)=([^&]*).*", "\\3"]],
    [["OCN����", "http://www.ocn.ne.jp/"],
	["^http://ocn.excite.co.jp/search.gw.*search=([^&]*).*", "\\1"]],
    [["excite����", "http://www.excite.co.jp/"],
	["^http://.*excite.*?(search|s)=([^&]*).*", "\\2"]],
    [["msn����", "http://www.msn.co.jp/home.htm"],
	["^http://.*search.msn.*?[\?&](q|MT)=([^&]*).*", "\\2"]],
    [["BIGLOBE����", "http://www.biglobe.ne.jp/"],
	["^http://cgi.search.biglobe.ne.jp/cgi-bin/search.*?(q|key)=([^&]*).*", "\\2"]],
    [["�ƥ쥳�ॵ����", "http://www.odn.ne.jp/"],
	["^http://search.odn.ne.jp/LookSmartSearch.jsp.*(key|QueryString)=([^&]*).*", "\\2"]],
    [["Netscape����", "http://google.netscape.com/"],
	["^http://.*.netscape.com/.*(query|q|search)=([^&]*).*", "\\2"]],
    [["DION������", "http://www.dion.ne.jp/"],
	["^http://dir.dion.ne.jp/LookSmartSearch.jsp.*(key|QueryString)=([^&]*).*", "\\2"]],
	[["Metcha Search","http://bach.scitec.kobe-u.ac.jp/"],
	["^http://bach.scitec.kobe-u.ac.jp/cgi-bin/metcha.cgi?q=([^&]*).*", "\\1"]],
    [["AOL����", "http://www.aol.com/"],
	["^http://.*aol.com/.*query=([^&]*).*", "\\1"]],
    [["Fresheye����", "http://www.fresheye.com/"],
	["^http://.*fresheye.*kw=([^&]*).*", "\\1"]],
	[["AlltheWeb����","http://www.alltheweb.com/"],
	["^http://www.alltheweb.com/.*?q=([^&]*).*", "\\1"]],
	[["TOCC/Search","http://www.tocc.co.jp/"],
	["^http://www.tocc.co.jp.*QRY=([^&]*).*", "\\1"]],
	[["EarthLink����","http://www.earthlink.net/"],
	["^http://.*earthlink.*q=([^&]*).*", "\\1"]],
	[["i won_Search","http://home.iwon.com/"],
	["^http://.*iwon.*searchfor=([^&]*).*", "\\1"]],
	[["metacrawler����","http://www.metacrawler.com/"],
	["^http://.*metacrawler.com/texis/search?q=([^&]*).*", "\\1"]],
	[["DOGPILE����","http://www.dogpile.com/"],
	["^http://search.dogpile.com/texis/search.q=([^&]*).*", "\\1"]],
	[["NEXEARCH","http://www.naver.co.jp/"],
	["^http://search.naver.*query=([^&]*).*", "\\1"]],
	[["overture����","http://www.overture.com/"],
	["^http://overture.*Keywords=([^&]*).*", "\\1"]],
	[["About����","http://www.about.com/"],
	["^http://.*about.*terms=([^&]*).*", "\\1"]],
	[["looksmart����","http://www.looksmart.com/"],
	["^http://www.looksmart.com.*key=([^&]*).*", "\\1"]]
  ]

  if @options["disp_referrer.search_table"]
	search_table += @options["disp_referrer.search_table"]
  end

  result = %Q[<div class="caption">#{referer_today}</div>\n]
  result << %Q[<ul>\n]

  #search part.
  refs = diary.referers.collect{|item| item[1..2].flatten}
  refs.sort!{|a,b| -(a[0] <=> b[0])} if refs
	
  search_result, refs = disp_referrer_main(diary, refs, search_table)

  #optional part.
  if @options["disp_referrer.table"]
	opt_result, refs = disp_referrer_main(diary, refs, @options["disp_referrer.table"])
  end

  #normal and optional part.
  normal_result = Array.new
  refs.each do |cnt, ref|
	normal_result << [cnt, %Q[<li>#{cnt} <a href="#{Web.escapeHTML(ref)}">#{Web.escapeHTML(diary.disp_referer(@referer_table, ref))}</a></li>\n]]
  end

  #show normal part.
  normal_result += opt_result if opt_result
  normal_result.sort!{|a,b| - (a[0] <=> b[0])}
  normal_result.collect!{|item| item[1]} if normal_result
  result << normal_result.join if normal_result 
  result << "</ul>\n<ul>"
  #show search part.
  search_result.sort!{|a,b| - (a[0] <=> b[0])}
  search_result.collect!{|item| item[1]} if search_result
  result << search_result.join if search_result
  result << "</ul>"
end

end
