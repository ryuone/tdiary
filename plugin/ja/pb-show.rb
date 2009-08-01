# Japanese resource of pb-show.rb
#

def pingback_today; '������Pingbacks'; end
def pingback_total( total ); "(��#{total}��)"; end
def pb_show_conf_html
  <<-"HTML"
  <h3 class="subtitle">Pingback ���󥫡�</h3>
  #{"<p>¾��weblog�����Pingback����Ƭ����������롢����ѤΥ��󥫡�ʸ�������ꤷ�ޤ����ʤ���&lt;span class=\"tanchor\"&gt;_&lt;/span&gt;�פ���ꤹ��ȡ��ơ��ޤˤ�äƤϼ�ưŪ�˲������󥫡����Ĥ��褦�ˤʤ�ޤ���</p>" unless @conf.mobile_agent?}
  <p><input name="pingback_anchor" value="#{ h(@conf['pingback_anchor'] || @conf.comment_anchor ) }" size="40"></p>
  <h3 class="subtitle">Pingback �ꥹ��ɽ����</h3>
  #{"<p>�ǿ��⤷���Ϸ���ɽ������ɽ�����롢Pingback�κ���������ꤷ�ޤ����ʤ�������ɽ�����ˤϤ����λ���ˤ�����餺����100���Pingback��ɽ������ޤ���</p>" unless @conf.mobile_agent?}
  <p>����<input name="pingback_limit" value="#{ h(@conf['pingback_limit'] || @conf.comment_limit ) }" size="3">��</p>
  HTML
end
