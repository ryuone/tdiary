# Japanese resource of tb-show.rb
#

def tb_show_conf_html
	<<-"HTML"
	<h3 class="subtitle">TrackBack ���󥫡�</h3>
	#{"<p>¾��weblog�����TrackBack����Ƭ����������롢����ѤΥ��󥫡�ʸ�������ꤷ�ޤ����ʤ���&lt;span class=\"tanchor\"&gt;_&lt;/span&gt;�פ���ꤹ��ȡ��ơ��ޤˤ�äƤϼ�ưŪ�˲������󥫡����Ĥ��褦�ˤʤ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><input name="trackback_anchor" value="#{ CGI::escapeHTML(@conf['trackback_anchor'] || @conf.comment_anchor ) }" size="40"></p>
	<h3 class="subtitle">TrackBack ɽ����ˡ</h3>
	#{"<p>�ǿ��⤷���Ϸ��̻���ɽ����ˡ����ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="trackback_shortview_mode">
	#{ [["num_in_reflist", "��󥯸�����˿���ɽ��(���)"],
	    ["num_in_reflist_if_exists",
	     "��󥯸�����˿���ɽ��(1��ʾ�Τ�)"],
	    ["shortlist", "û��������ɽ��"]
	   ].map{ |op|
             "<option value='#{op[0]}' #{'selected' if @conf['trackback_shortview_mode'] == op[0]}>#{op[1]}</option>\n"
	   }.to_s }
	</select></p>
	<h3 class="subtitle">TrackBack �ꥹ��ɽ����</h3>
	#{"<p>�ǿ��⤷���Ϸ���ɽ������ɽ�����롢TrackBack�κ���������ꤷ�ޤ����ʤ�������ɽ�����ˤϤ����λ���ˤ�����餺����100���TrackBack��ɽ������ޤ���</p>" unless @conf.mobile_agent?}
	<p>����<input name="trackback_limit" value="#{ @conf['trackback_limit'] || @conf.comment_limit }" size="3">��</p>
	<h3 class="subtitle">TrackBack URL ��ɽ������</h3>
	#{"<p>�ǿ��⤷���Ϸ���ɽ������ TrackBackURL ��ɽ�����뤫�ɤ�������ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="trackback_disp_pingurl">
	<option value="true" #{'selected' if @conf['trackback_disp_pingurl']}>ɽ��</options>
	<option value="false" #{'selected' if !@conf['trackback_disp_pingurl']}>��ɽ��</options>
	</select></p>
	HTML
end
