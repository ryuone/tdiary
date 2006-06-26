#
# ja/spamfilter.rb: resource of ja $Revision: 1.8 $
#

@spamfilter_label_conf = 'spam�ե��륿'

def spamfilter_conf_html
	r = <<-HTML
	<h3>����</h3>
	<p>spam��Ƚ�ꤵ�줿�ĥå��ߤν�����ˡ��<br>
		<select name="spamfilter.filter_mode">
			<option value="true"#{" selected" if @conf['spamfilter.filter_mode']}>��ɽ���ˤ���</option>
			<option value="false"#{" selected" unless @conf['spamfilter.filter_mode']}>�ΤƤ�</option>
	</select></p>
	<p>�ĥå�����˰ʲ����ͤ��¿����URI���ޤޤ���Τ�spam�Ȥߤʤ���<br>
		<input type="text" name="spamfilter.max_uris" value="#{CGI.escapeHTML(@conf['spamfilter.max_uris'].to_s)}" size="5"></p>
	<p>�ĥå��ߤ����URI��ɽ��ʸ����(�Х��ȿ�)�������礬�ʲ����ͤ������⤤��Τ�spam�Ȥߤʤ���<br>
		<input type="text" name="spamfilter.max_rate" value="#{CGI.escapeHTML(@conf['spamfilter.max_rate'].to_s)}" size="5"></p>
	<p>�ʲ�����󤵤줿�ѥ������Ȥäƹ��������ѥ�����˥ޥå�����URI��ޤ�ĥå��ߤ�spam�Ȥߤʤ����ºݤ˻��Ѥ����ѥ�����ˤĤ��Ƥ�update_config�᥽�åɤ򻲾ȡ�<br>
		<textarea name="spamfilter.bad_uri_patts" cols="70" rows="8">#{CGI.escapeHTML(@conf['spamfilter.bad_uri_patts'] || '')}</textarea></p>
	<p>�ĥå�����ʸ���ʲ�����󤵤줿�ѥ�����˥ޥå��������spam�Ȥߤʤ���<br>
		<textarea name="spamfilter.bad_comment_patts" cols="70" rows="8">#{CGI.escapeHTML(@conf['spamfilter.bad_comment_patts'] || '')}</textarea></p>
	<p>�ĥå��ߤΥ᡼�륢�ɥ쥹���ʲ�����󤵤줿�ѥ�����˥ޥå��������spam�Ȥߤʤ���<br>
		<textarea name="spamfilter.bad_mail_patts" cols="70" rows="8">#{CGI.escapeHTML(@conf['spamfilter.bad_mail_patts'] || '')}</textarea></p>
	<p>�ĥå��ߤΥ᡼�륢�ɥ쥹�Υ����å���URI�ѤΥѥ��������Ѥ��롣<br>
		<select name="spamfilter.bad_uri_patts_for_mails">
			<option value="true"#{" selected" if @conf['spamfilter.bad_uri_patts_for_mails']}>����</option>
			<option value="false"#{" selected" unless @conf['spamfilter.bad_uri_patts_for_mails']}>����</option>
		</select></p>

	<h3>���դ�</h3>
	<p>�ʲ������դ��ؤΥĥå��ߤ�spam�Ȥߤʤ���<br>
		<input type="text" name="spamfilter.date_limit" value="#{CGI.escapeHTML(@conf['spamfilter.date_limit'].to_s)}" size="5">����(��������¤ʤ���0�������Τ�)</p>

	<h3>IP���ɥ쥹</h3>
	<p>�ĥå��ߤ�TrackBack����������IP���ɥ쥹���ʲ��Υꥹ�Ȥ˥ޥå��������spam�Ȥߤʤ�(�ꥹ�Ȥˤϴ�����IP���ɥ쥹�ޤ��ϡ�.�פǽ����IP���ɥ쥹�ΰ����򵭽Ҥ���)��<br>
		<textarea name="spamfilter.bad_ip_addrs" cols="70" rows="8">#{CGI.escapeHTML(@conf['spamfilter.bad_ip_addrs'] || '')}</textarea></p>
	</p>
	<p>TrackBack��������IP���ɥ쥹�ȼºݤΥ����Ȥ�IP���ɥ쥹���ޥå����ʤ�����spam�Ȥߤʤ���<br>
		<select name="spamfilter.resolv_check">
			<option value="true"#{" selected" if @conf['spamfilter.resolv_check']}>����</option>
			<option value="false"#{" selected" unless @conf['spamfilter.resolv_check']}>����</option>
		</select>
	</p>
	<p>IP���ɥ쥹���ˤ�ä�spam�Ȥߤʤ��줿�ȥ�å��Хå��ν�����ˡ��<br>
		<select name="spamfilter.resolv_check_mode">
			<option value="true"#{" selected" if resolv_check_mode}>��ɽ���ˤ���</option>
			<option value="false"#{" selected" unless resolv_check_mode}>�ΤƤ�</option>
		</select>
	</p>
   <h3>Domain Blacklist Services</h3>
   <p>Domain Blacklist �����Ѥ��륵���С�����ꤷ�ޤ���ʣ���Υ����С�����ꤹ����ϲ��ԤǶ��ڤ�ɬ�פ�����ޤ���</p>
   <p><textarea name="spamlookup.domain.list" cols="70" rows="5">#{CGI::escapeHTML( @conf['spamlookup.domain.list'] )}</textarea></p>
   <p>DNSBL���䤤��碌��Ԥ�ʤ��ۥ��Ȥ���ꤷ�ޤ����������󥸥�������ꤷ�Ƥ���������</p>
   <p><textarea name="spamlookup.safe_domain.list" cols="70" rows="5">#{CGI::escapeHTML( @conf['spamlookup.safe_domain.list'] )}</textarea></p>
   HTML
   
	unless @conf.secure then
	r << <<-HTML
	<h3>�ǥХå�</h3>
	<p>�ǥХå��⡼�ɡ�<br>
		<select name="spamfilter.debug_mode">
			<option value="true"#{" selected" if @conf['spamfilter.debug_mode']}>����</option>
			<option value="false"#{" selected" unless @conf['spamfilter.debug_mode']}>����</option>
		</select></p>
	<p>�ǥХå�����Ͽ����ե�����Υե�����̾��<br>
		<input type="text" name="spamfilter.debug_file" value="#{CGI.escapeHTML(@conf['spamfilter.debug_file'] || '')}" size="30"></p>
	HTML
	end

	r
end
