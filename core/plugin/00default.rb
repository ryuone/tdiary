#
# 00default.rb: default plugins 
# $Revision: 1.9 $
#

#
# make navigation buttons
#
def navi
	result = %Q[<div class="adminmenu">\n]
	result << navi_user
	result << navi_admin
	result << %Q[</div>]
end

def navi_user
	result = ''
	result << %Q[<span class="adminmenu"><a href="#{@index_page}">�ȥå�</a></span>\n] unless @index_page.empty?
	result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor( (@date-24*60*60).strftime( '%Y%m%d' ) )}">&lt;����</a></span>\n] if /^(day|comment)$/ =~ @mode
	result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor( (@date+24*60*60).strftime( '%Y%m%d' ) )}">����&gt;</a></span>\n] if /^(day|comment)$/ =~ @mode
	result << %Q[<span class="adminmenu"><a href="#{@index}">�ǿ�</a></span>\n] unless @mode == 'latest'
	result
end

def navi_admin
	result = %Q[<span class="adminmenu"><a href="#{@update}">����</a></span>\n]
	result << %Q[<span class="adminmenu"><a href="#{@update}?conf=OK">����</a></span>\n] if /^(latest|month|day|comment|conf)$/ !~ @mode
	result
end

#
# make calendar
#
def calendar
	result = %Q[<div class="calendar">\n]
	@years.keys.sort.each do |year|
		result << %Q[<div class="year">#{year}|]
		@years[year.to_s].sort.each do |month|
			m = "#{year}#{month}"
			result << %Q[<a href="#{@index}#{anchor m}">#{month}</a>|]
		end
		result << "</div>\n"
	end
	result << "</div>"
end

#
# insert file. only enable unless @secure.
#
def insert( file )
	begin
		File::readlines( file ).join
	rescue
		%Q[<p class="message">#$! (#{$!.type})<br>cannot read #{file}.</p>]
	end
end

#
# define DOCTYPE
#
def doctype
	%Q[<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">]
end

#
# default HTML header
#
add_header_proc do
	<<-HEADER
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-JP">
	<meta name="generator" content="tDiary #{TDIARY_VERSION}">
	#{author_name_tag}
	#{author_mail_tag}
	#{index_page_tag}
	#{css_tag.chomp}
	#{title_tag.chomp}
	HEADER
end

def author_name_tag
	if @author_name then
		%Q[<meta name="Author" content="#{@author_name}">]
	else
		''
	end
end

def author_mail_tag
	if @author_mail then
		%Q[<link rev="MADE" href="mailto:#{@author_mail}">]
	else
		''
	end
end

def index_page_tag
	if @index_page and @index_page.size > 0 then
		%Q[<link rel="INDEX" href="#{@index_page}">]
	else
		''
	end
end

def theme_url; 'theme'; end

def css_tag
	if @theme and @theme.length > 0 then
		css = "#{theme_url}/#{@theme}/#{@theme}.css"
	else
		css = @css
	end
	<<-CSS
	<meta http-equiv="content-style-type" content="text/css">
	<link rel="stylesheet" href="#{css}" type="text/css" media="all">
	CSS
end

def title_tag
	r = "<title>#{@html_title}"
	case @mode
	when 'day', 'comment'
		r << "(#{@date.strftime( '%Y-%m-%d' )})" if @date
	when 'month'
		r << "(#{@date.strftime( '%Y-%m' )})" if @date
	when 'form'
		r << '(����)'
	when 'append', 'replace'
		r << '(������λ)'
	when 'showcomment'
		r << '(�ѹ���λ)'
	when 'conf'
		r << '(����)'
	when 'saveconf'
		r << '(���괰λ)'
	end
	r << '</title>'
end

#
# make anchor string
#
def anchor( s )
	if /^(\d+)#?([pc]\d*)?$/ =~ s then
		if $2 then
			"?date=#$1##$2"
		else
			"?date=#$1"
		end
	else
		""
	end
end

#
# make anchor tag in my diary
#
def my( a, str )
	%Q[<a href="#{@index}#{anchor a}">#{str}</a>]
end

#
# referer of today
#
def referer_of_today_short( diary, limit )
	return '' if not diary or diary.count_referers == 0
	result = %Q[#{referer_today} | ]
	diary.each_referer( limit ) do |count,ref|
		result << %Q[<a href="#{CGI::escapeHTML( ref )}" title="#{CGI::escapeHTML( diary.disp_referer( @referer_table, ref ) )}">#{count}</a> | ]
	end
	result
end

def referer_of_today_long( diary, limit )
	return '' if not diary or diary.count_referers == 0
	result = %Q[<div class="caption">#{referer_today}</div>\n]
	result << %Q[<ul>\n]
	diary.each_referer( limit ) do |count,ref|
		result << %Q[<li>#{count} <a href="#{CGI::escapeHTML( ref )}">#{CGI::escapeHTML( diary.disp_referer( @referer_table, ref ) )}</a></li>\n]
	end
	result + '</ul>'
end

#
# labels
#
def comment_today; '�����Υĥå���'; end
def comment_total( total ); "(��#{total}��)"; end
def comment_new; '�ĥå��ߤ������'; end
def comment_description; '�ĥå��ߡ������Ȥ�����Фɤ���! E-mail���ɥ쥹�ϸ�������ޤ���'; end
def comment_description_short; '�ĥå���!!'; end
def comment_name_label; '��̾��'; end
def comment_name_label_short; '̾��'; end
def comment_mail_label; 'E-mail'; end
def comment_mail_label_short; 'Mail'; end
def comment_body_label; '������'; end
def comment_body_label_short; '��ʸ'; end
def comment_submit_label; '���'; end
def comment_submit_label_short; '���'; end
def comment_date( time ); time.strftime( "(#{@date_format} %H:%M)" ); end
def referer_today; '�����Υ�󥯸�'; end

def submit_command
	if @mode == 'form' then
		'append'
	else
		'replace'
	end
end
def submit_label
	if @mode == 'form' then
		'�ɲ�'
	else
		'��Ͽ'
	end
end

