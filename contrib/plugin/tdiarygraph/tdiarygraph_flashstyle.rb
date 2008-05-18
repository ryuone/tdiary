# tdiarygraph_flashstyle.rb $Revision: 1.3 $
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
# counter.rb �Υ����󥿥� (counter.log) �򥰥�ղ�����
# FLASH ���ץ�åȤ�ɽ�����ޤ���
#
#
# Usage��
# --------------------------------------------------------------------
# �ץ饰����ϡ��ץ饰����ե����������Ƥ���������
# tdiarygraph*.swf �� tdiary.rb ��Ʊ���ե�����˥��åץ��ɤ��ޤ���
# �إå����եå����˵��Ҥ��� <%= tdiarygraph_flashstyle %> ����ʬ�ˡ�
# FLASH ���ץ�åȤ�ɽ������ޤ���
# counter.log ��������Ͽ���� .swf ��Ʊ���ե�����˥��ԡ�����ޤ���
#
# �� counter.rb ����Ѥ��Ƥ��ꡢ���ĥ����󥿥� (counter.log) �ν��Ϥ�
# ����ˤ��Ƥ���ɬ�פ�����ޤ��� 
#
#
# Options��
# --------------------------------------------------------------------
# ����դο���Ʃ���١��������ʤɤϡ��ץ�ե���󥹲��̤�����Ǥ��ޤ���
#
#
# In secure mode��
# --------------------------------------------------------------------
# ���֤�ư��ޤ���
#
#
# Acknowledgements��
# --------------------------------------------------------------------
# counter.rb (counter.log)
#
# Copyright (c) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# Distributed under the GPL2.
# http://ponx.s5.xrea.com/hiki/ja/counter.rb.html
#
#
=begin ChangeLog
2004.04.27 phonondrive  <tdiary@phonondrive.com>
   * version 1.3.0
		����å����к��Ȥ��ƥ�ˡ���ID���ղä��ƥե�����������륪�ץ������ɲ�
		�б� FLASH �ե������ e ������ѹ�
		�ե���Ȥ� _sans ���� 04b03b ���ѹ�
			04b03b.ttf, copyright (c) 1998-2001 YUJI OSHIMOTO
			http://www.04.jp.org/
2004.04.10 phonondrive  <tdiary@phonondrive.com>
   * version 1.2.1
		��ݡ��Ƚ񼰤ǲ��ԥ�������ǽ���ʤ��Զ�����
		�طʤ�������ɽ�����ʤ����ץ������ɲ�
		�б� FLASH �ե������ d ������ѹ�
2004.04.09 phonondrive  <tdiary@phonondrive.com>
   * version 1.2.0
		���ե����뤬ž������ʤ��Զ�����
		����������Υǥե����̾���ѹ� (tdiarygraph.log �� counter.log)
		�����������ͤǻ������륪�ץ������ɲ�
		��ݡ��Ƚ񼰤Υ������ޥ������ץ������ɲ�
		�б� FLASH �ե������ c ������ѹ�
2004.04.05 phonondrive  <tdiary@phonondrive.com>
   * version 1.1.1
		�����������ѹ����륪�ץ������ɲ�
		�б� FLASH �ե������ b ������ɲ�
2004.04.05 phonondrive  <tdiary@phonondrive.com>
   * version 1.1.0
		Ruby 1.6.x ���б� (1.6.7 ��ư���ǧ)
		����������Υǥե����̾���ѹ� (counter.log �� tdiarygraph.log)
2004.04.04 phonondrive  <tdiary@phonondrive.com>
   * version 1.0.0
=end




# --------------------------------------------------------------------
# �ץ饰�����ɽ��
# --------------------------------------------------------------------

def tdiarygraph_flashstyle
	if @conf['tdiarygraph_f.templete'] == nil or @conf['tdiarygraph_f.templete'] == ""
		r = %Q|���Ѥ򳫻Ϥ���ˤϡ�<a href="./#{h @update}?conf=tdiarygraph_f">�ץ�ե���󥹲���</a>�ˤư��������λ���Ʋ�������(tdiarygraph-flashstyle)|
	else
		logname = ((@conf['tdiarygraph_f.log_path'] != "" and @conf['tdiarygraph_f.log_path'] != nil) ? @conf['tdiarygraph_f.log_path'] : "counter.log")
		r = @conf['tdiarygraph_f.templete'].gsub(/\&uid/,"\&uid=#{File.mtime(logname.untaint).to_i}")
	end
end


# --------------------------------------------------------------------
# ������Ͽ���ν��� (counter.log �Υ��ԡ�)
# --------------------------------------------------------------------

if /^(append|replace)$/ =~ @mode and @cgi.params['hide'][0] != 'true' then
	logname = ((@conf['tdiarygraph_f.log_path'] != "" and @conf['tdiarygraph_f.log_path'] != nil) ? @conf['tdiarygraph_f.log_path'] : "counter.log")

	open("#{@cache_path}/counter/counter.log"){|input|
		open(logname, "w"){|output|
			output.write(input.read)
		}
	}
end


# --------------------------------------------------------------------
# �ץ�ե���󥹲��̤Ǥ�����
# --------------------------------------------------------------------

add_conf_proc( 'tdiarygraph_f', 'tdiarygraph-flashstyle ������' ) do

	if @mode == 'saveconf' then

		filename = "tdiarygraph468x60e.swf"
		width = "468"
		height = "60"
		argvs = ""

		argv = Array.new

		@conf['tdiarygraph_f.uid'] = @cgi.params['uid'][0]
		argv << "#{Time.now.to_i}&uid" if @conf['tdiarygraph_f.uid'] == "1"

		@conf['tdiarygraph_f.type'] = @cgi.params['type'][0]
		@conf['tdiarygraph_f.filename'] = @cgi.params['filename'][0]
		@conf['tdiarygraph_f.width'] = @cgi.params['width'][0]
		@conf['tdiarygraph_f.height'] = @cgi.params['height'][0]

		@conf['tdiarygraph_f.log_path'] = @cgi.params['log_path'][0]
		argv << "log_path=#{@cgi.params['log_path'][0]}" if @cgi.params['log_path'][0] != ""
		@conf['tdiarygraph_f.init_num'] = @cgi.params['init_num'][0]
		argv << "init_num=#{@cgi.params['init_num'][0]}" if @cgi.params['init_num'][0] != ""

		@conf['tdiarygraph_f.text_text'] = @cgi.params['text_text'][0].upcase
		argv << "text_text=#{h NKF::nkf('-s', @cgi.params['text_text'][0].upcase)}" if @cgi.params['text_text'][0] != ""
		@conf['tdiarygraph_f.text_rgb'] = @cgi.params['text_rgb'][0]
		argv << "text_rgb=0x#{@cgi.params['text_rgb'][0]}" if @cgi.params['text_rgb'][0] != ""
		@conf['tdiarygraph_f.text_report'] = @cgi.params['text_report'][0]
		argv << "text_report=#{@cgi.params['text_report'][0]}" if @cgi.params['text_report'][0] == "0"
		@conf['tdiarygraph_f.text_report_format'] = @cgi.params['text_report_format'][0]
		argv << "text_report_format=#{tdiarygraph_flashstyle_text_report_format(@cgi.params['text_report_format'][0])}" if @cgi.params['text_report_format'][0] != ""
		@conf['tdiarygraph_f.text_report_rgb'] = @cgi.params['text_report_rgb'][0]
		argv << "text_report_rgb=0x#{@cgi.params['text_report_rgb'][0]}" if @cgi.params['text_report_rgb'][0] != ""
		@conf['tdiarygraph_f.bg_rgb'] = @cgi.params['bg_rgb'][0]
		argv << "bg_rgb=0x#{@cgi.params['bg_rgb'][0]}" if @cgi.params['bg_rgb'][0] != ""
		@conf['tdiarygraph_f.bg_alpha'] = @cgi.params['bg_alpha'][0]
		argv << "bg_alpha=#{@cgi.params['bg_alpha'][0]}" if @cgi.params['bg_alpha'][0] != ""
		@conf['tdiarygraph_f.bg_frame'] = @cgi.params['bg_frame'][0]
		argv << "bg_frame=#{@cgi.params['bg_frame'][0]}" if @cgi.params['bg_frame'][0] == "1"
		@conf['tdiarygraph_f.bar_rgb'] = @cgi.params['bar_rgb'][0]
		argv << "bar_rgb=0x#{@cgi.params['bar_rgb'][0]}" if @cgi.params['bar_rgb'][0] != ""
		@conf['tdiarygraph_f.bar_alpha'] = @cgi.params['bar_alpha'][0]
		argv << "bar_alpha=#{@cgi.params['bar_alpha'][0]}" if @cgi.params['bar_alpha'][0] != ""
		@conf['tdiarygraph_f.line_rgb'] = @cgi.params['line_rgb'][0]
		argv << "line_rgb=0x#{@cgi.params['line_rgb'][0]}" if @cgi.params['line_rgb'][0] != ""
		@conf['tdiarygraph_f.line_alpha'] = @cgi.params['line_alpha'][0]
		argv << "line_alpha=#{@cgi.params['line_alpha'][0]}" if @cgi.params['line_alpha'][0] != ""

		@conf['tdiarygraph_f.bar_width'] = @cgi.params['bar_width'][0]
		argv << "bar_width=#{@cgi.params['bar_width'][0]}" if @cgi.params['bar_width'][0] != ""
		@conf['tdiarygraph_f.line_width'] = @cgi.params['line_width'][0]
		argv << "line_width=#{@cgi.params['line_width'][0]}" if @cgi.params['line_width'][0] != ""

		@conf['tdiarygraph_f.bold'] = @cgi.params['bold'][0]
		argv << "bold=#{@cgi.params['bold'][0]}" if @cgi.params['bold'][0] != ""

		@conf['tdiarygraph_f.preview'] = @cgi.params['preview'][0]

		if @cgi.params['type'][0] == "0"
			filename = @cgi.params['filename'][0]
			width = @cgi.params['width'][0]
			height = @cgi.params['height'][0]
		elsif @cgi.params['type'][0]
			filename = "tdiarygraph#{@cgi.params['type'][0].gsub('-','')}.swf"
			width = @cgi.params['type'][0].split('-').first.split('x')[0]
			height = @cgi.params['type'][0].split('-').first.split('x')[1]
		end

		if argv.size > 0 then argvs = "?#{argv.join('&')}" end

		@conf['tdiarygraph_f.templete'] = tdiarygraph_flashstyle_templete(filename, argvs, width, height)
	end


	<<-HTML
		<h3 class="subtitle">����γ���</h3>
		<p>() ��Ͻ���ͤǤ�������ͤ���Ѥ�����ϡ�����Τޤޤǹ����ޤ��󡣿��� RRGGBB �����ǻ��ꤷ�Ʋ���������Ʃ���٤� 0 (Ʃ��) �� 100 (��Ʃ��) �Ǥ��������ϥԥ�����ǻ��ꤷ�ޤ���</p>
		<hr>
		<h3 class="subtitle">�ץ�ӥ塼</h3>
		#{tdiarygraph_flashstyle_preview}
		<hr>
		<h3 class="subtitle">ɽ������ FLASH ���ץ�åȤ�����</h3>
		<p><select name="type">
		<option value="0"#{" selected" if @conf['tdiarygraph_f.type'] == "0"}>�ץꥻ�åȤ���Ѥ��ʤ�</option>
		<option value="468x60-e"#{" selected" if @conf['tdiarygraph_f.type'] == "468x60-e" or @conf['tdiarygraph_f.type'] == nil or @conf['tdiarygraph_f.type'] == ""}>tdiarygraph468x60e.swf, 468x60</option>
		<option value="728x90-e"#{" selected" if @conf['tdiarygraph_f.type'] == "728x90-e"}>tdiarygraph728x90e.swf, 728x90</option>
		<option value="125x125-e"#{" selected" if @conf['tdiarygraph_f.type'] == "125x125-e"}>tdiarygraph125x125e.swf, 125x125</option>
		<option value="240x180-e"#{" selected" if @conf['tdiarygraph_f.type'] == "240x180-e"}>tdiarygraph240x180e.swf, 240x180</option>
		<option value="120x90-e"#{" selected" if @conf['tdiarygraph_f.type'] == "120x90-e"}>tdiarygraph120x90e.swf, 120x90</option>
		</select></p>
		<h3 class="subtitle">�ץꥻ�åȤ���Ѥ��ʤ����ϡ��ʲ��ǻ��ꤷ�Ʋ�������</h3>
		<p>FLASH �Υե�����̾<br><input name="filename" value="#{h @conf['tdiarygraph_f.filename']}" size="40"></p>
		<p>FLASH ��ɽ����<br><input name="width" value="#{h @conf['tdiarygraph_f.width']}" size="20"></p>
		<p>FLASH ��ɽ���⤵<br><input name="height" value="#{h @conf['tdiarygraph_f.height']}" size="20"></p>
		<hr>
		<h3 class="subtitle">�����������ǡ���</h3>
		<p>�ܥץ饰���󤬺������� counter.log ��ʣ���Υե�����̾ (counter.log)<br><input name="log_path" value="#{h @conf['tdiarygraph_f.log_path']}" size="20"></p>
		<p>�߷ץ����������ν���͡�(0) counter.rb �� init_num ����ꤷ�Ƥ�����ϡ�Ʊ���� (#{@conf['counter.init_num']}) �����ꤷ�Ƥ���������<br><input name="init_num" value="#{h @conf['tdiarygraph_f.init_num']}" size="20"></p>
		<hr>
		<h3 class="subtitle">�����ȥ�ƥ�����</h3>
		<p>�����ȥ�ƥ����� (TDIARYGRAPH-FLASHSTYLE)<br>���ѽ����ʸ���ϡ�����ʸ�� (A-Z) �ȿ��� (0-9)������ӵ���ΤߤǤ���<br><input name="text_text" value="#{h @conf['tdiarygraph_f.text_text']}" size="20"></p>
		<p>�����ȥ�ƥ����Ȥο� (FFFFFF)<br><input name="text_rgb" value="#{h @conf['tdiarygraph_f.text_rgb']}" size="20"></p>
		<h3 class="subtitle">��ݡ��ȥƥ�����</h3>
		<p>��ݡ��Ȥ�ɽ��̵ͭ (ɽ��)<br><select name="text_report">
		<option value="1"#{" selected" if @conf['tdiarygraph_f.text_report'] != "0"}>ɽ��</option>
		<option value="0"#{" selected" if @conf['tdiarygraph_f.text_report'] == "0"}>��ɽ��</option>
		</select></p>
		<p>��ݡ��ȥƥ����Ȥο� (CCCCCC)<br><input name="text_report_rgb" value="#{h @conf['tdiarygraph_f.text_report_rgb']}" size="20"></p>
		<h3 class="subtitle">��ݡ��Ƚ񼰤Υ������ޥ���</h3>
		<p>����������������֤˥ǡ�����Ÿ������ޤ���<br>���ѽ����ʸ�� (���������) �ϡ�����ʸ�� (A-Z) �ȿ��� (0-9)������ӵ���ΤߤǤ���<br><input name="text_report_format" value="#{h @conf['tdiarygraph_f.text_report_format']}" size="70"></p>
		<p>[ ���ѽ���륿�� ] &lt;firstday&gt; : ������, &lt;lastday&gt; : ���ǽ���, &lt;days&gt; : ������, &lt;total&gt; : �߷ץ���������, &lt;peak&gt; : ���̺��祢��������, &lt;br&gt; : ����</p>
		<hr>
		<h3 class="subtitle">�طʤ�������դο�</h3>
		<p>�طʤο� (333333)<br><input name="bg_rgb" value="#{h @conf['tdiarygraph_f.bg_rgb']}" size="20"></p>
		<p>�طʤ���Ʃ���� (100)<br><input name="bg_alpha" value="#{h @conf['tdiarygraph_f.bg_alpha']}" size="20"></p>
		<p>�طʤ����� (��ɽ��)<br><select name="bg_frame">
		<option value="0"#{" selected" if @conf['tdiarygraph_f.bg_frame'] == "0" or @conf['tdiarygraph_f.bg_frame'] == nil or @conf['tdiarygraph_f.bg_frame'] == ""}>��ɽ��</option>
		<option value="1"#{" selected" if @conf['tdiarygraph_f.bg_frame'] == "1"}>���Ⱦ��ɽ��</option>
		</select></p>
		<p>���̥���������������դο� (CCCCCC)<br><input name="bar_rgb" value="#{h @conf['tdiarygraph_f.bar_rgb']}" size="20"></p>
		<p>���̥���������������դ���Ʃ���� (100)<br><input name="bar_alpha" value="#{h @conf['tdiarygraph_f.bar_alpha']}" size="20"></p>
		<p>�߷ץ���������������դο� (666666)<br><input name="line_rgb" value="#{h @conf['tdiarygraph_f.line_rgb']}" size="20"></p>
		<p>�߷ץ���������������դ���Ʃ���� (100)<br><input name="line_alpha" value="#{h @conf['tdiarygraph_f.line_alpha']}" size="20"></p>
		<hr>
		<h3 class="subtitle">������դ�����</h3>
		<p>���̥���������������դ������������ͤǻ��ꤷ�ޤ���<br><input name="bar_width" value="#{h @conf['tdiarygraph_f.bar_width']}" size="20"></p>
		<p>�߷ץ���������������դ������������ͤǻ��ꤷ�ޤ���<br><input name="line_width" value="#{h @conf['tdiarygraph_f.line_width']}" size="20"></p>
		<hr>
		<h3 class="subtitle">�⥢���к�</h3>
		<p>������դ�����������Ū����Ĵ�����ޤ���(0) ���ꤷ���ͤ��Ф�����������˥����ѹ������櫓�ǤϤ���ޤ���<br><br><input name="bold" value="#{h @conf['tdiarygraph_f.bold']}" size="20"></p>
		<hr>
		<h3 class="subtitle">��ˡ���ID ����Ѥ����ե��������</h3>
		<p>�ե���������Υꥯ�����Ȥ˥�ˡ���ID (�㤨�� ?#{Time.now.to_i}) ��ޤ�뤳�Ȥˤ�ꡢ�Ť��ե����뤬�֥饦���˥���å��夵�줿�ޤޤˤʤ�Τ��ɤ��ޤ���FLASH �Υ�ˡ���ID �ϥץ�ե����������ˡ����ե�����Υ�ˡ���ID �ϥ���ȥ���Ͽ���˹�������ޤ���</p>
		<p>��ˡ���ID ���ղ� (�ղä���)<br><select name="uid">
		<option value="1"#{" selected" if @conf['tdiarygraph_f.uid'] != "0"}>�ղä���</option>
		<option value="0"#{" selected" if @conf['tdiarygraph_f.uid'] == "0"}>�ղä��ʤ�</option>
		</select></p>
		<hr>
		<h3 class="subtitle">�ץ�ӥ塼</h3>
		<p>ɽ�������� FLASH �ե����� (.swf) �� tdiary.rb ��Ʊ���ե�����˥��åץ��ɤ���Ƥ���ɬ�פ�����ޤ����ޤ��������󥿥��ե����뤬 FLASH �ե������Ʊ���ե������ž������Ƥ��ʤ����ˤϥ���դ�ɽ������ޤ���</p>
		<p>�ץ�ӥ塼 (��ɽ��)<br><select name="preview">
		<option value="0"#{" selected" if @conf['tdiarygraph_f.preview'] != "1"}>��ɽ��</option>
		<option value="1"#{" selected" if @conf['tdiarygraph_f.preview'] == "1"}>ɽ��</option>
		</select></p>
	HTML

end


def tdiarygraph_flashstyle_preview
	unless @conf.mobile_agent?
	<<-r
		<p>#{if @conf['tdiarygraph_f.preview'] == "1" then "#{tdiarygraph_flashstyle}" else "�ץ�ӥ塼ɽ����ͭ���ˤ���ȡ������� FLASH ��ɽ������ޤ���" end}</p>
	r
	end
end


def tdiarygraph_flashstyle_templete( filename="tdiarygraph468x60e.swf",  argvs="", width="468", height="60" )
	<<-r
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="#{h width}" height="#{h height}" id="tdiarygraph" align="middle">
		<param name="allowScriptAccess" value="sameDomain" />
		<param name="movie" value="#{h filename}#{h argvs}" />
		<param name="play" value="false" />
		<param name="loop" value="false" />
		<param name="quality" value="high" />
		<param name="wmode" value="transparent" />
		<param name="bgcolor" value="#ffffff" />
		<embed src="#{h filename}#{h argvs}" play="false" loop="false" quality="high" wmode="transparent" bgcolor="#ffffff" width="#{h width}" height="#{h height}" name="tdiarygraph" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object>
	r
end


def tdiarygraph_flashstyle_text_report_format( format="" )
	if format != ""
		r = format.gsub('<', '&lt;').gsub('>', '&gt;').gsub(' ', '+')
	end
end
