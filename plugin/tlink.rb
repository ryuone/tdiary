# tlink.rb $Revision: 1.2 $
#
# title °���� anchor plugin
#
# �Ȥ���
#   <%= tlink( "URL", "ʸ����", "title °������ȡʾ�ά�ġ�" ) %>
#
#   �� 3 �ѥ�᡼�����ά��������URL �������� c#?? �ʤ�С�
#   ���Υĥå��ߤ����Ƥ��ǽ�ιԤ���ɽ������ޤ���
#   ������ p#?? �ʤ�С����֥����ȥ뤬����Х��֥����ȥ뤬��
#   �ʤ���кǽ�Υѥ饰��դ�ɽ������ޤ���
#
#   ��. <%= tlink( "http://tdiary.tdiary.net/20020131.html#c01", "���Υĥå���" ) %>
#       ���Ϸ��:
#       <a href="http://tdiary.tdiary.net/20020131.html#c01", title="�ƥ��ȤǤ������">���Υĥå���</a>
#
# Copyright(C) 2002 NT <nt@24i.net>
# Distributed under the GPL.
#
# Modified: by abbey <inlet@cello.no-ip.org>
#
=begin ChangeLog
2002-04-20 NT <nt@24i.net>
	* change User-Agent
	* modify some regular expressions

2002-04-19 NT <nt@24i.net>
	* modify some regular expressions
	* add User-Agent

2002-04-18 abbey <inlet@cello.no-ip.org>
	* adapt to port numbers except 80
	* adapt to #pXX

2002-04-17 NT <nt@24i.net>
	* create
=end

require 'net/http'
require 'cgi'
require 'kconv'

def getcomment( url )
  result = ""
  agent = { "User-Agent" => "DoCoMo (compatible; tDiary plugin; tlink;)" }
  host, path, frag = url.scan( %r[http://(.*?)/(.*)#((?:p|c)\d\d)] )[0]
  if /p0/ =~ frag
    frag = "(" + frag + "|" + frag.sub( /p/, "p#" ).sub( /#0/, "#" ) + ")"
  end
  port = 80
  if /(.*):(\d+)/ =~ host
    host = $1
    port = $2
  end
  hata = 0
  Net::HTTP.start( host, port ) { |http|
    response , = http.get( "/#{path}", agent )
      response.body.each { |line|
        if %r[<A NAME="#{frag}] =~ line
            if %r[<P><A NAME="p\d\d">(?:.*?)</A> (.*?)</P>] =~ line.toeuc
              result = $1
	      break
            else
              hata = 1
            end
        elsif hata == 1 && %r[^\t*(.*?)<BR>] =~ line.toeuc
            result = $1
            hata = 0
	    break
        end
      }
  }

  result = CGI::escapeHTML( result.gsub( %r[</?[aA](.*?)>], "" ) ).gsub( /&amp;nbsp;/, " " )
end

def tlink( url, str, title = nil )
  unless title
    title = getcomment( url )
  end

  %Q[<a href="#{url}", title="#{title}">#{str}</a>]
end

