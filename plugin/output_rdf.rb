#
# output_rdf: RDF�ե���������plugin
#
# ����
#
# 1. output_rdf.rb
# 2. uconv <http://www.yoshidam.net/Ruby.html#uconv>
#    uconv�����Ĥ���ʤ�����EUC-JP��RDF���Ǥ��Ф��ޤ�
#
# Ĵ��ˡ
#
# 1.
#  tdiary.rb �Τ���ǥ��쥯�ȥ��web�����С�����񤭹��ߤǤ���褦�ˤ��뤫
#  tdiary.rb �Τ���ǥ��쥯�ȥ�� index.rdf �Ȥ����ե������web�����С�����
#  �񤭹��ߤ��Ǥ���ѡ��ߥå����Ǻ������Ƥ�������
#
#  �ʤ���index.rdf�ϡ�@options['output_rdf.file']�ˤ�äƥե�����̾����
#  ����ǽ�Ǥ�
#
# 2.
#  ˺�줺�� output_rdf.rb �� plugin �� �ۥ��ꥳ��Ǥ�������
#
# 3.
#  ������񤤤Ƥ�������
#
# 4.
#  rdf�������֥饦�������� http://������URL/index.rdf �˥����������Ƥ�������
#  
# 5.
#  �ʤ󤫤ǤƤ�����OK�Ǥ��������餯��
#
# Copyright (c) 2003 Hiroyuki Ikezoe <zoe@kasumi.sakura.ne.jp>
# Distributed under the GPL
#

=begin ChangeLog
2003-09-25 TADA Tadashi
	* use @conf.shorten.

2003-08-24 Junichiro Kita <kita@kitaj.no-ip.com>
	* use @date

2003-08-05  Kazuhiko  <kazuhiko@fdiary.net>
	* make rdf when receiving TrackBack Ping

2003-04-28 TADA Tadashi <sho@spc.gr.jp>
	* enable running on secure mode.
	* support non UTF-8 when cannot load uconv.

2003-03-03 Hiroyuki Ikezoe <zoe@kasumi.sakura.ne.jp>
	* validate by RSS 1.0 <http://www.redland.opensource.ac.uk/rss/>
	  Thanks Kakutani san. (see http://www.tdiary.net/archive/devel/msg00581.html)
	
2003-01-27 Hiroyuki Ikezoe <zoe@kasumi.sakura.ne.jp>
	* reorder apply_plugin.
	
2003-01-21 Hiroyuki Ikezoe <zoe@kasumi.sakura.ne.jp>
	* no requirement of diary.rrdf.
	* rss version 1.0.
	
2003-01-11 Hiroyuki Ikezoe <zoe@kasumi.sakura.ne.jp>
	* use Plugin#apply_plugin.
	* compatible defaultio
=end

begin
	require 'uconv'
	rdf_encode = 'UTF-8'
	rdf_encoder = Proc::new {|s| Uconv.euctou8( s ) }
rescue LoadError
	rdf_encode = charset
	rdf_encoder = Proc::new {|s| s }
end

if ( /^(append|replace|trackbackreceive)$/ =~ @mode ) || ( /^comment$/ =~ @mode and @comment ) then
	date = @date.strftime("%Y%m%d")
	diary = @diaries[date]
	host = ENV['HTTP_HOST'] 
	path = ENV['REQUEST_URI']
	path = path[0..path.rindex( "/" )]
	uri = "#{host}#{path}#{@index}".gsub( /\/\.?\//, '/' )
	rdf_file = @options['output_rdf.file'] || 'index.rdf'
	rdf_channel_about = "#{host}#{path}#{rdf_file}"
	r = ""
	r <<<<-RDF
<?xml version="1.0" encoding="#{rdf_encode}"?>
<rdf:RDF 
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xml:lang="ja"
>
 <channel rdf:about="http://#{rdf_channel_about}">
   <title>#{@html_title}</title>
   <link>http://#{uri}</link>
   <description>#{@html_title}</description>
   <dc:date>#{Time.now.strftime('%Y-%m-%dT%H:%M')}</dc:date>
   <items>
     <rdf:Seq>
	RDF
	idx = 1
 	diary.each_section do |section|
		if section.subtitle then
		r <<<<-RDF
       <rdf:li rdf:resource="http://#{uri}#{anchor "#{date}\#p#{'%02d' % idx}"}" />
 		RDF
		end
  		idx += 1
	end

	comment_link = ""
	if diary.count_comments > 0 then
  		diary.each_visible_comment( 100 ) do |comment,idx|
			comment_link = %Q[http://#{uri}#{anchor "#{date}\#c#{'%02d' % idx}"}]
			r <<<<-RDF
       <rdf:li rdf:resource="#{comment_link}" />
			RDF
		end
 	end
	r <<<<-RDF
     </rdf:Seq>
   </items>
 </channel>
	RDF
 	idx = 1
 	diary.each_section do |section|
		if section.subtitle then
		link = %Q[http://#{uri}#{anchor "#{date}\#p#{'%02d' % idx}"}]
		subtitle = diary.class.new(date, '', section.subtitle).to_html({})
		desc = diary.class.new(date, '', section.body).to_html({})
		old_apply_plugin = @options['apply_plugin']
		@options['apply_plugin'] = true
		subtitle = apply_plugin(subtitle, true).strip
		desc = apply_plugin(desc, true).strip
		@options['apply_plugin'] = old_apply_plugin
		desc = @conf.shorten( desc )
		r <<<<-RDF
 <item rdf:about="#{link}">
   <title>#{CGI::escapeHTML( subtitle )}</title>
   <link>#{link}</link>
   <description>#{CGI::escapeHTML( desc )}</description>
 </item>
 		RDF
		end
  		idx += 1
	end
	if diary.count_comments > 0 then
  		diary.each_visible_comment( 100 ) do |comment,idx|
			link = "http://#{uri}#{anchor "#{date}\#c#{'%02d' % idx}"}"	
		r <<<<-RDF
 <item rdf:about="#{link}">
   <title>#{comment_today}-#{idx} (#{CGI::escapeHTML( comment.name )})</title>
   <link>#{link}</link>
   <description>#{CGI::escapeHTML( @conf.shorten( comment.body ) )}</description>
   <dc:date>#{comment.date.strftime('%Y-%m-%dT%H:%M')}</dc:date>
 </item>
			RDF
		end
 	end
	r << "</rdf:RDF>"
	r = rdf_encoder.call( r )
	File::open( rdf_file, 'w' ) do |o|
		o.puts r
	end
end
