# tlink.rb $Revision: 1.1 $
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

def getcomment( url )
  agent = { "User-Agent" => "tDiary plugin (tlink)" }
  result = ""
  host, path, frag = url.scan( %r[http://(.*?)/(.*)#((?:p|c)\d\d)] )[0]
  port = 80
  if /(.*):(\d+)/ =~ host
    host = $1
    port = $2
  end
  hata = 0
  Net::HTTP.start( host, port ) { |http|
    response , = http.get( "/#{path}", agent )
      response.body.each { |line|
        if %r[<a name="#{frag}] =~ line
          if %r[<a(?:.*?)##{frag}(?:.*?)</a>(.*?)</(h3|p)>] =~ line
            result = $1
	    break
          else
            hata = 1
          end
        elsif hata == 1 && %r[<p>(.*?)(<br>|</p>)] =~ line
          result = $1
          hata = 0
	  break
        end
      }
  }

  result = CGI::escapeHTML( result.gsub( %r[</?a(.*?)>], "" ) ).gsub( /&amp;nbsp;/, " " )
end

def tlink( url, str, title = nil )
  unless title
    title = getcomment( url )
  end

  %Q[<a href="#{url}", title="#{title}">#{str}</a>]
end
