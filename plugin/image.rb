# -*- coding: utf-8 -*-
# image.rb
# -pv-
# 
# 名称:
# 絵日記Plugin
#
# 概要:
# 日記更新画面からの画像アップロード、本文への表示
#
# 使う場所:
# 本文
#
# 使い方:
# image( number, 'altword', thumbnail, size, place ) - 画像を表示します。
#    number - 画像の番号0、1、2等
#    altword - imgタグの altに入れる文字列
#    thumbnail - サムネイル(小さな画像)を指定する(省略可)
#    size - 画像のサイズ(Array)。[width, height]の形式で指定(省略可)
#    place - imgタグのclass名(省略可)。省略時は'photo'
#
# image_left( number, 'altword', thumbnail, size ) - imageにclass=leftを追加します。
# image_right( number, 'altword', thumbnail, size ) - imageにclass=rightを追加します。
#
# image_link( number, 'desc' ) - 画像へのリンクを生成します。
#    number - 画像の番号0、1、2等
#    desc - 画像の説明
#
# その他:
# tDiary version 1.5.4以降で動作します。
# tdiary.confで指定できるオプション:
#  @options['image.dir']
#     画像ファイルを保存するディレクトリ。無指定時は'./images/'
#     Webサーバの権限で書き込めるようにしておく必要があります。
#  @options['image.url']
#     画像ファイルを保存するディレクトリのURL。無指定時は'./images/'
#  @options['image.maxnum']
#     1日あたりの最大画像数。無指定時は1
#     ただし@secure = true時のみ有効
#  @options['image.maxsize']
#     1枚あたりの最大画像バイト数。無指定時は10000
#     ただし@secure = true時のみ有効
#  @options['image.maxwidth']
#     sizeを指定しなかった場合に指定できる画像の最大表示幅。無指定時はnil
#     表示のたびにファイルアクセスが入るので、重くなるかも?
#     @secure = true時は無効
#
# ライセンスについて:
# Copyright (c) 2002,2003 Daisuke Kato <dai@kato-agri.com>
# Copyright (c) 2002 Toshi Okada <toshi@neverland.to>
# Copyright (c) 2003 Yoshimi KURUMA <yoshimik@iris.dti.ne.jp>
# Distributed under the GPL
#

unless @resource_loaded then
	def image_error_num( max ); "画像は1日#{h max}枚までです。不要な画像を削除してから追加してください"; end
	def image_error_size( max ); "画像の最大サイズは#{h max}バイトまでです"; end
	def image_label_list_caption; '絵日記(一覧・削除)'; end
	def image_label_add_caption; '絵日記(追加)'; end
	def image_label_description; '画像の説明'; end
	def image_label_add_plugin; '本文に追加'; end
	def image_label_delete; 'チェックした画像の削除'; end
	def image_label_only_jpeg; 'JPEGのみ'; end
	def image_label_add_image; 'この画像をアップロードする'; end
end

def image( id, alt = 'image', thumbnail = nil, size = nil, place = 'photo' )
	if @conf.secure then
		image = "#{@image_date}_#{id}.jpg"
		image_t = "#{@image_date}_#{thumbnail}.jpg" if thumbnail
	else
   	image = image_list( @image_date )[id.to_i]
   	image_t = image_list( @image_date )[thumbnail.to_i] if thumbnail
	end
	if @conf.iphone? then
		size = ''
	elsif size
		if size.kind_of?(Array)
			size = %Q| width="#{h size[0]}" height="#{h size[1]}"|
		else
			size = %Q| width="#{size.to_i}"|
		end
	elsif @image_maxwidth and not @conf.secure then
		File::open( "#{@image_dir}/#{image}".untaint ) do |f|
			t, w, h = image_info( f )
			if w > @image_maxwidth then
				size = %Q[ width="#{h @image_maxwidth}"]
			else
				size = ""
			end
		end
	end
	if thumbnail then
	  	%Q[<a href="#{h @image_url}/#{h image}"><img class="#{h place}" src="#{h @image_url}/#{h image_t}" alt="#{h alt}" title="#{h alt}"#{size}></a>]
	else
		%Q[<img class="#{h place}" src="#{h @image_url}/#{h image}" alt="#{h alt}" title="#{h alt}"#{size}>]
	end
end

def image_left( id, alt = "image", thumbnail = nil, width = nil )
   image( id, alt, thumbnail, width, "left" )
end

def image_right( id, alt = "image", thumbnail = nil, width = nil )
   image( id, alt, thumbnail, width, "right" )
end

def image_link( id, desc )
	if @conf.secure then
		image = "#{@image_date}_#{id}.jpg"
	else
   	image = image_list( @image_date )[id.to_i]
	end
   %Q[<a href="#{h @image_url}/#{h image}">#{desc}</a>]
end

#
# initialize
#
@image_dir = @options && @options['image.dir'] || './images/'
@image_dir.chop! if /\/$/ =~ @image_dir
@image_url = @options && @options['image.url'] || "#{@conf.base_url}images/"
@image_url.chop! if /\/$/ =~ @image_url
@image_maxwidth = @options && @options['image.maxwidth'] || nil

add_body_enter_proc do |date|	
   @image_date = date.strftime( "%Y%m%d" )
   ""
end

#
# service methods below.
#

def image_info( f )
	image_type = nil
	image_height = nil
	image_width = nil

	sig = f.read( 24 )
	if /\A\x89PNG\x0D\x0A\x1A\x0A(....)IHDR(........)/onm =~ sig
		image_type = 'png'
		image_width, image_height = $2.unpack( 'NN' )

	elsif /\AGIF8[79]a(....)/onm =~ sig
		image_type   = 'gif'
		image_width, image_height = $1.unpack( 'vv' )

	elsif /\A\xFF\xD8/onm =~ sig
		image_type = 'jpg'
		data = $'
		until data.empty?
			break if data[0] != 0xFF
			break if data[1] == 0xD9

			data_size = data[2,2].unpack( 'n' ).first + 2
			case data[1]
			when 0xc0, 0xc1, 0xc2, 0xc3, 0xc5, 0xc6, 0xc7, 0xc9, 0xca, 0xcb, 0xcd, 0xce, 0xcf
				image_height, image_width = data[5,4].unpack('nn')
				break
			else
				if data.size < data_size
					f.seek(data_size - data.size, IO::SEEK_CUR)
					data = ''
				else
					data = data[data_size .. -1]
				end
				data << f.read( 128 ) if data.size <= 4
			end
		end
	end

	return image_type, image_width, image_height
end

def image_ext
	if @conf.secure then
		'jpg'
	else
		'jpg|jpeg|gif|png'
	end
end

def image_list( date )
	return @image_list if @conf.secure and @image_list
	list = []
	reg = /#{date}_(\d+)\.(#{image_ext})$/
	begin
		Dir::foreach( @image_dir ) do |file|
			list[$1.to_i] = file if reg =~ file
		end
	rescue Errno::ENOENT
	end
	list
end

if @conf.secure and /^(form|edit|formplugin|showcomment)$/ =~ @mode then
	@image_list = image_list( @date.strftime( '%Y%m%d' ) )
end

if /^formplugin$/ =~ @mode then
   maxnum = @options['image.maxnum'] || 1
   maxsize = @options['image.maxsize'] || 10000

	begin
	   date = @date.strftime( "%Y%m%d" )
		images = image_list( date )
	   if @cgi.params['plugin_image_addimage'][0]
	      filename = @cgi.params['plugin_image_file'][0].original_filename
			extension, = image_info( @cgi.params['plugin_image_file'][0] )
			@cgi.params['plugin_image_file'][0].rewind
			if extension =~ /\A(#{image_ext})\z/i
				begin
	         	size = @cgi.params['plugin_image_file'][0].size
				rescue NameError
	         	size = @cgi.params['plugin_image_file'][0].stat.size
				end
				if @conf.secure then
					raise image_error_num( maxnum ) if images.compact.length >= maxnum
					raise image_error_size( maxsize ) if size > maxsize
				end
	         file = "#{@image_dir}/#{date}_#{images.length}.#{extension}".untaint
		      File::umask( 022 )
		      File::open( file, "wb" ) do |f|
					f.print @cgi.params['plugin_image_file'][0].read
		      end
	         images << File::basename( file ) # for secure mode
	      end
	   elsif @cgi.params['plugin_image_delimage'][0]
	      @cgi.params['plugin_image_id'].each do |id|
	         file = "#{@image_dir}/#{images[id.to_i]}".untaint
	         if File::file?( file ) && File::exist?( file )
	            File::delete( file )
	         end
	         images[id.to_i] = nil # for secure mode
	      end
	   end
	rescue
		@image_message = $!.to_s
	end
end

add_header_proc do
	%Q[\t<script type="text/javascript"><!--
	var elem=null
	function insertImage(val){
		elem.value+=val
	}
	window.onload=function(){
		for(var i=0;i<document.forms.length;i++){
			for(var j=0;j<document.forms[i].elements.length;j++){
				var e=document.forms[i].elements[j]
				if(e.type&&e.type=="textarea"){
					if(elem==null){
						elem=e
					}
					e.onfocus=new Function("elem=this")
				}
			}
		}
	}
	//-->
	</script>
	]
end

add_form_proc do |date|
	r = ''
	tabidx = 1200
	images = image_list( date.strftime( '%Y%m%d' ) )
	if images.length > 0 then
		case @conf.style.sub( /^blog/i, '' )
                when /^wiki|markdown$/i
			ptag1 = "{{"
			ptag2 = "}}"
		when /^rd$/i
			ptag1 = "((%"
			ptag2 = "%))"
		else
			ptag1 = "&lt;%="
			ptag2 = "%&gt;"
		end
	   r << %Q[<div class="form">
		<div class="caption">
		#{image_label_list_caption}
		</div>
		<form class="update" method="post" action="#{h @update}"><div>
		#{csrf_protection}
		<table>
		<tr>]
		tmp = ''
	   images.each_with_index do |img,id|
			next unless img
			if @conf.secure then
				img_type, img_w, img_h = 'jpg', nil, nil
			else
				img_type, img_w, img_h = open(File.join(@image_dir,img).untaint, 'r') {|f| image_info(f)}
			end
			r << %Q[<td><img class="form" src="#{h @image_url}/#{h img}" alt="#{h id}" width="#{h( (img_w && img_w > 160) ? 160 : (img_w ? img_w : 160) )}"></td>]
			ptag = "#{ptag1}image #{id}, '#{image_label_description}', nil, #{img_w && img_h ? '['+img_w.to_s+','+img_h.to_s+']' : 'nil'}#{ptag2}"
			if @conf.secure then
				img_info = ''
			else
				img_info = "#{File.size(File.join(@image_dir,img).untaint).to_s.reverse.gsub( /\d{3}/, '\0,' ).sub( /,$/, '' ).reverse} bytes"
			end
			if img_type && img_w && img_h
				img_info << "<br>#{img_w} x #{img_h} (#{img_type})"
			end
			tmp << %Q[<td>
			#{img_info}<br>
			<input type="checkbox" tabindex="#{tabidx+id*2}" name="plugin_image_id" value="#{h id}">#{id}
			<input type="button" tabindex="#{tabidx+id*2+1}" onclick="insertImage(&quot;#{ptag}&quot;)" value="#{image_label_add_plugin}">
			</td>]
	   end
		r << "</tr><tr>"
		r << tmp
	   r << %Q[</tr>
		</table>
		<input type="hidden" name="plugin_image_delimage" value="true">
	   <input type="hidden" name="date" value="#{date.strftime( '%Y%m%d' )}">
	   <input type="submit" tabindex="#{tabidx+97}" name="plugin" value="#{image_label_delete}">
	   </div></form>
		</div>]
	end

   r << %Q[<div class="form">
	<div class="caption">
	#{image_label_add_caption}
	</div>]
	if @image_message then
		r << %Q[<p class="message">#{@image_message}</p>]
	end
   r << %Q[<form class="update" method="post" enctype="multipart/form-data" action="#{h @update}"><div>
	#{@conf.secure ? image_label_only_jpeg : ''}
	#{csrf_protection}
   <input type="hidden" name="plugin_image_addimage" value="true">
   <input type="hidden" name="date" value="#{date.strftime( '%Y%m%d' )}">
   <input type="file" tabindex="#{tabidx+98}" name="plugin_image_file" size="50">
   <input type="submit" tabindex="#{tabidx+99}" name="plugin" value="#{h image_label_add_image}">
   </div></form>
	</div>]
end

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
