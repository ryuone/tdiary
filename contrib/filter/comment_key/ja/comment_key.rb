# Japanese resource of comment_key.rb
#
# Copyright (c) 2005 Hahahaha <rin_ne@big.or.jp>
# Distributed under the GPL
#

@comment_key_label_conf = '�����ȥ����ե��륿'

def comment_key_conf_html
	<<-"HTML"
		<h3 class="subtitle">#{@comment_key_label_conf}</h3>
		<p><input type="checkbox" name="comment_key_enable" value="true" #{'checked' if @conf['comment_key.enable']}>�����ȥ����ե��륿��ͭ���ˤ���</p>
		<p>�����ȥ����ե��륿�Τ���˻��Ѥ���븰����Ƭʸ�������ꤷ�ޤ����ʤ�������ʸ�����MD5�ˤƥ��󥳡��ɤ���뤿�ᡢ����HTML���ľ��ɽ������뤳�ȤϤ���ޤ���</p>
		<p><input name="comment_key_prefix" value="#{h( @conf['comment_key.prefix'] || 'tdiary' )}" size="40"></p>
		<p><input type="checkbox" name="comment_key_nodate" value="true" #{'checked' if @conf['comment_key.nodate']}>���Ʊ��θ�ʸ�������������</p>
	HTML
end
