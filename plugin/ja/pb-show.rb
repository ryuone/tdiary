# Japanese resource of pb-show.rb
#

def pingback_today; '������PingBacks'; end
def pingback_total( total ); "(��#{total}��)"; end
def pb_show_conf_html
  <<-"HTML"
  <h3 class="subtitle">PingBack ���󥫡�</h3>
  #{"<p>¾��weblog�����PingBack����Ƭ����������롢����ѤΥ��󥫡�ʸ�������ꤷ�ޤ����ʤ���&lt;span class=\"tanchor\"&gt;_&lt;/span&gt;�פ���ꤹ��ȡ��ơ��ޤˤ�äƤϼ�ưŪ�˲������󥫡����Ĥ��褦�ˤʤ�ޤ���</p>" unless @conf.mobile_agent?}
  <p><input name="pingback_anchor" value="#{ CGI::escapeHTML(@conf['pingback_anchor'] || @conf.comment_anchor ) }" size="40"></p>
  <h3 class="subtitle">PingBack �ꥹ��ɽ����</h3>
  #{"<p>�ǿ��⤷���Ϸ���ɽ������ɽ�����롢PingBack�κ���������ꤷ�ޤ����ʤ�������ɽ�����ˤϤ����λ���ˤ�����餺����100���PingBack��ɽ������ޤ���</p>" unless @conf.mobile_agent?}
  <p>����<input name="pingback_limit" value="#{ @conf['pingback_limit'] || @conf.comment_limit }" size="3">��</p>
  HTML
end
