# search_form.rb $Revision: 1.4 $
# -pv-
#
# ̾�Ρ�
# �����ե�����ɽ���ץ饰����
#
# ���ס�
# Namazu, Google, Yahoo!, Lycos�Ѥθ����ե������ɽ�����ޤ���
#
# �Ȥ���ꡧ
# �إå����⤷���ϥեå�
#
# �Ȥ�����
# namazu_form(url, button_name, size, default_text): Namazu��
# 			url:				�������󥸥��URL(�㡧/namazu/namazu.cgi)
# 			button_name:	�ܥ���̾��(��ά��)
# 			size:				�ƥ����ȥܥå�������(��ά��)
# 			default_text:	�ƥ����ȥܥå����ν��ɽ��ʸ��(��ά��)
#
# googlej_form(button_name, size, default_text): Google��
# 			button_name:	�ܥ���̾��(��ά��)
# 			size:				�ƥ����ȥܥå�������(��ά��)
# 			default_text:	�ƥ����ȥܥå����ν��ɽ��ʸ��(��ά��)
#
# yahooj_form(button_name, size, default_text): Yahoo!��
# 			button_name:	�ܥ���̾��(��ά��)
# 			size:				�ƥ����ȥܥå�������(��ά��)
# 			default_text:	�ƥ����ȥܥå����ν��ɽ��ʸ��(��ά��)
#
# lycosj_form(button_name, size, default_text): Lycos��
# 			button_name:	�ܥ���̾��(��ά��)
# 			size:				�ƥ����ȥܥå�������(��ά��)
#
# ��ա�
# �ƼҸ������󥸥�����Ѥˤʤ�ݤϡ����줾��Υ����Ȥǥ饤��������
# ��ǧ���Ƥ���������
# 
# ����¾��
# �ܤ����ϡ�http://home2.highway.ne.jp/mutoh/tools/ruby/ja/search_form.html
# �򻲾Ȥ��Ƥ���������
#
# ����ˤĤ��ơ�
# Copyright (c) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# Distributed under the same license terms as tDiary.
# 
=begin ChangeLog
2002-05-19 MUTOH Masao <mutoh@highway.ne.jp>
	* �ɥ�����ȥ��åץǡ���
	* version 1.0.1

2002-04-01 MUTOH Masao <mutoh@highway.ne.jp>
	* tab = 3, ʸ����κۤ�������

2002-03-24 MUTOH Masao <mutoh@highway.ne.jp>
	* Namazu, Google, Yahoo!, Lycos�θ����ե�����򥵥ݡ���
	* version 1.0.0
=end

def search_form(url, query, button_name = "Search", size = 20, 
						default_text = "", first_form = "", last_form = "")
%Q[
	<form class="search" method="GET" action="#{url}">
	#{first_form}
		<input class="search" type="text" name="#{query}" size="#{size}" value="#{default_text}">
		<input class="search" type="submit" value="#{button_name}">
	#{last_form}
	</form>
]
end

def namazu_form(url, button_name = "Search", size = 20, default_text = "")
	search_form(url, "query", button_name, size, default_text)
end

def googlej_form(button_name = "Google ����", size = 20, default_text = "")
	first = %Q[<a href="http://www.google.com/">
		<img src="http://www.google.com/logos/Logo_40wht.gif" 
			border="0" alt="Google" align="absmiddle"></a>]
	last = %Q[<input type=hidden name=hl value="ja">]
	search_form("http://www.google.com/search", "q", button_name, size, default_text, first, last)
end

def yahooj_form(button_name = "Yahoo! ����", size = 20, default_text = "")
	search_form("http://search.yahoo.co.jp/bin/search", "p", button_name, size, default_text)
end

def lycosj_form(button_name = " ���� ", size = 20)
	first = %Q[ <a href="http://www.lycos.co.jp/">
							<img src="http://www.lycos.co.jp/images/logo_link.gif" 
								alt="Lycos" width="70" height="20" border="0"></a>]
	search_form("http://search.lycos.co.jp/main.html", "query", button_name, size, "", first)
end
