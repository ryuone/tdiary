# tlink.rb $Revision: 1.5 $
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
2002-05-05 NT <nt@24i.net>
	* add URL to User-Agent

2002-04-21 abbey <inlet@cello.no-ip.org>
	* add error shori

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
  myhost = ENV["HTTP_HOST"]
  myurl = ENV["REDIRECT_URL"]
  ref = "http://#{myhost}#{myurl}"
  agent = { "User-Agent" => "DoCoMo (compatible; tDiary plugin; tlink; #{ref})" }
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
  http = Net::HTTP.new( host, port )
  begin
    http.open_timeout = 3
    response , = http.get( "/#{path}", agent )
    response.body.each { |line|
      if %r[<A NAME="#{frag}] =~ line
        if %r[<P><A NAME="p#?\d+">(?:.*?)</A> (.*?)</P>] =~ line.toeuc
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
  rescue
    result = ""
  end

  result = CGI::escapeHTML( result.gsub( %r[</?[aA](.*?)>], "" ) ).gsub( /&amp;nbsp;/, " " )
end

def tlink( url, str, title = nil )
  unless title
    title = getcomment( url )
  end

  %Q[<a href="#{url}", title="#{title}">#{str}</a>]
end

