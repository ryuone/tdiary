#
# 00default.rb: default plugins 
# $Revision: 1.19 $
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
	result << %Q[<span class="adminmenu"><a href="#{@index_page}">#{navi_index}</a></span>\n] unless @index_page.empty?
	if /^(day|comment)$/ === @mode
		years = []
		@years.each do |k, v|
			v.each do |m|
				years << k + m
			end
		end
		this_month = @date.strftime('%Y%m')
		years |= [this_month]
		years.sort!
		years.unshift(nil).push(nil)
		prev_month, dummy, next_month = years[years.index(this_month) - 1, 3]

		days = []
		today = @date.strftime('%Y%m%d')
		days += @diaries.keys
		days |= [today]

		days.sort!
		days.unshift(nil).push(nil)
		prev_day, dymmy, next_day = days[days.index(today) - 1, 3]
		if prev_day
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor prev_day}">&laquo;#{navi_prev_diary Time::local(*prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}</a></span>\n]
		else
			if prev_month
				y, m = prev_month.scan(/(\d{4})(\d\d)/)[0]
				if m == "12"
					y, m = y.to_i + 1, 1
				else
					y, m = y.to_i, m.to_i + 1
				end
				pday = Time.local(y, m, 1) - 24*60*60
				result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor pday.strftime('%Y%m%d')}">&laquo;#{navi_prev_diary pday}</a></span>\n]
			end
		end

		result << %Q[<span class="adminmenu"><a href="#{@index}">#{navi_latest}</a></span>\n] unless @mode == 'latest'

		if next_day
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor next_day}">#{navi_next_diary Time::local(*next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}&raquo;</a></span>\n]
		else
			if next_month
				y, m = next_month.scan(/(\d{4})(\d\d)/)[0]
				nday = Time.local(y, m, 1)
				result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor nday.strftime('%Y%m%d')}">#{navi_next_diary nday}&raquo;</a></span>\n]
			end
		end
	else
		result << %Q[<span class="adminmenu"><a href="#{@index}">#{navi_latest}</a></span>\n] unless @mode == 'latest'
	end
	result
end

def navi_admin
	result = %Q[<span class="adminmenu"><a href="#{@update}">#{navi_update}</a></span>\n]
	result << %Q[<span class="adminmenu"><a href="#{@update}?conf=OK">#{navi_preference}</a></span>\n] if /^(latest|month|day|comment|conf)$/ !~ @mode
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
		%Q[<p class="message">#$! (#{$!.class})<br>cannot read #{file}.</p>]
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
	<meta http-equiv="Content-Type" content="text/html; charset=#{charset}">
	<meta name="generator" content="tDiary #{TDIARY_VERSION}">
	#{author_name_tag}
	#{author_mail_tag}
	#{index_page_tag}
	#{css_tag.chomp}
	#{title_tag.chomp}
	HEADER
end

def charset
	@conf.charset( @conf.mobile_agent? )
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
	when 'nyear'
		years = @diaries.keys.map {|ymd| ymd.sub(/^\d{4}/, "")}
		r << "(#{@date.strftime('%m-%d')}[#{nyear_diary_label @date, years})" if @date
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
def my( a, str, title = nil )
	if title then
		%Q[<a href="#{@index}#{anchor a}" title="#{title}">#{str}</a>]
	else
		%Q[<a href="#{@index}#{anchor a}">#{str}</a>]
	end
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
# other resources
#
def html_lang
	"ja-JP"
end

def submit_command
	if @mode == 'form' then
		'append'
	else
		'replace'
	end
end

#
# nyear
#
def nyear(ymd)
	y, m, d = ymd.scan(/^(\d{4})(\d\d)(\d\d)$/)[0]
	date = Time.local(y, m, d)
	years = @years.find_all {|year, months| months.include? m}
	if @mode != 'nyear' and years.length >= 2
		%Q|[<a href="#{@index}#{anchor m + d}" title="#{nyear_diary_title date, years}">#{nyear_diary_label date, years}</a>]|
	else
		""
	end
end

#
# labels (normal)
#
def no_diary; "#{@date.strftime( @conf.date_format )}�������Ϥ���ޤ���"; end
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

def navi_index; '�ȥå�'; end
def navi_latest; '�ǿ�'; end
def navi_update; "����"; end
def navi_preference; "����"; end
def navi_prev_diary(date); "��������(#{date.strftime(@date_format)})"; end
def navi_next_diary(date); "��������(#{date.strftime(@date_format)})"; end

def submit_label
	if @mode == 'form' then
		'�ɲ�'
	else
		'��Ͽ'
	end
end
def label_update_complete; '[������λ]'; end
def label_reedit; ' ���Խ� '; end
def label_hidden_diary; '�������������ϸ��ߡ���ɽ���ۤˤʤäƤ��ޤ���'; end

def label_no_referer; '��󥯸���Ͽ�����ꥹ��'; end
def label_referer_table; '����ִ��ꥹ��'; end

def nyear_diary_label(date, years); "Ĺǯ����"; end
def nyear_diary_title(date, years); "Ĺǯ����"; end

#
# labels (for mobile)
#
def mobile_navi_latest; '�ǿ�'; end
def mobile_navi_update; "����"; end
def mobile_navi_preference; "����"; end
def mobile_navi_prev_diary; "����"; end
def mobile_navi_next_diary; "����"; end
def mobile_label_hidden_diary; '�������ϡ���ɽ���ۤǤ�'; end
