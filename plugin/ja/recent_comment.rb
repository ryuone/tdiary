# ja/recent_comment.rb $Revision: 1.3 $
#
# Japanese resources for recent_comment.rb
#
# Copyright (c) 2005 Hiroshi SHIBATA <h-sbt@nifty.com>
# Distributed under the GPL
#

if @mode == 'conf' || @mode == 'saveconf'
   add_conf_proc( 'recent_comment', '�Ƕ�Υĥå���', 'tsukkomi' ) do
      saveconf_recent_comment
      recent_comment_init
      <<-HTML
      <h3 class="subtitle">ɽ������ĥå��ߤο�</h3>
      <p>���� <input name="recent_comment.max" value="#{h( @conf['recent_comment.max'] )}" size="3" /> ��</p>
      <h3 class="subtitle">���եե����ޥå�</h3>
      <p>���ѤǤ���\'%\'ʸ���ˤĤ��Ƥ�<a href="http://www.ruby-lang.org/ja/man/index.cgi?cmd=view;name=Time#strftime">Ruby�Υޥ˥奢��</a>�򻲾ȡ�</p>
      <p><input name="recent_comment.date_format" value="#{h(@conf['recent_comment.date_format'])}" size="40" /></p>
      <h3 class="subtitle">������ɽ�����ʤ�̾��</h3>
      <p>�ꥹ�Ȥ�ɽ�����ʤ�̾������ꤷ�ޤ���</p>
      <p><input name="recent_comment.except_list" size="60" value="#{h( @conf['recent_comment.except_list'] )}" /></p>
      <h3 class="subtitle">��������HTML�Υƥ�ץ졼��</h3>
      <p>�ƥĥå��ߤ�ɤΤ褦��HTML��ɽ�����뤫����ꤷ�ޤ���</p>
      <textarea name="recent_comment.format" cols="70" rows="3">#{h( @conf['recent_comment.format'] )}</textarea>
      <p>�ƥ�ץ졼�����<em>$����</em>�Ϥ��줾��ʲ������Ƥ��֤��������ޤ���ɬ�פΤʤ���Τϻ��ꤷ�ʤ��Ƥ⹽���ޤ���</p>
      <dl>
      <dt>$2</dt><dd>�ĥå��ߤ�URL��</dd>
      <dt>$3</dt><dd>�ĥå��ߤ�û��ɽ��</dd>
      <dt>$4</dt><dd>�ĥå��ߤ����ͤ�̾��</dd>
      <dt>$5</dt><dd>�ĥå��ߤλ�������եե����ޥåȡפǻ��ꤷ��������ɽ������ޤ���</dd>
      </dl>
      HTML
   end
end
