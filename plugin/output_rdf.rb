#
# output_rdf: RDF�ե���������plugin
#
# ����
#
# 1. output_rdf.rb
# 2. uconv <http://www.yoshidam.net/Ruby.html#uconv>
#
# Ĵ��ˡ
#
# 1.
#  tdiary.rb �Τ���ǥ��쥯�ȥ��web�����С�����񤭹��ߤǤ���褦�ˤ��뤫
#  tdiary.rb �Τ���ǥ��쥯�ȥ�� t.rdf �Ȥ����ե������web�����С�����
#  �񤭹��ߤ��Ǥ���ѡ��ߥå����Ǻ������Ƥ�������
#
# 2.
#  ˺�줺�� output_rdf.rb �� plugin �� �ۥ��ꥳ��Ǥ�������
#
# 3.
#  ������񤤤Ƥ�������
#
# 4.
#  rdf�������֥饦�������� http://������URL/t.rdf �˥����������Ƥ�������
#  
# 5.
#  �ʤ󤫤ǤƤ�����OK�Ǥ��������餯��
#
# Copyright (c) 2003 Hiroyuki Ikezoe <zoe@kasumi.sakura.ne.jp>
# Distributed under the GPL

=begin ChangeLog
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
 
require 'uconv'

add_update_proc( Proc::new do
	if @mode == 'append' || @mode == 'replace' then
		date = sprintf( "%4d%02d%02d", @cgi.params['year'][0], @cgi.params['month'][0], @cgi.params['day'][0] )
	else
		date = @cgi.params['date'][0]
	end
	diary = @diaries[date]
	host  = ENV['HTTP_HOST'] 
	path  = ENV['REQUEST_URI']
   	path  = path[0..path.rindex("/")]
   	uri   = "#{host}#{path}#{@index}"
	rdf_file = 't.rdf'
	rdf_channel_about = "#{host}#{path}#{rdf_file}"
	r = ""
	r <<<<-RDF
<?xml version="1.0" encoding="UTF-8"?>
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
  		diary.each_comment_tail( 1 ) do |comment,idx|
		if comment.visible? then
		comment_link = %Q[http://#{uri}#{anchor "#{date}\#c#{'%02d' % idx}"}]
		r <<<<-RDF
       <rdf:li rdf:resource="#{comment_link}" />
		RDF
  		end
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
		r <<<<-RDF
 <item rdf:about="#{link}">
   <title>#{CGI::escapeHTML(apply_plugin(section.subtitle).gsub(/<.+?>/,'')).chomp}</title>
   <link>#{link}</link>
   <description>#{CGI::escapeHTML(shorten(apply_plugin(section.body)))}</description>
 </item>
 		RDF
		end
  		idx += 1
	end
	if diary.count_comments > 0 then
	   	r <<<<-RDF
 <item rdf:about="#{comment_link}">
   <title>#{comment_today}#{comment_total(diary.count_comments)}</title>
		RDF
  		diary.each_comment_tail( 1 ) do |comment,idx|
		if comment.visible? then
		link = "http://#{uri}#{anchor "#{date}\#c#{'%02d' % idx}"}"	
		r <<<<-RDF
   <link>#{comment_link}</link>
   <description>#{CGI::escapeHTML( comment.name )}[#{CGI::escapeHTML(shorten(comment.body))}]</description>
		RDF
  		end
		end
 	r << " </item>\n"
 	end
	r << "</rdf:RDF>"
	r = Uconv.euctou8(r)
	File::open( rdf_file, 'w' ) do |o|
		o.puts r
	end
end )
