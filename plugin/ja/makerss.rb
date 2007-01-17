# makerss.rb Japanese resources
@makerss_encode = 'UTF-8'
@makerss_encoder = Proc::new {|s| NKF::nkf( "-m0 -Ew", s ) }

def makerss_tsukkomi_label( id )
	"#{id[0,4]}-#{id[4,2]}-#{id[6,2]}�Υĥå���[#{id[/[1-9]\d*$/]}]"
end

@makerss_conf_label = '�ե�����(RSS)������'

def makerss_conf_html
	<<-HTML
	<h3>�ե�����(RSS)������</h3>
	<p>�ե����ɤ�¾�Υץ������ɤߤ䤹�����ǡ����������Ƥ�������ޤ����ե����ɤ˴ޤޤ�����ϥե����ɥ꡼�������ɤޤ줿�ꡢ�������Υ����Ȥ�ž�ܤ��줿�ꤷ�����Ѥ���Ƥ��ޤ���</p>
	#{%Q[<p class="message">��#{@makerss_full.file}�פ˽񤭹���ޤ���<br>���Υե������Web�����Фˤ�äƽ񤭹��߲�ǽ�Ǥʤ���Фʤ�ޤ���</p>] unless @makerss_full.writable?}
	<ul>
	<li>�ե����ɤ���ʸ���Τ�<select name="makerss.hidecontent">
		<option value="f"#{' selected' unless @conf['makerss.hidecontent']}>�ޤ��</option>
		<option value="t"#{' selected' if @conf['makerss.hidecontent']}>�ޤ�ʤ�</option></select></li>
	<li>�ե����ɤ˴ޤ��������<select name="makerss.shortdesc">
		<option value="f"#{' selected' unless @conf['makerss.shortdesc']}>�Ǥ������Ĺ������</option>
		<option value="t"#{' selected' if @conf['makerss.shortdesc']}>�ǽ�����ˤ���</option></select></li>
      <li>��#{ comment_new }�פȤ�����󥯤�����<select name="makerss.comment_link">
		<option value="f"#{' selected' unless @conf['makerss.comment_link']}>����</option>
		<option value="t"#{' selected' if @conf['makerss.comment_link']}>���ʤ�</option></select></li>
	</ul>

	<h3>�ĥå���ȴ���Υե�����</h3>
	<p>ɸ��Υե����ɤˤϡ����ʤ����񤤤�������ʸ�����Ǥʤ����ɼԤˤ��ĥå��ߤ�ޤޤ�ޤ����⤷�ĥå��ߤ�ޤޤʤ��ե����ɤ��ۿ��������ΤǤ���С�����������ꤷ�Ƥ����������ʤ���ɸ��Υե����ɤ���ʸ��ޤ���ˤϥĥå��ߤ���ʸ�ۿ����졢�����Ǥʤ����ˤϥĥå��ߤ����դ���ƼԤΤߤ��ۿ�����ޤ���</p>
	#{%Q[<p class="message">��#{@makerss_no_comments.file}�פ˽񤭹���ޤ���<br>���Υե������Web�����Фˤ�äƽ񤭹��߲�ǽ�Ǥʤ���Фʤ�ޤ���</p>] if @conf['makerss.no_comments'] and !@makerss_no_comments.writable?}
	<ul>
	<li>�ĥå���ȴ���Υե����ɤ�<select name="makerss.no_comments">
		<option value="t"#{' selected' if @conf['makerss.no_comments']}>�ۿ�����</option>
		<option value="f"#{' selected' unless @conf['makerss.no_comments']}>�ۿ����ʤ�</option></select></li>
	</ul>
   HTML
end

@makerss_edit_label = '����äȤ�������(RSS�򹹿����ʤ�)'
