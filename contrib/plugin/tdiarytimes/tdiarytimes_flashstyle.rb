# tdiarytimes_flashstyle.rb $Revision: 1.1 $
#
# Copyright (c) 2004 phonondrive <tdiary@phonondrive.com>
# Distributed under the GPL
#
# �ץ饰�������ۥڡ�����
# http://phonondrive.com/trd/
# --------------------------------------------------------------------
#
#
#
# Abstract��
# --------------------------------------------------------------------
# ��������Ͽ���������Ӥ򥿥���饤���˵�Ͽ���ޤ�����Ͽ���줿����ȥ��
# �����ηв�ȶ��˥ե����ɥ����Ȥ��Ƥ����ޤ������Τ褦�� MTBlogTimes �� 
# tdiarytimes.rb ��Ʊ���ε�ǽ�� FLASH �Ǽ¸����ޤ���
# ruby-gd �Υ��󥹥ȡ����Ȥ�ɬ�פʤ����ᡢ�����˻��ѽ���ޤ���
#
#
# Usage��
# --------------------------------------------------------------------
# �ץ饰����ϡ��ץ饰����ե����������Ʋ�������
#
# �ץ饰����ϡ��ץ饰����ե����������Ƥ���������
# tdiarytimes*.swf �� tdiary.rb ��Ʊ���ե�����˥��åץ��ɤ��ޤ���
# �إå����եå����˵��Ҥ��� <%= tdiarytimes_flashstyle %> ����ʬ�ˡ�
# FLASH ���ץ�åȤ�ɽ������ޤ���
# tdiarytimes.log ��������Ͽ���� .swf ��Ʊ���ե�����˺�������ޤ���
#
# �� tdiarytimes_textstyle.rb �Ȥθߴ����Ϥ���ޤ���
#
#
# Options��
# --------------------------------------------------------------------
# ������饤��ο���Ʃ���١��������ʤɤϡ��ץ�ե���󥹲��̤�����Ǥ��ޤ���
#
#
# In secure mode��
# --------------------------------------------------------------------
# ���֤�ư��ޤ���
#
#
=begin ChangeLog
2004.05.02 phonondrive  <tdiary@phonondrive.com>
   * version 1.1.2
		������饤�������̤� FLASH ���ɲ�
2004.05.02 phonondrive  <tdiary@phonondrive.com>
   * version 1.1.1
		������饤�󤬱߷��ǡ������פ�����ɽ���� FLASH ���ɲ�
		���ե����뤬¸�ߤ��ʤ����˥��顼���Ф��Զ�����
2004.04.28 phonondrive  <tdiary@phonondrive.com>
   * version 1.1.0
		������饤�󤬱߷��� FLASH ���ɲ�
2004.04.27 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.1
		���������ƥ����Ȥο����ѹ�����ʤ��Զ�����
2004.04.25 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.0
=end


# --------------------------------------------------------------------
# �ץ饰�����ư��
# --------------------------------------------------------------------

def tdiarytimes_flashstyle
	if @conf['tdiarytimes_f.templete'] == nil or @conf['tdiarytimes_f.templete'] == ""
		r = %Q|���Ѥ򳫻Ϥ���ˤϡ�<a href="./#{@update}?conf=tdiarytimes_f">�ץ�ե���󥹲���</a>�ˤư��������λ���Ʋ�������(tdiarytimes-flashstyle)|
	else
		logname = ((@conf['tdiarytimes_f.log_path'] != "" and @conf['tdiarytimes_f.log_path'] != nil) ? @conf['tdiarytimes_f.log_path'] : "tdiarytimes.log")
		r = @conf['tdiarytimes_f.templete'].gsub(/\&uid/,"\&uid=#{File.mtime(logname.untaint).to_i}")
	end
end

# --------------------------------------------------------------------
# ������Ͽ���ν���
# --------------------------------------------------------------------

if /^(append|replace)$/ =~ @mode and @cgi.params['hide'][0] != 'true' then

	logname = ((@conf['tdiarytimes_f.log_path'] != "" and @conf['tdiarytimes_f.log_path'] != nil) ? @conf['tdiarytimes_f.log_path'] : "tdiarytimes.log")
	entr_lifetime = ((@conf['tdiarytimes_f.entr_lifetime'] != "" and @conf['tdiarytimes_f.entr_lifetime'] != nil) ? @conf['tdiarytimes_f.entr_lifetime'].to_i * 60 * 60 * 24 : 30 * 24 * 60 * 60)
	entr_interval = ((@conf['tdiarytimes_f.entr_interval'] != "" and @conf['tdiarytimes_f.entr_interval'] != nil) ? @conf['tdiarytimes_f.entr_interval'] : 2 * 60 * 60)

	begin
		logs = open(logname){|io| io.read }.chomp.split(',')
	rescue
		logs = ""
	end

	if (Time.now.to_i - logs.max.to_i) > entr_interval.to_i
		logs << "#{Time.now.to_i}"
		open(logname,"w"){|io|
			io.write(logs.find_all{|item| (Time.now.to_i - item.to_i) < entr_lifetime.to_i }.join(','))
		}
	end

end

# --------------------------------------------------------------------
# �ץ�ե���󥹲��̤Ǥ�����
# --------------------------------------------------------------------

add_conf_proc( 'tdiarytimes_f', 'tdiarytimes-flashstyle ������' ) do

	if @mode == 'saveconf' then

		filename = "tdiarytimes234x30.swf"
		width = "234"
		height = "30"
		argvs = ""

		argv = Array.new

		@conf['tdiarytimes_f.uid'] = @cgi.params['uid'][0]
		argv << "#{Time.now.to_i}&uid" if @conf['tdiarytimes_f.uid'] == "1"

		@conf['tdiarytimes_f.type'] = @cgi.params['type'][0]
		@conf['tdiarytimes_f.filename'] = @cgi.params['filename'][0]
		@conf['tdiarytimes_f.width'] = @cgi.params['width'][0]
		@conf['tdiarytimes_f.height'] = @cgi.params['height'][0]

		@conf['tdiarytimes_f.log_path'] = @cgi.params['log_path'][0]
		argv << "log_path=#{@cgi.params['log_path'][0]}" if @cgi.params['log_path'][0] != ""

		@conf['tdiarytimes_f.text_visible'] = @cgi.params['text_visible'][0]
		argv << "text_visible=#{@cgi.params['text_visible'][0]}" if @cgi.params['text_visible'][0] == "0"
		@conf['tdiarytimes_f.text_text'] = @cgi.params['text_text'][0]
		argv << "text_text=#{CGI::escape @cgi.params['text_text'][0].upcase}" if @cgi.params['text_text'][0] != ""
		@conf['tdiarytimes_f.text_rgb'] = @cgi.params['text_rgb'][0]
		argv << "text_rgb=0x#{@cgi.params['text_rgb'][0]}" if @cgi.params['text_rgb'][0] != ""

		@conf['tdiarytimes_f.face_visible'] = @cgi.params['face_visible'][0]
		argv << "face_visible=#{@cgi.params['face_visible'][0]}" if @cgi.params['face_visible'][0] == "0"
		@conf['tdiarytimes_f.face_rgb'] = @cgi.params['face_rgb'][0]
		argv << "face_rgb=0x#{@cgi.params['face_rgb'][0]}" if @cgi.params['face_rgb'][0] != ""

		@conf['tdiarytimes_f.stage_rgb'] = @cgi.params['stage_rgb'][0]
		argv << "stage_rgb=0x#{@cgi.params['stage_rgb'][0]}" if @cgi.params['stage_rgb'][0] != ""
		@conf['tdiarytimes_f.stage_alpha'] = @cgi.params['stage_alpha'][0]
		argv << "stage_alpha=#{@cgi.params['stage_alpha'][0]}" if @cgi.params['stage_alpha'][0] != ""
		@conf['tdiarytimes_f.bg_rgb'] = @cgi.params['bg_rgb'][0]
		argv << "bg_rgb=0x#{@cgi.params['bg_rgb'][0]}" if @cgi.params['bg_rgb'][0] != ""
		@conf['tdiarytimes_f.bg_alpha'] = @cgi.params['bg_alpha'][0]
		argv << "bg_alpha=#{@cgi.params['bg_alpha'][0]}" if @cgi.params['bg_alpha'][0] != ""
		@conf['tdiarytimes_f.bar_rgb'] = @cgi.params['bar_rgb'][0]
		argv << "bar_rgb=0x#{@cgi.params['bar_rgb'][0]}" if @cgi.params['bar_rgb'][0] != ""
		@conf['tdiarytimes_f.bar_width'] = @cgi.params['bar_width'][0]
		argv << "bar_width=#{@cgi.params['bar_width'][0]}" if @cgi.params['bar_width'][0] != ""

		@conf['tdiarytimes_f.entr_interval'] = @cgi.params['entr_interval'][0]
		@conf['tdiarytimes_f.entr_lifetime'] = @cgi.params['entr_lifetime'][0]
		@conf['tdiarytimes_f.fade_time'] = @cgi.params['fade_time'][0]
		argv << "fade_time=#{@cgi.params['fade_time'][0]}" if @cgi.params['fade_time'][0] != ""

		@conf['tdiarytimes_f.preview'] = @cgi.params['preview'][0]

		if @cgi.params['type'][0] == "0"
			filename = @cgi.params['filename'][0]
			width = @cgi.params['width'][0]
			height = @cgi.params['height'][0]
		elsif @cgi.params['type'][0]
			filename = "tdiarytimes#{@cgi.params['type'][0].gsub('-','')}.swf"
			width = @cgi.params['type'][0].split('-').first.split('x')[0]
			height = @cgi.params['type'][0].split('-').first.split('x')[1]
		end

		if argv.size > 0 then argvs = "?#{argv.join('&')}" end

		@conf['tdiarytimes_f.templete'] = tdiarytimes_flashstyle_templete(filename, argvs, width, height)
	end


	<<-HTML
		<h3 class="subtitle">����γ���</h3>
		<p>() ��Ͻ���ͤǤ�������ͤ���Ѥ�����ϡ�����Τޤޤǹ����ޤ��󡣿��� RRGGBB �����ǻ��ꤷ�Ʋ���������Ʃ���٤� 0 (Ʃ��) �� 100 (��Ʃ��) �Ǥ��������ϥԥ�����ǻ��ꤷ�ޤ���</p>
		<hr>
		<h3 class="subtitle">�ץ�ӥ塼</h3>
		#{tdiarytimes_flashstyle_preview}
		<hr>
		<h3 class="subtitle">ɽ������ FLASH ���ץ�åȤ�����</h3>
		<p><select name="type">
		<option value="0"#{if @conf['tdiarytimes_f.type'] == "0" then " selected" end}>�ץꥻ�åȤ���Ѥ��ʤ�</option>
		<option value="125x30"#{if @conf['tdiarytimes_f.type'] == "125x30" then " selected" end}>tdiarytimes125x30.swf, 125x30</option>
		<option value="234x30"#{if @conf['tdiarytimes_f.type'] == "234x30" or @conf['tdiarytimes_f.type'] == nil or @conf['tdiarytimes_f.type'] == "" then " selected" end}>tdiarytimes234x30.swf, 234x30</option>
		<option value="468x30"#{if @conf['tdiarytimes_f.type'] == "468x30" then " selected" end}>tdiarytimes468x30.swf, 468x30</option>
		<option value="125x125-r"#{if @conf['tdiarytimes_f.type'] == "125x125-r" then " selected" end}>tdiarytimes125x125r.swf, 125x125 (�߷�)</option>
		<option value="125x125-r7"#{if @conf['tdiarytimes_f.type'] == "125x125-r7" then " selected" end}>tdiarytimes125x125r7.swf, 125x125 (�߷�, ����)</option>
		<option value="125x125-s"#{if @conf['tdiarytimes_f.type'] == "125x125-s" then " selected" end}>tdiarytimes125x125s.swf, 125x125 (������)</option>
		</select></p>
		<h3 class="subtitle">�ץꥻ�åȤ���Ѥ��ʤ����ϡ��ʲ��ǻ��ꤷ�Ʋ�������</h3>
		<p>FLASH �Υե�����̾<br><input name="filename" value="#{@conf['tdiarytimes_f.filename'].to_s}" size="40"></p>
		<p>FLASH ��ɽ����<br><input name="width" value="#{@conf['tdiarytimes_f.width'].to_s}" size="20"></p>
		<p>FLASH ��ɽ���⤵<br><input name="height" value="#{@conf['tdiarytimes_f.height'].to_s}" size="20"></p>
		<hr>
		<h3 class="subtitle">�����ȥ�ƥ�����</h3>
		<p>�����ȥ�ƥ����Ȥ�ɽ��̵ͭ (ɽ��)<br><select name="text_visible">
		<option value="1"#{if @conf['tdiarytimes_f.text_visible'] != "0" then " selected" end}>ɽ��</option>
		<option value="0"#{if @conf['tdiarytimes_f.text_visible'] == "0" then " selected" end}>��ɽ��</option>
		</select></p>
		<p>�����ȥ�ƥ����� (TDIARYTIMES-FLASHSTYLE)<br>���ѽ����ʸ���ϡ�����ʸ�� (A-Z) �ȿ��� (0-9)������ӵ���ΤߤǤ���<br><input name="text_text" value="#{@conf['tdiarytimes_f.text_text'].to_s}" size="20"></p>
		<p>�����ȥ�ƥ����Ȥο� (333333)<br><input name="text_rgb" value="#{@conf['tdiarytimes_f.text_rgb'].to_s}" size="20"></p>
		<h3 class="subtitle">���������ƥ�����</h3>
		<p>���������ƥ����Ȥ�ɽ��̵ͭ (ɽ��)<br><select name="face_visible">
		<option value="1"#{if @conf['tdiarytimes_f.face_visible'] != "0" then " selected" end}>ɽ��</option>
		<option value="0"#{if @conf['tdiarytimes_f.face_visible'] == "0" then " selected" end}>��ɽ��</option>
		</select></p>
		<p>���������ƥ����Ȥο� (333333)<br><input name="face_rgb" value="#{@conf['tdiarytimes_f.face_rgb'].to_s}" size="20"></p>
		<hr>
		<h3 class="subtitle">�طʤ�������դο�</h3>
		<p>�طʤο� (FFFFFF)<br><input name="stage_rgb" value="#{@conf['tdiarytimes_f.stage_rgb'].to_s}" size="20"></p>
		<p>�طʤ���Ʃ���� (0)<br><input name="stage_alpha" value="#{@conf['tdiarytimes_f.stage_alpha'].to_s}" size="20"></p>
		<p>������饤����طʤο� (333333)<br><input name="bg_rgb" value="#{@conf['tdiarytimes_f.bg_rgb'].to_s}" size="20"></p>
		<p>������饤����طʤ���Ʃ���� (100)<br><input name="bg_alpha" value="#{@conf['tdiarytimes_f.bg_alpha'].to_s}" size="20"></p>
		<p>������饤��˵�Ͽ�����������դο� (EEEEEE)<br><input name="bar_rgb" value="#{@conf['tdiarytimes_f.bar_rgb'].to_s}" size="20"></p>
		<p>������饤��˵�Ͽ�����������դ����� (1)<br><input name="bar_width" value="#{@conf['tdiarytimes_f.bar_width'].to_s}" size="20"></p>
		<p>������饤��˵�Ͽ�����������դμ�̿���� (30)<br><input name="fade_time" value="#{@conf['tdiarytimes_f.fade_time'].to_s}" size="20"></p>
		<hr>
		<h3 class="subtitle">������</h3>
		<p>�����������Ͽ�������������ϥ���ȥ�򿷵���Ͽ���ʤ� (2)<br><input name="entr_interval" value="#{@conf['tdiarytimes_f.entr_interval'].to_s}" size="20"></p>
		<p>����������˥��ե����뤫�饨��ȥ�������� (30)<br><input name="entr_lifetime" value="#{@conf['tdiarytimes_f.entr_lifetime'].to_s}" size="20"></p>
		<p>�ܥץ饰���󤬺���������ե�����̾ (tdiarytimes.log)<br><input name="log_path" value="#{@conf['tdiarytimes_f.log_path'].to_s}" size="20"></p>
		<hr>
		<h3 class="subtitle">��ˡ���ID ����Ѥ����ե��������</h3>
		<p>�ե���������Υꥯ�����Ȥ˥�ˡ���ID (�㤨�� ?#{Time.now.to_i}) ��ޤ�뤳�Ȥˤ�ꡢ�Ť��ե����뤬�֥饦���˥���å��夵�줿�ޤޤˤʤ�Τ��ɤ��ޤ���FLASH �Υ�ˡ���ID �ϥץ�ե����������ˡ����ե�����Υ�ˡ���ID �ϥ���ȥ���Ͽ���˹�������ޤ���</p>
		<p>��ˡ���ID ���ղ� (�ղä���)<br><select name="uid">
		<option value="1"#{if @conf['tdiarytimes_f.uid'] != "0" then " selected" end}>�ղä���</option>
		<option value="0"#{if @conf['tdiarytimes_f.uid'] == "0" then " selected" end}>�ղä��ʤ�</option>
		</select></p>
		<hr>
		<h3 class="subtitle">�ץ�ӥ塼</h3>
		<p>ɽ�������� FLASH �ե����� (.swf) �� tdiary.rb ��Ʊ���ե�����˥��åץ��ɤ���Ƥ���ɬ�פ�����ޤ����ޤ������ե����뤬 FLASH �ե������Ʊ���ե�����˺�������Ƥ��ʤ����ˤϥ���դ�ɽ������ޤ���</p>
		<p>�ץ�ӥ塼 (��ɽ��)<br><select name="preview">
		<option value="0"#{if @conf['tdiarytimes_f.preview'] != "1" then " selected" end}>��ɽ��</option>
		<option value="1"#{if @conf['tdiarytimes_f.preview'] == "1" then " selected" end}>ɽ��</option>
		</select></p>
	HTML

end


def tdiarytimes_flashstyle_preview
	unless @conf.mobile_agent?
	<<-r
		<p>#{if @conf['tdiarytimes_f.preview'] == "1" then "#{tdiarytimes_flashstyle}" else "�ץ�ӥ塼ɽ����ͭ���ˤ���ȡ������� FLASH ��ɽ������ޤ���" end}</p>
	r
	end
end

def tdiarytimes_flashstyle_templete ( filename="tdiarytimes234x30.swf",  argvs="", width="234", height="30" )
	<<-r
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="#{width}" height="#{height}" id="tdiarytimes" align="middle">
		<param name="allowScriptAccess" value="sameDomain" />
		<param name="movie" value="#{filename}#{argvs}" />
		<param name="play" value="false" />
		<param name="loop" value="false" />
		<param name="quality" value="high" />
		<param name="wmode" value="transparent" />
		<param name="bgcolor" value="#ffffff" />
		<embed src="#{filename}#{argvs}" play="false" loop="false" quality="high" wmode="transparent" bgcolor="#ffffff" width="#{width}" height="#{height}" name="tdiarytimes" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object>
	r
end
