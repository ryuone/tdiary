# search_form.rb $Revision: 1.1 $
#
# �Ƽ︡�����󥸥�θ����ե�����ɽ���ץ饰����
#
# Namazu��: namazu_form(url, button_name = "Search", size = 20, default_text = "")
# Google��: googlej_form(button_name = "Google ����", size = 20, default_text = "")
# Yahoo!��: yahooj_form(button_name = "Yahoo! ����", size = 20, default_text = "")
# Lycos�� : lycosj_form(button_name = " ���� ", size = 20)
#
# url - �������󥸥��URL(�㡧/namazu/namazu.cgi)
# button_name - �ܥ���̾��
# size - �ƥ����ȥܥå�������
# default_text - �ƥ����ȥܥå����ν��ɽ��ʸ��
#
# Copyright (c) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# Distributed under the same license terms as tDiary.
# 

def search_form(url, query, button_name = "Search", size = 20, default_text = "",  
				first_form = "", last_form = "")
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
