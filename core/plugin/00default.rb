#
# 00default.rb: default plugins 
# $Revision: 1.48 $
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
	if @mode == 'day' then
		if @prev_day then
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor @prev_day}">&laquo;#{navi_prev_diary Time::local(*@prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}</a></span>\n]
		end

		result << %Q[<span class="adminmenu"><a href="#{@index}">#{navi_latest}</a></span>\n] unless @mode == 'latest'

		if @next_day
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor @next_day}">#{navi_next_diary Time::local(*@next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}&raquo;</a></span>\n]
		end
	elsif @mode == 'nyear'
		result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor @prev_day[4,4]}">&laquo;#{navi_prev_nyear Time::local(*@prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}</a></span>\n] if @prev_day
		result << %Q[<span class="adminmenu"><a href="#{@index}">#{navi_latest}</a></span>\n] unless @mode == 'latest'
		result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor @next_day[4,4]}">#{navi_next_nyear Time::local(*@next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}&raquo;</a></span>\n] if @next_day
	else
		result << %Q[<span class="adminmenu"><a href="#{@index}">#{navi_latest}</a></span>\n] unless @mode == 'latest'
	end
	result
end

def navi_admin
	if @mode == 'day' then
		result = %Q[<span class="adminmenu"><a href="#{@update}?edit=true;year=#{@date.year};month=#{@date.month};day=#{@date.day}">#{navi_edit}</a></span>\n]
	else
		result = %Q[<span class="adminmenu"><a href="#{@update}">#{navi_update}</a></span>\n]
	end
	result << %Q[<span class="adminmenu"><a href="#{@update}?conf=default">#{navi_preference}</a></span>\n] if /^(latest|month|day|comment|conf|nyear|category.*)$/ !~ @mode
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
	calc_links
	<<-HEADER
	<meta http-equiv="Content-Type" content="text/html; charset=#{charset}">
	<meta name="generator" content="tDiary #{TDIARY_VERSION}">
	#{content_script_type}
	#{author_name_tag}
	#{author_mail_tag}
	#{index_page_tag}
	#{css_tag.chomp}
	#{title_tag.chomp}
	HEADER
end

def calc_links
	if @mode == 'day' then
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

		days.index( today ).times do |i|
			@prev_day = days[days.index( today ) - i - 1]
			break unless @prev_day
			break if @diaries[@prev_day].visible?
		end
		if not @prev_day and prev_month then
			y, m = prev_month.scan(/(\d{4})(\d\d)/)[0]
			if m == "12"
				y, m = y.to_i + 1, 1
			else
				y, m = y.to_i, m.to_i + 1
			end
			@prev_day = (Time.local(y, m, 1) - 24*60*60).strftime( '%Y%m%d' )
		end

		days.index( today ).times do |i|
			@next_day = days[days.index( today ) + i + 1]
			break unless @next_day
			break if @diaries[@next_day].visible?
		end
		if not @next_day and next_month then
			y, m = next_month.scan(/(\d{4})(\d\d)/)[0]
			@next_day = Time.local(y, m, 1).strftime( '%Y%m%d' )
		end
	elsif @mode == 'nyear'
		y = 2000 # specify leam year
		m, d = @cgi.params['date'][0].scan(/^(\d\d)(\d\d)$/)[0]
		@prev_day = (Time.local(y, m, d) - 24*60*60).strftime( '%Y%m%d' )
		@next_day = (Time.local(y, m, d) + 24*60*60).strftime( '%Y%m%d' )
	end
end

def charset
	@conf.charset( @conf.mobile_agent? )
end

def content_script_type
	%Q[<meta http-equiv="Content-Script-Type" content="text/javascript; charset=#{charset}">]
end

def author_name_tag
	if @author_name then
		%Q[<meta name="author" content="#{@author_name}">]
	else
		''
	end
end

def author_mail_tag
	if @author_mail then
		%Q[<link rev="made" href="mailto:#{@author_mail}">]
	else
		''
	end
end

def index_page_tag
	result = ''
	if @index_page and @index_page.size > 0 then
		result << %Q[<link rel="start" title="#{navi_index}" href="#{@index_page}">\n\t]
	end
	oldest = @years.keys.sort[0]
	if oldest then
		result << %Q[<link rel="first" title="#{navi_oldest}" href="#{@index}#{anchor( oldest + @years[oldest][0])}">\n\t]
	end
	if @prev_day then
		case @mode
		when 'day'
			result << %Q[<link rel="prev" title="#{navi_prev_diary Time::local(*@prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}" href="#{@index}#{anchor @prev_day}">\n\t]
		when 'nyear'
			result << %Q[<link rel="prev" title="#{navi_prev_nyear Time::local(*@prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}" href="#{@index}#{anchor @prev_day[4,4]}">\n\t]
		end
	end
	if @next_day then
		case @mode
		when 'day'
			result << %Q[<link rel="next" title="#{navi_next_diary Time::local(*@next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}" href="#{@index}#{anchor @next_day}">\n\t]
		when 'nyear'
			result << %Q[<link rel="next" title="#{navi_next_nyear Time::local(*@next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}" href="#{@index}#{anchor @next_day[4,4]}">\n\t]
		end
	end
	result << %Q[<link rel="last" title="#{navi_latest}" href="#{@index}">\n\t]
	result.chop.chop
end

def theme_url; 'theme'; end

def css_tag
	if @theme and @theme.length > 0 then
		css = "#{theme_url}/#{@theme}/#{@theme}.css"
		title = css
	else
		css = @css
	end
	title = CGI::escapeHTML( File::basename( css, '.css' ) )
	<<-CSS
<meta http-equiv="content-style-type" content="text/css">
	<link rel="stylesheet" href="#{theme_url}/base.css" type="text/css" media="all">
	<link rel="stylesheet" href="#{css}" title="#{title}" type="text/css" media="all">
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
		r << '(�ɵ�)'
	when 'edit'
		r << '(�Խ�)'
	when 'preview'
		r << '(�ץ�ӥ塼)'
	when 'showcomment'
		r << '(�ѹ���λ)'
	when 'conf'
		r << '(����)'
	when 'saveconf'
		r << '(���괰λ)'
	when 'nyear'
		years = @diaries.keys.map {|ymd| ymd.sub(/^\d{4}/, "")}
		r << "(#{@cgi.params['date'][0].sub( /^(\d\d)/, '\1-')}[#{nyear_diary_label @date, years}])" if @date
	end
	r << '</title>'
end

#
# make anchor string
#
def anchor( s )
	if /^(\d+)#?([pct]\d*)?$/ =~ s then
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
	if @mode == 'form' or @cgi.valid?( 'appendpreview' ) then
		'append'
	else
		'replace'
	end
end

def preview_command
	if @mode == 'form' or @cgi.valid?( 'appendpreview' ) then
		'appendpreview'
	else
		'replacepreview'
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
# service methods for comment_mail
#
def comment_mail_send
	return unless @comment
	return unless @conf['comment_mail.enable']

	case @conf['comment_mail.receivers']
	when Array
		# for compatibility
		receivers = @conf['comment_mail.receivers']
	when String
		receivers = @conf['comment_mail.receivers'].split( /[, ]+/ )
	end
	receivers = [@conf.author_mail] if receivers.compact.empty?
	return if receivers.empty?

	require 'socket'

	name = comment_mail_mime( @comment.name.to_jis )[0]
	body = @comment.body.sub( /[\r\n]+\Z/, '' ).to_jis
	mail = @comment.mail
	mail = @conf.author_mail unless mail =~ %r<[0-9a-zA-Z_.-]+@[\(\)%!0-9a-zA-Z_$@.&+-,'"*-]+>
	
	now = Time::now
	g = now.dup.gmtime
	l = Time::local( g.year, g.month, g.day, g.hour, g.min, g.sec )
	tz = (g.to_i - l.to_i) / 36
	date = now.strftime( "%a, %d %b %Y %X " ) + sprintf( "%+05d", tz )

	serial = @diaries[@date.strftime( '%Y%m%d' )].count_comments( true )
	message_id = %Q!<tdiary.#{[@conf['comment_mail.header'] || ''].pack('m').gsub(/\n/,'')}.#{now.strftime('%Y%m%d%H%M%S')}.#{serial}@#{Socket::gethostname.sub(/^.+?\./,'')}>!

	mail_header = (@conf['comment_mail.header'] || '').dup
	mail_header << ":#{@conf.date_format}" unless /%[a-zA-Z%]/ =~ mail_header
	mail_header = @date.strftime( mail_header )
	mail_header = comment_mail_mime( mail_header.to_jis ).join( "\n " ) if /[\x80-\xff]/ =~ mail_header

	rmail = ''
	begin
		if @conf.lang then
			rmail = File::open( "#{TDiary::PATH}/skel/mail.rtxt.#{@conf.lang}" ){|f| f.read }
		else
			rmail = File::open( "#{TDiary::PATH}/skel/mail.rtxt" ){|f| f.read }
		end
	rescue
		rmail = File::open( "#{TDiary::PATH}/skel/mail.rtxt" ){|f| f.read }
	end
	text = ERbLight::new( rmail.untaint ).result( binding )
	comment_mail( text, receivers )
end

def comment_mail_mime( str )
	require 'nkf'
	NKF::nkf( "-j -m0 -f50", str ).collect do |s|
		%Q|=?ISO-2022-JP?B?#{[s.chomp].pack( 'm' ).gsub( /\n/, '' )}?=|
	end
end

def comment_mail( text )
	# no action in default.
	# override by each plugins.
end

def comment_mail_conf_label; '�ĥå��ߥ᡼��'; end

def comment_mail_basic_setting
	if @mode == 'saveconf' then
		@conf['comment_mail.enable'] = @cgi.params['comment_mail.enable'][0] == 'true' ? true : false
		@conf['comment_mail.receivers'] = @cgi.params['comment_mail.receivers'][0].strip.gsub( /[\n\r]+/, ',' )
		@conf['comment_mail.header'] = @cgi.params['comment_mail.header'][0]
	end
end

def comment_mail_basic_html
	@conf['comment_mail.header'] = '' unless @conf['comment_mail.header']
	@conf['comment_mail.receivers'] = '' unless @conf['comment_mail.receivers']

	<<-HTML
	<h3 class="subtitle">�ĥå��ߥ᡼�������</h3>
	#{"<p>�ĥå��ߤ����ä����ˡ��᡼������뤫�ɤ��������򤷤ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="comment_mail.enable">
		<option value="true"#{if @conf['comment_mail.enable'] then " selected" end}>����</option>
        <option value="false"#{if not @conf['comment_mail.enable'] then " selected" end}>����ʤ�</option>
	</select></p>
	<h3 class="subtitle">������</h3>
	#{"<p>�᡼������������ꤷ�ޤ���1�Ԥ�1�᡼�륢�ɥ쥹�η��ǡ�ʣ�������ǽ�Ǥ�������Τʤ����ˤϡ����ʤ��Υ᡼�륢�ɥ쥹�������ޤ���</p>" unless @conf.mobile_agent?}
	<p><textarea name="comment_mail.receivers" cols="40" rows="3">#{CGI::escapeHTML( @conf['comment_mail.receivers'].gsub( /[, ]+/, "\n") )}</textarea></p>
	<h3 class="subtitle">�᡼��إå�</h3>
	#{"<p>�᡼���Subject�ˤĤ���إå�ʸ�������ꤷ�ޤ�������ʬ�����������ʤ褦�˻��ꤷ�ޤ����ºݤ�Subject�ˤϡֻ���ʸ����:����-1�פΤ褦�ˡ����դȥ������ֹ椬�դ��ޤ�������������ʸ������ˡ�%��³���ѻ������ä���硢��������եե����ޥåȻ���򸫤ʤ��ޤ����Ĥޤ�����աפ���ʬ�ϼ�ưŪ���ղä���ʤ��ʤ�ޤ�(�������ֹ���ղä���ޤ�)��</p>" unless @conf.mobile_agent?}
	<p><input name="comment_mail.header" value="#{CGI::escapeHTML( @conf['comment_mail.header'])}"></p>
	HTML
end

#
# detect bot from User-Agent
#
bot = ["googlebot", "Hatena Antenna", "moget@goo.ne.jp"]
bot += @conf['bot'] || []
@bot = Regexp::new( "(#{bot.join( '|' )})" )

def bot?
	@bot =~ @cgi.user_agent
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
def navi_oldest; '�Ǹ�'; end
def navi_update; "�ɵ�"; end
def navi_edit; "�Խ�"; end
def navi_preference; "����"; end
def navi_prev_diary(date); "��������(#{date.strftime(@date_format)})"; end
def navi_next_diary(date); "��������(#{date.strftime(@date_format)})"; end
def navi_prev_nyear(date); "������(#{date.strftime('%m-%d')})"; end
def navi_next_nyear(date); "������(#{date.strftime('%m-%d')})"; end

def submit_label
	if @mode == 'form' or @cgi.valid?( 'appendpreview' ) then
		'�ɵ�'
	else
		'��Ͽ'
	end
end
def preview_label; '�ץ�ӥ塼'; end

def label_no_referer; '��󥯸���Ͽ�����ꥹ��'; end
def label_referer_table; '����ִ��ꥹ��'; end

def nyear_diary_label(date, years); "Ĺǯ����"; end
def nyear_diary_title(date, years); "Ĺǯ����"; end

#
# labels (for mobile)
#
def mobile_navi_latest; '�ǿ�'; end
def mobile_navi_update; "�ɵ�"; end
def mobile_navi_preference; "����"; end
def mobile_navi_prev_diary; "����"; end
def mobile_navi_next_diary; "����"; end
def mobile_label_hidden_diary; '�������ϡ���ɽ���ۤǤ�'; end

#
# category
#
def category_anchor(c); "[#{c}]"; end
def category_title; "���ƥ�����"; end
def category_title_year(year); "#{year}ǯ"; end
def category_title_month(year, month); "#{year}ǯ#{month}��"; end
def category_title_quarter(year, q); "#{year}ǯ#{q}Q"; end
def category_title_latest; "����"; end

#
# preferences
#

# basic (default)
def saveconf_default
	if @mode == 'saveconf' then
		@conf.author_name = @cgi.params['author_name'][0].to_euc
		@conf.author_mail = @cgi.params['author_mail'][0]
		@conf.index_page = @cgi.params['index_page'][0]
		@conf.hour_offset = @cgi.params['hour_offset'][0].to_f
	end
end

add_conf_proc( 'default', '����' ) do
	saveconf_default
	<<-HTML
	<h3 class="subtitle">����̾</h3>
	#{"<p>���ʤ���̾������ꤷ�ޤ���HTML�إå����Ÿ������ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="author_name" value="#{CGI::escapeHTML @conf.author_name}" size="40"></p>
	<h3 class="subtitle">�᡼�륢�ɥ쥹</h3>
	#{"<p>���ʤ��Υ᡼�륢�ɥ쥹����ꤷ�ޤ���HTML�إå����Ÿ������ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="author_mail" value="#{@conf.author_mail}" size="40"></p>
	<h3 class="subtitle">�ȥåץڡ���URL</h3>
	#{"<p>���������̤Υ���ƥ�Ĥ�����л��ꤷ�ޤ���¸�ߤ��ʤ����ϲ������Ϥ��ʤ��Ƥ��ޤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="index_page" value="#{@conf.index_page}" size="50"></p>
	<h3 class="subtitle">����Ĵ��</h3>
	#{"<p>���������ե������������������դ����ñ�̤�Ĵ���Ǥ��ޤ����㤨�и���2���ޤǤ������Ȥ��ư����������ˤϡ�-2�פΤ褦�˻��ꤹ�뤳�Ȥǡ�2����ʬ�����줿���դ����������褦�ˤʤ�ޤ����ޤ����������դ�Web�����о�λ���ˤʤäƤ���Τǡ������Υ����ФǱ��Ĥ��Ƥ�����λ���Ĵ���ˤ����ѤǤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="hour_offset" value="#{@conf.hour_offset}" size="5"></p>
	HTML
end

# header/footer (header)
def saveconf_header
	if @mode == 'saveconf' then
		@conf.html_title = @cgi.params['html_title'][0].to_euc
		@conf.header = @cgi.params['header'][0].to_euc.gsub( /\r\n/, "\n" ).gsub( /\r/, '' ).sub( /\n+\z/, '' )
		@conf.footer = @cgi.params['footer'][0].to_euc.gsub( /\r\n/, "\n" ).gsub( /\r/, '' ).sub( /\n+\z/, '' )
	end
end

add_conf_proc( 'header', '�إå����եå�' ) do
	saveconf_header

	<<-HTML
	<h3 class="subtitle">�����ȥ�</h3>
	#{"<p>HTML��&lt;title&gt;�����椪��ӡ���Х���ü������λ��Ȼ��˻Ȥ��륿���ȥ�Ǥ���HTML�����ϻȤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="html_title" value="#{ CGI::escapeHTML @conf.html_title }" size="50"></p>
	<h3 class="subtitle">�إå�</h3>
	#{"<p>��������Ƭ�����������ʸ�Ϥ���ꤷ�ޤ���HTML�������Ȥ��ޤ�����&lt;%=navi%&gt;�פǡ��ʥӥ��������ܥ���������Ǥ��ޤ�(���줬�ʤ��ȹ������Ǥ��ʤ��ʤ�ΤǺ�����ʤ��褦�ˤ��Ƥ�������)���ޤ�����&lt;%=calendar%&gt;�פǥ��������������Ǥ��ޤ�������¾���Ƽ�ץ饰����򵭽ҤǤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><textarea name="header" cols="70" rows="10">#{ CGI::escapeHTML @conf.header }</textarea></p>
	<h3 class="subtitle">�եå�</h3>
	#{"<p>�����κǸ�����������ʸ�Ϥ���ꤷ�ޤ����إå���Ʊ�ͤ˻���Ǥ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><textarea name="footer" cols="70" rows="10">#{ CGI::escapeHTML @conf.footer }</textarea></p>
	HTML
end

# diaplay
def saveconf_display
	if @mode == 'saveconf' then
		@conf.section_anchor = @cgi.params['section_anchor'][0].to_euc
		@conf.comment_anchor = @cgi.params['comment_anchor'][0].to_euc
		@conf.date_format = @cgi.params['date_format'][0].to_euc
		@conf.latest_limit = @cgi.params['latest_limit'][0].to_i
		@conf.latest_limit = 10 if @conf.latest_limit < 1
		@conf.show_nyear = @cgi.params['show_nyear'][0] == 'true' ? true : false
	end
end

add_conf_proc( 'display', 'ɽ������' ) do
	saveconf_display

	<<-HTML
	<h3 class="subtitle">��������󥢥󥫡�</h3>
	#{"<p>�����Υ�����������Ƭ(���֥����ȥ�ι�Ƭ)����������롢����ѤΥ��󥫡�ʸ�������ꤷ�ޤ����ʤ���&lt;span class=\"sanchor\"&gt;_&lt;/span&gt;�פ���ꤹ��ȡ��ơ��ޤˤ�äƤϼ�ưŪ�˲������󥫡����Ĥ��褦�ˤʤ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="section_anchor" value="#{ CGI::escapeHTML @conf.section_anchor }" size="40"></p>
	<h3 class="subtitle">�ĥå��ߥ��󥫡�</h3>
	#{"<p>�ɼԤ���Υĥå��ߤ���Ƭ����������롢����ѤΥ��󥫡�ʸ�������ꤷ�ޤ����ʤ���&lt;span class=\"canchor\"&gt;_&lt;/span&gt;�פ���ꤹ��ȡ��ơ��ޤˤ�äƤϼ�ưŪ�˲������󥫡����Ĥ��褦�ˤʤ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="comment_anchor" value="#{ CGI::escapeHTML @conf.comment_anchor }" size="40"></p>
	<h3 class="subtitle">���եե����ޥå�</h3>
	#{"<p>���դ�ɽ����ʬ�˻Ȥ���ե����ޥåȤ���ꤷ�ޤ���Ǥ�դ�ʸ�����Ȥ��ޤ�������%�פǻϤޤ�ѻ��ˤϼ��Τ褦���ü�ʰ�̣������ޤ�����%Y��(����ǯ)����%m��(�����)����%b��(û��̾)����%B��(Ĺ��̾)����%d��(��)����%a��(û����̾)����%A��(Ĺ����̾)��</p>" unless @conf.mobile_agent?}
	<p><input name="date_format" value="#{ CGI::escapeHTML @conf.date_format }" size="30"></p>
	<h3 class="subtitle">�ǿ�ɽ���κ�������</h3>
	#{"<p>�ǿ���������ɽ������Ȥ��ˡ����Υڡ�����˲���ʬ��������ɽ�����뤫����ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p>����<input name="latest_limit" value="#{ @conf.latest_limit }" size="2">��ʬ</p>
	<h3 class="subtitle">Ĺǯ������ɽ��</h4>
	#{"<p>Ĺǯ������ɽ�����뤿��Υ�󥯤�ɽ�����뤫�ɤ�������ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="show_nyear">
		<option value="true"#{if @conf.show_nyear then " selected" end}>ɽ��</option>
        <option value="false"#{if not @conf.show_nyear then " selected" end}>��ɽ��</option>
	</select></p>
	HTML
end

# themes
def saveconf_theme
	if @mode == 'saveconf' then
		@conf.theme = @cgi.params['theme'][0]
		@conf.css = @cgi.params['css'][0]
	end
end

if @mode =~ /^(conf|saveconf)$/ then
	@conf_theme_list = []
	Dir::glob( "#{::TDiary::PATH}/theme/*" ).sort.each do |dir|
		theme = dir.sub( %r[.*/theme/], '')
		next unless FileTest::file?( "#{dir}/#{theme}.css".untaint )
		name = theme.split( /_/ ).collect{|s| s.capitalize}.join( ' ' )
		@conf_theme_list << [theme,name]
	end
end

add_conf_proc( 'theme', '�ơ���' ) do
	saveconf_theme

	 r = <<-HTML
	<h3 class="subtitle">�ơ��ޤλ���</h3>
	#{"<p>�����Υǥ������ơ��ޡ��⤷����CSS��ľ�����Ϥǻ��ꤷ�ޤ����ɥ�åץ������˥塼�����CSS���ꢪ�פ����򤷤����ˤϡ��������CSS��URL�����Ϥ��Ƥ���������</p>" unless @conf.mobile_agent?}
	<p>
	<select name="theme">
		<option value="">CSS���ꢪ</option>
	HTML
	@conf_theme_list.each do |theme|
		r << %Q|<option value="#{theme[0]}"#{if theme[0] == @conf.theme then " selected" end}>#{theme[1]}</option>|
	end
	r << <<-HTML
	</select>
	<input name="css" size="50" value="#{ @conf.css }">
	</p>
	#{"<p>�����ˤʤ��ơ��ޤ�<a href=\"http://www.tdiary.org/20021001.html\">�ơ��ޡ������꡼</a>��������Ǥ��ޤ���</p>" unless @conf.mobile_agent?}
	HTML
end

# comments
def saveconf_comment
	if @mode == 'saveconf' then
		@conf.show_comment = @cgi.params['show_comment'][0] == 'true' ? true : false
		@conf.comment_limit = @cgi.params['comment_limit'][0].to_i
		@conf.comment_limit = 3 if @conf.comment_limit < 1
	end
end

add_conf_proc( 'comment', '�ĥå���' ) do
	saveconf_comment

	<<-HTML
	<h3 class="subtitle">�ĥå��ߤ�ɽ��</h3>
	#{"<p>�ɼԤ���Υĥå��ߤ�ɽ�����뤫�ɤ�������ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="show_comment">
		<option value="true"#{if @conf.show_comment then " selected" end}>ɽ��</option>
		<option value="false"#{if not @conf.show_comment then " selected" end}>��ɽ��</option>
	</select></p>
	<h3 class="subtitle">�ĥå��ߥꥹ��ɽ����</h3>
	#{"<p>�ǿ��⤷���Ϸ���ɽ������ɽ�����롢�ĥå��ߤκ���������ꤷ�ޤ����ʤ�������ɽ�����ˤϤ����λ���ˤ�����餺���٤ƤΥĥå��ߤ�ɽ������ޤ���</p>" unless @conf.mobile_agent?}
	<p>����<input name="comment_limit" value="#{ @conf.comment_limit }" size="3">��</p>
	HTML
end

# referer
def saveconf_referer
	if @mode == 'saveconf' then
		@conf.show_referer = @cgi.params['show_referer'][0] == 'true' ? true : false
		@conf.referer_limit = @cgi.params['referer_limit'][0].to_i
		@conf.referer_limit = 10 if @conf.referer_limit < 1
		no_referer2 = []
		@cgi.params['no_referer'][0].to_euc.each do |ref|
			ref.strip!
			no_referer2 << ref if ref.length > 0
		end
		@conf.no_referer2 = no_referer2
		referer_table2 = []
		@cgi.params['referer_table'][0].to_euc.each do |pair|
			u, n = pair.sub( /[\r\n]+/, '' ).split( /[ \t]+/, 2 )
			referer_table2 << [u,n] if u and n
		end
		@conf.referer_table2 = referer_table2
	end
end

add_conf_proc( 'referer', '��󥯸�' ) do
	saveconf_referer

	<<-HTML
	<h3 class="subtitle">��󥯸���ɽ��</h3>
	#{"<p>��󥯸��ꥹ�Ȥ�ɽ�����뤫�ɤ�������ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="show_referer">
		<option value="true"#{if @conf.show_referer then " selected" end}>ɽ��</option>
		<option value="false"#{if not @conf.show_referer then " selected" end}>��ɽ��</option>
	</select></p>
	<h3 class="subtitle">��󥯸��ꥹ��ɽ����</h3>
	#{"<p>�ǿ��⤷���Ϸ���ɽ������ɽ�����롢��󥯸��ꥹ�Ȥκ���������ꤷ�ޤ����ʤ�������ɽ�����ˤϤ����λ���ˤ�����餺���٤ƤΥ�󥯸���ɽ������ޤ���</p>" unless @conf.mobile_agent?}
	<p>����<input name="referer_limit" value="#{@conf.referer_limit}" size="3">������</p>
	<h3 class="subtitle">��󥯸���Ͽ�����ꥹ��</h3>
	#{"<p>��󥯸��ꥹ�Ȥ��ɲä��ʤ�URL����ꤷ�ޤ�������ɽ���ǻ���Ǥ��ޤ���1��1�Ԥ����Ϥ��Ƥ���������</p>" unless @conf.mobile_agent?}
	<p>��<a href="#{@conf.update}?referer=no" target="referer">��¸����Ϥ�����</a></p>
	<p><textarea name="no_referer" cols="70" rows="10">#{@conf.no_referer2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">��󥯸��ִ��ꥹ��</h3>
	#{"<p>��󥯸��ꥹ�Ȥ�URL�������ʸ������Ѵ������б�ɽ�����Ǥ��ޤ���1��ˤĤ���URL��ɽ��ʸ��������Ƕ��ڤäƻ��ꤷ�ޤ�������ɽ�����Ȥ���Τǡ�URL��˸��줿��(��)�פϡ��ִ�ʸ������ǡ�\\1�פΤ褦�ʡ�\�����פ����ѤǤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p>��<a href="#{@conf.update}?referer=table" target="referer">��¸����Ϥ�����</a></p>
	<p><textarea name="referer_table" cols="70" rows="10">#{@conf.referer_table2.collect{|a|a.join( " " )}.join( "\n" )}</textarea></p>
	HTML
end

