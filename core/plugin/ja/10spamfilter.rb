#
# ja/spamfilter.rb: resource of ja $Revision: 1.16 $
#

@spamfilter_label_conf = 'spam�ե��륿'

def spamfilter_conf_html
	r = <<-HTML
	<h3>spam�ΰ���</h3>
	<p>spam��Ƚ�ꤵ�줿�ĥå��ߤ�
		<select name="spamfilter.filter_mode">
			<option value="true"#{" selected" if @conf['spamfilter.filter_mode']}>��ɽ���ˤ���</option>
			<option value="false"#{" selected" unless @conf['spamfilter.filter_mode']}>�ΤƤ�</option>
	</select></p>

	<h3>���Ƥˤ��ե��륿</h3>
	<p>�ĥå������URL�ο���<input type="text" name="spamfilter.max_uris" value="#{h @conf['spamfilter.max_uris']}" size="5">�Ĥ�Ķ������spam�Ȥߤʤ�</p>
	<p>�ĥå������URL��ɽ��ʸ���������礬<input type="text" name="spamfilter.max_rate" value="#{h @conf['spamfilter.max_rate']}" size="5">%���⤤��Τ�spam�Ȥߤʤ�</p>
	<p>�ĥå�����ʸ���ʲ��Υѥ���������ƤϤޤ����spam�Ȥߤʤ�������ɽ�������ѤǤ��ޤ�<br>
		<textarea name="spamfilter.bad_comment_patts" cols="70" rows="5">#{h( @conf['spamfilter.bad_comment_patts'] || '' )}</textarea></p>
	<p>�ĥå��ߤΥ᡼�륢�ɥ쥹���ʲ��Υѥ���������ƤϤޤ����spam�Ȥߤʤ�������ɽ�����Ȥ��ޤ�<br>
		<textarea name="spamfilter.bad_mail_patts" cols="70" rows="5">#{h( @conf['spamfilter.bad_mail_patts'] || '' )}</textarea></p>
	<p>�ĥå��ߤ��󥯸��˴ޤޤ��URL�ˡ��ʲ��Υѥ����󤬴ޤޤ�����spam�Ȥߤʤ�<br>
		<textarea name="spamfilter.bad_uri_patts" cols="70" rows="5">#{h( @conf['spamfilter.bad_uri_patts'] || '' )}</textarea></p>
	<p>��Υѥ������ĥå��ߤΥ᡼�륢�ɥ쥹�Υ����å��ˤ�
		<select name="spamfilter.bad_uri_patts_for_mails">
			<option value="true"#{" selected" if @conf['spamfilter.bad_uri_patts_for_mails']}>���Ѥ���</option>
			<option value="false"#{" selected" unless @conf['spamfilter.bad_uri_patts_for_mails']}>���Ѥ��ʤ�</option>
		</select></p>
	<p>TrackBack��������<select name="spamfilter.linkcheck">
		<option value="0"#{' selected' if @conf['spamfilter.linkcheck'] == 0}>���Ƥ�����å������ˤ��٤Ƽ�������</option>
		<option value="1"#{' selected' if @conf['spamfilter.linkcheck'] == 1}>��˼������ȤؤΥ�󥯤�����м�������</option>
	</select></p>

	<h3>���դ��ˤ��ե��륿</h3>
	<p><input type="text" name="spamfilter.date_limit" value="#{h @conf['spamfilter.date_limit']}" size="5">���ʾ��������դ��ؤΥĥå��ߤ�spam�Ȥߤʤ�<br>(��������¤ʤ���0�������Τ�)</p>
	<p>�������������Υĥå��ߥե������
		<select name="spamfilter.hide_commentform">
			<option value="true"#{" selected" if @conf['spamfilter.hide_commentform']}>����</option>
			<option value="false"#{" selected" unless @conf['spamfilter.hide_commentform']}>�����ʤ�</option>
		</select>

	<h3>IP���ɥ쥹�ˤ��ե��륿</h3>
	<p>�ĥå��ߤ�TrackBack��������IP���ɥ쥹�����ʲ��Υѥ���������ƤϤޤ����spam�Ȥߤʤ�(�ꥹ�Ȥˤϴ�����IP���ɥ쥹�ޤ��ϡ�.�פǽ����IP���ɥ쥹�ΰ����򵭽Ҥ���)<br>
		<textarea name="spamfilter.bad_ip_addrs" cols="70" rows="5">#{h( @conf['spamfilter.bad_ip_addrs'] || '' )}</textarea></p>
	</p>
	<p>TrackBack�������ȼºݤΥ����Ȥ�IP���ɥ쥹���ۤʤ����
		<select name="spamfilter.resolv_check">
			<option value="true"#{" selected" if @conf['spamfilter.resolv_check']}>spam�Ȥߤʤ�</option>
			<option value="false"#{" selected" unless @conf['spamfilter.resolv_check']}>spam�Ȥߤʤ��ʤ�</option>
		</select>
	</p>
	<p>��ξ��ˤ�ä�spam�Ȥߤʤ��줿TrackBack��
		<select name="spamfilter.resolv_check_mode">
			<option value="true"#{" selected" if @conf['spamfilter.resolv_check_mode']}>��ɽ���ˤ���</option>
			<option value="false"#{" selected" unless @conf['spamfilter.resolv_check_mode']}>�ΤƤ�</option>
		</select>
	</p>
   <h3>�֥�å��ꥹ�ȥ����ӥ���Ȥä��ե��륿</h3>
   <p>�֥�å��ꥹ���䤤��碌�����С�����ꤷ�ޤ�<br>
   <textarea name="spamlookup.domain.list" cols="70" rows="5">#{h @conf['spamlookup.domain.list']}</textarea></p>
   <p>�ʲ��˻��ꤷ���ɥᥤ��ϥ֥�å��ꥹ�Ȥ��䤤��碌�ޤ��󡣸������󥸥�������ꤷ�Ƥ�������<br>
   <textarea name="spamlookup.safe_domain.list" cols="70" rows="5">#{h @conf['spamlookup.safe_domain.list']}</textarea></p>
   <h3>�ĥå��ߤ����ʸ</h3>
   <p>�ĥå��ߥե�����ξ��ɽ���������ʸ�����ꤷ�ޤ���spamȽ������ѹ��������ˡ��ɼԤˤ���򤭤�����Τ餻�ޤ��礦<br>
   <textarea name="comment_description" cols="70" rows="5">#{h comment_description}</textarea></p>
   HTML
   
	unless @conf.secure then
	r << <<-HTML
	<h3>�ե��륿�Υ�</h3>
	<p>�ե��륿�Υ���ʲ��Υե������
		<select name="filter.debug_mode">
			<option value="0"#{" selected" if @conf['filter.debug_mode'] == 0}>��Ͽ���ʤ�</option>
			<option value="1"#{" selected" if @conf['filter.debug_mode'] == 1}>spam������Ͽ����</option>
			<option value="2"#{" selected" if @conf['filter.debug_mode'] == 2}>���٤Ƶ�Ͽ����</option>
		</select></p>
	<p>�ե�����̾: <input type="text" name="filter.debug_file" value="#{h( @conf['filter.debug_file'] || '' )}" size="50"></p>
	HTML
	end

	r
end
