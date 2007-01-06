#
# ja/00default.rb: Japanese resources of 00default.rb.
#
# Copyright (C) 2001-2005, TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#

#
# header
#
def title_tag
	r = "<title>#{h @html_title}"
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
		r << "(#{h @cgi.params['date'][0].sub( /^(\d\d)/, '\1-')}[#{nyear_diary_label @date, years}])" if @date
	end
	r << '</title>'
end

#
# TSUKKOMI mail
#
def comment_mail_mime( str )
	require 'nkf'
	NKF::nkf( "-j -m0 -f50", str ).collect do |s|
		%Q|=?ISO-2022-JP?B?#{[s.chomp].pack( 'm' ).gsub( /\n/, '' )}?=|
	end
end

def comment_mail_conf_label; '�ĥå��ߥ᡼��'; end

def comment_mail_basic_html
	@conf['comment_mail.header'] = '' unless @conf['comment_mail.header']
	@conf['comment_mail.receivers'] = '' unless @conf['comment_mail.receivers']
	@conf['comment_mail.sendhidden'] = false unless @conf['comment_mail.sendhidden']

	<<-HTML
	<h3 class="subtitle">�ĥå��ߥ᡼�������</h3>
	#{"<p>�ĥå��ߤ����ä����ˡ��᡼������뤫�ɤ��������򤷤ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="comment_mail.enable">
		<option value="true"#{" selected" if @conf['comment_mail.enable']}>����</option>
        <option value="false"#{" selected" unless @conf['comment_mail.enable']}>����ʤ�</option>
	</select></p>
	<h3 class="subtitle">������</h3>
	#{"<p>�᡼������������ꤷ�ޤ���1�Ԥ�1�᡼�륢�ɥ쥹�η��ǡ�ʣ�������ǽ�Ǥ�������Τʤ����ˤϡ����ʤ��Υ᡼�륢�ɥ쥹�������ޤ���</p>" unless @conf.mobile_agent?}
	<p><textarea name="comment_mail.receivers" cols="40" rows="3">#{h( @conf['comment_mail.receivers'].gsub( /[, ]+/, "\n") )}</textarea></p>
	<h3 class="subtitle">�᡼��إå�</h3>
	#{"<p>�᡼���Subject�ˤĤ���إå�ʸ�������ꤷ�ޤ�������ʬ�����������ʤ褦�˻��ꤷ�ޤ����ºݤ�Subject�ˤϡֻ���ʸ����:����-1�פΤ褦�ˡ����դȥ������ֹ椬�դ��ޤ�������������ʸ������ˡ�%��³���ѻ������ä���硢��������եե����ޥåȻ���򸫤ʤ��ޤ����Ĥޤ�����աפ���ʬ�ϼ�ưŪ���ղä���ʤ��ʤ�ޤ�(�������ֹ���ղä���ޤ�)��</p>" unless @conf.mobile_agent?}
	<p><input name="comment_mail.header" value="#{h @conf['comment_mail.header']}"></p>
	<h3 class="subtitle">��ɽ���ĥå��ߤΰ���</h3>
	#{"<p>�ե��륿�η�̡��ǽ餫����ɽ���ˤ��줿�ĥå��ߤ���Ͽ����뤳�Ȥ�����ޤ���������ɽ���Υĥå��ߤ��褿�Ȥ��ˤ�᡼���ȯ�����뤫�ɤ��������򤷤ޤ���</p>" unless @conf.mobile_agent?}
	<p><input type="checkbox" name="comment_mail.sendhidden" value="true"#{" checked" if @conf['comment_mail.sendhidden']}>��ɽ���Υĥå��ߤǤ�᡼�������</p>
	HTML
end

#
# link to HOWTO write diary
#
def style_howto
	%Q|/<a href="http://docs.tdiary.org/ja/?#{h @conf.style}%A5%B9%A5%BF%A5%A4%A5%EB">����</a>|
end

#
# labels (normal)
#
def no_diary; "#{@date.strftime( @conf.date_format )}�������Ϥ���ޤ���"; end
def comment_today; '�����Υĥå���'; end
def comment_total( total ); "(��#{total}��)"; end
def comment_new; '�ĥå��ߤ������'; end
def comment_description; '�ĥå��ߡ������Ȥ�����Фɤ���! E-mail���ɥ쥹�ϸ�������ޤ���'; end
def comment_limit_label; '�����������ϥĥå��߿������¤�ۤ��Ƥ��ޤ���'; end
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
def trackback_today; '������TrackBacks'; end
def trackback_total( total ); "(��#{total}��)"; end

def navi_index; '�ȥå�'; end
def navi_latest; '�ǿ�'; end
def navi_oldest; '�Ǹ�'; end
def navi_update; "�ɵ�"; end
def navi_edit; "�Խ�"; end
def navi_preference; "����"; end
def navi_prev_diary(date); "��������(#{date.strftime(@date_format)})"; end
def navi_next_diary(date); "��������(#{date.strftime(@date_format)})"; end
def navi_prev_month; "����"; end
def navi_next_month; "���"; end
def navi_prev_nyear(date); "������(#{date.strftime('%m-%d')})"; end
def navi_next_nyear(date); "������(#{date.strftime('%m-%d')})"; end
def navi_prev_ndays; "��#{@conf.latest_limit}��ʬ"; end
def navi_next_ndays; "��#{@conf.latest_limit}��ʬ"; end

def submit_label
	if @mode == 'form' or @cgi.valid?( 'appendpreview' ) then
		'�ɵ�'
	else
		'��Ͽ'
	end
end
def preview_label; '�ץ�ӥ塼'; end

def nyear_diary_label(date, years); "Ĺǯ����"; end
def nyear_diary_title(date, years); "Ĺǯ����"; end

#
# labels (for mobile)
#
def mobile_navi_latest; '�ǿ�'; end
def mobile_navi_update; "�ɵ�"; end
def mobile_navi_preference; "����"; end
def mobile_navi_prev_diary; "��"; end
def mobile_navi_next_diary; "��"; end
def mobile_label_hidden_diary; '�������ϡ���ɽ���ۤǤ�'; end

#
# category
#
def category_anchor(c); "[#{c}]"; end

#
# preferences (resources)
#

# genre labels
@conf_genre_label['basic'] = '����'
@conf_genre_label['update'] = '����'
@conf_genre_label['theme'] = '�ơ���'
@conf_genre_label['tsukkomi'] = '�ĥå���'
@conf_genre_label['referer'] = '��󥯸�'
@conf_genre_label['security'] = '�������ƥ�'
@conf_genre_label['etc'] = '����¾'


add_conf_proc( 'default', '�����Ȥξ���', 'basic' ) do
	saveconf_default
	@conf.description ||= ''
	@conf.icon ||= ''
	@conf.banner ||= ''
	<<-HTML
	<h3 class="subtitle">�����ȥ�</h3>
	#{"<p>HTML��&lt;title&gt;�����椪��ӡ���Х���ü������λ��Ȼ��˻Ȥ��륿���ȥ�Ǥ���HTML�����ϻȤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="html_title" value="#{h @conf.html_title}" size="50"></p>

	<h3 class="subtitle">����̾</h3>
	#{"<p>���ʤ���̾������ꤷ�ޤ���HTML�إå����Ÿ������ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="author_name" value="#{h @conf.author_name}" size="40"></p>

	<h3 class="subtitle">�᡼�륢�ɥ쥹</h3>
	#{"<p>���ʤ��Υ᡼�륢�ɥ쥹����ꤷ�ޤ���HTML�إå����Ÿ������ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="author_mail" value="#{h @conf.author_mail}" size="40"></p>

	<h3 class="subtitle">�ȥåץڡ���URL</h3>
	#{"<p>���������̤Υ���ƥ�Ĥ�����л��ꤷ�ޤ���¸�ߤ��ʤ����ϲ������Ϥ��ʤ��Ƥ��ޤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="index_page" value="#{h @conf.index_page}" size="70"></p>

	<h3 class="subtitle">����������</h3>
	#{"<p>���������δ�ñ����������ꤷ�ޤ���HTML�إå����Ÿ������ޤ����������Ϥ��ʤ��Ƥ⤫�ޤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="description" value="#{h @conf.description}" size="70"></p>

	<h3 class="subtitle">�����ȥ�������(favicon)</h3>
	#{"<p>����������ɽ�������ʥ����������(favicon)������Ф���URL����ꤷ�ޤ���HTML�إå����Ÿ������ޤ����������Ϥ��ʤ��Ƥ⤫�ޤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="icon" value="#{h @conf.icon}" size="70"></p>

	<h3 class="subtitle">�Хʡ�����</h3>
	#{"<p>����������ɽ������(�Хʡ�)������Ф���URL����ꤷ�ޤ���makerss�ץ饰����ʤɤ�RSS����Ϥ�����ʤɤ˻Ȥ��ޤ����������Ϥ��ʤ��Ƥ⤫�ޤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="banner" value="#{h @conf.banner}" size="70"></p>
	HTML
end

add_conf_proc( 'header', '�إå����եå�', 'basic' ) do
	saveconf_header

	<<-HTML
	<h3 class="subtitle">�إå�</h3>
	#{"<p>��������Ƭ�����������ʸ�Ϥ���ꤷ�ޤ���HTML�������Ȥ��ޤ�����&lt;%=navi%&gt;�פǡ��ʥӥ��������ܥ���������Ǥ��ޤ�(���줬�ʤ��ȹ������Ǥ��ʤ��ʤ�ΤǺ�����ʤ��褦�ˤ��Ƥ�������)���ޤ�����&lt;%=calendar%&gt;�פǥ��������������Ǥ��ޤ�������¾���Ƽ�ץ饰����򵭽ҤǤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><textarea name="header" cols="70" rows="10">#{h @conf.header}</textarea></p>
	<h3 class="subtitle">�եå�</h3>
	#{"<p>�����κǸ�����������ʸ�Ϥ���ꤷ�ޤ����إå���Ʊ�ͤ˻���Ǥ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><textarea name="footer" cols="70" rows="10">#{h @conf.footer}</textarea></p>
	HTML
end

add_conf_proc( 'display', 'ɽ������', 'basic' ) do
	saveconf_display

	<<-HTML
	<h3 class="subtitle">��������󥢥󥫡�</h3>
	#{"<p>�����Υ�����������Ƭ(���֥����ȥ�ι�Ƭ)����������롢����ѤΥ��󥫡�ʸ�������ꤷ�ޤ����ʤ���&lt;span class=\"sanchor\"&gt;_&lt;/span&gt;�פ���ꤹ��ȡ��ơ��ޤˤ�äƤϼ�ưŪ�˲������󥫡����Ĥ��褦�ˤʤ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="section_anchor" value="#{h @conf.section_anchor}" size="40"></p>
	<h3 class="subtitle">�ĥå��ߥ��󥫡�</h3>
	#{"<p>�ɼԤ���Υĥå��ߤ���Ƭ����������롢����ѤΥ��󥫡�ʸ�������ꤷ�ޤ����ʤ���&lt;span class=\"canchor\"&gt;_&lt;/span&gt;�פ���ꤹ��ȡ��ơ��ޤˤ�äƤϼ�ưŪ�˲������󥫡����Ĥ��褦�ˤʤ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="comment_anchor" value="#{h @conf.comment_anchor}" size="40"></p>
	<h3 class="subtitle">���եե����ޥå�</h3>
	#{"<p>���դ�ɽ����ʬ�˻Ȥ���ե����ޥåȤ���ꤷ�ޤ���Ǥ�դ�ʸ�����Ȥ��ޤ�������%�פǻϤޤ�ѻ��ˤϼ��Τ褦���ü�ʰ�̣������ޤ�����%Y��(����ǯ)����%m��(�����)����%b��(û��̾)����%B��(Ĺ��̾)����%d��(��)����%a��(û����̾)����%A��(Ĺ����̾)��</p>" unless @conf.mobile_agent?}
	<p><input name="date_format" value="#{h @conf.date_format}" size="30"></p>
	<h3 class="subtitle">�ǿ�ɽ���κ�������</h3>
	#{"<p>�ǿ���������ɽ������Ȥ��ˡ����Υڡ�����˲���ʬ��������ɽ�����뤫����ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p>����<input name="latest_limit" value="#{h @conf.latest_limit}" size="2">��ʬ</p>
	<h3 class="subtitle">Ĺǯ������ɽ��</h3>
	#{"<p>Ĺǯ������ɽ�����뤿��Υ�󥯤�ɽ�����뤫�ɤ�������ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="show_nyear">
		<option value="true"#{" selected" if @conf.show_nyear}>ɽ��</option>
		<option value="false"#{" selected" unless @conf.show_nyear}>��ɽ��</option>
	</select></p>
	HTML
end

add_conf_proc( 'timezone', '����Ĵ��', 'update' ) do
	saveconf_timezone

	<<-HTML
	<h3 class="subtitle">����Ĵ��</h3>
	#{"<p>���������ե������������������դ����ñ�̤�Ĵ���Ǥ��ޤ����㤨�и���2���ޤǤ������Ȥ��ư����������ˤϡ�-2�פΤ褦�˻��ꤹ�뤳�Ȥǡ�2����ʬ�����줿���դ����������褦�ˤʤ�ޤ����ޤ����������դ�Web�����о�λ���ˤʤäƤ���Τǡ������Υ����ФǱ��Ĥ��Ƥ�����λ���Ĵ���ˤ����ѤǤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="hour_offset" value="#{h @conf.hour_offset}" size="5"></p>
	HTML
end

@theme_location_comment = "<p>�����ˤʤ��ơ��ޤ�<a href=\"http://www.tdiary.org/20021001.html\">�ơ��ޡ������꡼</a>��������Ǥ��ޤ���</p>"
@theme_thumbnail_label = "����ͥ���"

add_conf_proc( 'theme', '�ơ�������', 'theme' ) do
	saveconf_theme

	r = <<-HTML
	<h3 class="subtitle">�ơ��ޤλ���</h3>
	#{"<p>�����Υǥ������ơ��ޡ��⤷����CSS��ľ�����Ϥǻ��ꤷ�ޤ����ɥ�åץ������˥塼�����CSS���ꢪ�פ����򤷤����ˤϡ��������CSS��URL�����Ϥ��Ƥ���������</p>" unless @conf.mobile_agent?}
	<p>
	<select name="theme" onChange="changeTheme( theme_thumbnail, this )">
		<option value="">CSS���ꢪ</option>
	HTML
	r << conf_theme_list
end

add_conf_proc( 'comment', '�ĥå���', 'tsukkomi' ) do
	saveconf_comment

	<<-HTML
	<h3 class="subtitle">�ĥå��ߤ�ɽ��</h3>
	#{"<p>�ɼԤ���Υĥå��ߤ�ɽ�����뤫�ɤ�������ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="show_comment">
		<option value="true"#{" selected" if @conf.show_comment}>ɽ��</option>
		<option value="false"#{" selected" unless @conf.show_comment}>��ɽ��</option>
	</select></p>
	<h3 class="subtitle">�ĥå��ߥꥹ��ɽ����</h3>
	#{"<p>�ǿ��⤷���Ϸ���ɽ������ɽ�����롢�ĥå��ߤκ���������ꤷ�ޤ����ʤ�������ɽ�����ˤϤ����λ���ˤ�����餺���٤ƤΥĥå��ߤ�ɽ������ޤ���</p>" unless @conf.mobile_agent?}
	<p>����<input name="comment_limit" value="#{h @conf.comment_limit}" size="3">��</p>
	<h3 class="subtitle">1��������Υĥå��ߺ����</h3>
	#{"<p>1���˽񤭹����ĥå��ߤκ��������ꤷ�ޤ������ο���Ķ����ȡ��ĥå����ѤΥե����ब��ɽ���ˤʤ�ޤ����ʤ���TrackBack�ץ饰���������Ƥ�����ˤϡ��ĥå��ߤ�TrackBack�ι�פ��������¤�����ޤ���</p>" unless @conf.mobile_agent?}
	<p>����<input name="comment_limit_per_day" value="#{h @conf.comment_limit_per_day}" size="3">��</p>
	HTML
end

add_conf_proc( 'csrf_protection', 'CSRF(��ü��)�к�', 'security' ) do
	err = saveconf_csrf_protection
	errstr = ''
	case err
	when :param
		errstr = '<p class="message">�������Ȥ߹�碌�Ǥ����ѹ�����ޤ���Ǥ�����</p>'
	when :key
		errstr = '<p class="message">�������Ǥ����ѹ�����ޤ���Ǥ�����</p>'
	end
	csrf_protection_method = @conf.options['csrf_protection_method'] || 1
	csrf_protection_key = @conf.options['csrf_protection_key'] || ''
	<<-HTML
	#{errstr}
	<p>���������ȡ��ꥯ�����ȥե���������(CSRF)���к���ˡ�����ꤷ�ޤ���</p>
	<p>CSRF����ϡ����դΤ���ʹ֤�Web�ڡ�����櫤�ųݤ��ޤ���
	����櫤�ųݤ����ڡ����򤢤ʤ�����������ȡ����ʤ��Υ֥饦����
	tDiary�˵��ν񤭹����׵�����Ф��Ƥ��ޤ��ޤ������ʤ��Υ֥饦����
	���׵�����Ф��Ƥ��ޤ����ᡢ�Ź沽���ѥ�����ݸ�����Ǥ��к��ˤʤ�ޤ���
	tDiary�Ǥϡ����μ�ι�����Ф��ơ���Referer�����å��פȡ�CSRF�����פȤ���
	2������ɱҼ��ʤ��Ѱդ��Ƥ��ޤ���</p>
	<div class="section">
	<h3 class="subtitle">Referer�����å��ˤ���ɱ�</h3>
	<h4>Referer���������θ���</h4>
	<p>#{if [0,1,2,3].include?(csrf_protection_method) then
            '<input type="checkbox" name="check_enabled2" value="true" checked disabled>
            <input type="hidden" name="check_enabled" value="true">'
          else
            '<input type="checkbox" name="check_enabled" value="true">'
        end}����(ɸ��)</input>
	</p>
	#{"<p>���ʤ��Υ֥饦�������Ф���Referer(��󥯸�����)�򸡺����ޤ���
	�񤭹����׵᤬�������ڡ����������Ф��줿���Ȥ��ǧ���뤳�Ȥǡ�
	���ڡ���������׵���ɤ��ޤ��������ʥڡ���������׵�򸡽Ф�����硢
	�����ꥯ�����Ȥ���ݤ��ޤ���
	����������̤Ǥϡ�̵���ˤ��뤳�ȤϽ���ޤ���</p>
	" unless @conf.mobile_agent?}
	<h4>Referer�����Ф��ʤ��֥饦�������</h4>
	<p><input type="radio" name="check_referer" value="true" #{if [1,3].include?(csrf_protection_method) then " checked" end}>����(ɸ��)</input>
	<input type="radio" name="check_referer" value="false" #{if [0,2].include?(csrf_protection_method) then " checked" end}>���ʤ�</input>
	</p>
	#{"<p>�֥饦������Referer�������Ƥ��ʤ��ä�����ư�����ꤷ�ޤ���</p>
	<p>ɸ��Ǥϡ�Referer�����Ф���ʤ���硢�����ʥꥯ�����Ȥ�
	Ƚ�̤Ǥ��ʤ����ᡢ�񤭹��ߡ������ѹ�����ݤ��ޤ���
	���ʤ��Υ֥饦����Referer�����Ф��ʤ�����ξ�硢
	�������꤬�֤���פˤʤäƤ���ȡ������ν񤭹����׵����ݤ��Ƥ��ޤ��ޤ���
	�֥饦����������ѹ���Referer�����Ф���褦�ˤ��Ƥ���������
	�ɤ����Ƥ�Referer�����Ф�������˽���ʤ���硢�֤��ʤ��פˤ��Ƥ���������
	���ξ�硢Referer���������Ф���ʤ��ä����ˤ⡢
	�񤭹��ߡ������ѹ�������褦�ˤʤ�ޤ�����
	CSRF�ˤ�빶��ȶ��̤Ǥ��ʤ��ʤ�ޤ��Τǡ�ɬ�����Ρ�CSRF�ɻߥ����פ�
	�����ʻ�Ѥ��Ʋ�������</p>
	</div>
	" unless @conf.mobile_agent?}
	<div class="section">
	<h3 class="subtitle">CSRF�ɻߥ����ˤ���ɱ�</h3>
	<h4>CSRF�ɻߥ����θ���</h4>
	<p><input type="radio" name="check_key" value="true" #{if [2,3].include?(csrf_protection_method) then " checked" end}>����</input>
	<input type="radio" name="check_key" value="false" #{if [0,1].include?(csrf_protection_method) then " checked" end}>���ʤ�(ɸ��)</input>
	</p>
	#{"<p>�񤭹��ߥե�����˵����񤭹����ɻߤΤ���Υ��������ꤷ��CSRF���ɤ��ޤ���
	���ڡ�������̩�Υ������Τ�ʤ��¤ꡢ
	���ν񤭹����׵���������뤳�Ȥ��Ǥ��ʤ��ʤ�ޤ���
	���θ�����֤���פ����ꤹ���硢���θ������ꤷ�Ʋ�������
	��������ξ���֤��ʤ��פˤ��뤳�ȤϤǤ��ޤ���</p>
	<p>���������֤���פˤ�����硢���ε������б����Ƥ��ʤ�������
	�ץ饰����ư��ʤ��ʤ뤳�Ȥ�����ޤ���</p>
	" unless @conf.mobile_agent?}
	<h4>CSRF �ɻߥ���</h4>
	<p><input type="text" name="key" value="#{h csrf_protection_key}" size="30"></p>
	#{"<p>�����ɻߥ��������ꤷ�ޤ�����¬���ˤ���Ŭ����ʸ�������ꤷ�Ʋ�������
	���θ��������˱̤��ȡ�CSRF�����������ǽ��������ޤ���
	¾�Υѥ���ɤȶ��ѤϤ��ƤϤ����ޤ��󡣤ʤ������ꤷ��ʸ����򤢤ʤ����Ф��Ƥ���ɬ�פϤ���ޤ���</p>" unless @conf.mobile_agent?}
	#{"<p class=\"message\">���: 
	���ʤ��Υ֥饦���ϸ���Referer�����Ф��Ƥ��ʤ��褦�Ǥ���
	<a href=\"#{h @update}?conf=csrf_protection\">���Υ�󥯤���⤦���
	���Υڡ����򳫤��ƤߤƲ�����</a>��
	����Ǥ⤳�Υ�å��������Ф�����Ǥϡ�����������Ѥ����硢
	���Ū��Referer�����Ф�������ˤ��뤫��
	ľ��tdiary.conf���Խ����Ʋ�������</p>
	</div>" if [1,3].include?(csrf_protection_method) && ! @cgi.referer && !@cgi.valid?('referer_exists')}
	HTML
end
