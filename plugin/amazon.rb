# amazon.rb $Revision: 1.7 $
#
# isbn_image_left: ���ꤷ��ISBN�ν�Ƥ�class="left"��ɽ��
#   �ѥ�᥿:
#     asin:    ASIN�ޤ���ISBN
#     comment: ������
#
# isbn_image_right: ���ꤷ��ISBN�ν�Ƥ�class="right"��ɽ��
#   �ѥ�᥿:
#     asin:    ASIN�ޤ���ISBN
#     comment: ������
#
# isbn_image: ���ꤷ��ISBN�ν�Ƥ�class="amazon"��ɽ��
#     asin:    ASIN�ޤ���ISBN
#     comment: ������
#
# isbn: amazon�˥����������ʤ��ʰץС������
#     asin:    ASIN�ޤ���ISBN
#     comment: ������
#
#   ASIN�Ȥϥ��ޥ����ȼ��ξ��ʴ���ID�Ǥ���
#   ���Ҥ�ISBN��ASIN�����Ϥ���Ƚ��Ҥ�ɽ������ޤ���
#
#   ���줾�쾦�ʲ��������Ĥ���ʤ��ä�����
#       <a href="amazon�Υڡ���">����̾</a>
#   �Τ褦�˾���̾��ɽ�����ޤ���
#   �����Ȥ����Ҥ���Ƥ�����Ͼ���̾�������Ȥ����Ƥ��Ѥ��ޤ���
#
# tdiary.conf�ˤ���������:
#   @options['amazon.aid']:   ������������ID����ꤹ�뤳�Ȥǡ���ʬ�Υ�
#                             ���������ȥץ��������ѤǤ��ޤ�
#   @options['amazon.proxy']: ��host:post�׷�����HTTP proxy����ꤹ���
#                             Proxy��ͳ��Amazon�ξ����������ޤ�
#
#
# ��ա��������Ϣ����١�www.amazon.co.jp�Υ����������ȥץ�����
# ��ǧ�ξ����Ѥ��Ʋ�������
#
# Copyright (C) 2002 by HAL99 <hal99@mtj.biglobe.ne.jp>
#
# Original: HAL99 <hal99@mtj.biglobe.ne.jp>
# Modified: by TADA Tadashi<sho@spc.gr.jp>,
#              kazuhiko<kazuhiko@fdiary.net>,
#              woods<sodium@da3.so-net.ne.jp>,
#              munemasa<munemasa@t3.rim.or.jp>,
#              dai<dai@kato-agri.com>
#
=begin ChangeLog
2002-09-01 Junichiro Kita <kita@kitaj.no-ip.com>
	* change URL for images.

2002-07-09 TADA Tadashi <sho@spc.gr.jp>
	* follow chaging of title format in amazon.
=end

require 'net/http'
require 'timeout'

def getAmazon( asin )

	cache = "#{@cache_path}/amazon"

	Dir::mkdir( cache ) unless File::directory?( cache )
	begin
		item = File::readlines( "#{cache}/#{asin}" )
		raise if item.length < 2

		return item
	rescue
	end

	limittime = 10

	host = 'www.amazon.co.jp'
	path = "/exec/obidos/ASIN/#{asin}"
	port = '80'

	proxy_host = nil
	proxy_port = 8080
	if /^([^:]+):(\d+)$/ =~ @options['amazon.proxy'] then
		proxy_host = $1
		proxy_port = $2.to_i
	end

	item_url = nil
	item_name = nil
	img_url = nil
	img_name = nil
	img_height = nil
	img_width = nil

	timeout( limittime ) do
		begin
			Net::HTTP.Proxy( proxy_host, proxy_port ).start( host, port ) do |http|

				response , = http.get(path)
				response.body.each do |line|
					line = NKF::nkf("-e",line)
					if line =~ /^Amazon.co.jp�� (.*)$/
						item_name = CGI::escapeHTML(CGI::unescapeHTML($1))
					end
					if line =~ /(<img src="(http\:\/\/images-jp\.amazon\.com\/images\/P\/(.*MZZZZZZZ.jpg))".*?>)/i
						img_tag = $1
						img_url = $2
						img_name = $3
						if img_tag =~ / width="?(\d+)"?/i
							img_width = $1
						end
						if img_tag =~ / height="?(\d+)"?/i
							img_height = $1
						end

					end
				end
			end
		rescue Net::ProtoRetriableError => err
			item_url = err.response['location']
			if %r|http://([^:/]*):?(\d*)(/.*)| =~ item_url then
				host = $1
				port = $2.to_i
				path = $3
				raise 'not amazon domain' if host !~ /\.amazon\.(com|co\.uk|co\.jp|de|fr)$/				 
				raise 'bad location was returned.' unless host and path
				port = 80 if port == 0
				retry
			end
		rescue
			raise 'getting item was failed'
		end
	end
	item = [item_url.strip,item_name,img_url,img_name,img_width,img_height]
	open("#{cache}/#{asin}","w") do |f|
		item.each do |i|
			next unless i
			f.print i,"\n"
			end
	end
	return item
end

def amazonNoImg(item_url,item_name)
	%Q[<a href="#{item_url.strip}">#{item_name.strip}</a>]
end

def getAmazonImg(position,asin,comment)
	begin

		item = getAmazon(asin)
		item[0].sub!( %r|[^/]+$|, @options['amazon.aid'] ) if @options['amazon.aid']

		item_name = item[1]
		item[1] = comment if comment
		unless item[2]
			return amazonNoImg(item[0],item[1])
		end
		r = ""
		r << %Q[<a href="#{item[0].strip}">]
		r << %Q[<img class="#{position}" src="#{item[2].strip}" ]
		r << %Q[width="#{item[4].strip}" ] if item[4]
		r << %Q[height="#{item[5].strip}" ] if item[5]
		r << %Q[alt="#{item[1].strip}" />]
		r << item[1].strip if position == "amazon"
		r << %Q[</a>]
	rescue
		asin
	end
end

def isbnImgLeft(asin,comment = nil)
	getAmazonImg("left",asin,comment)
end
alias isbn_image_left isbnImgLeft

def isbnImgRight(asin,comment = nil)
	getAmazonImg("right",asin,comment)
end
alias isbn_image_right isbnImgRight

def isbnImg(asin,comment = nil)
	getAmazonImg("amazon",asin,comment)
end
alias isbn_image isbnImg
alias amazon isbnImg

def isbn(asin,comment)
	item_url = "http://www.amazon.co.jp/exec/obidos/ASIN/#{asin}/"
	item_url << @options['amazon.aid'] if @options['amazon.aid']
	amazonNoImg(item_url,comment)
end
