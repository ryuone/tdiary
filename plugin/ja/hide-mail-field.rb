# Japanese resource of hide-mail-field plugin $Revision: 1.3 $

@hide_mail_field_label_conf = '�᡼���󱣤�'

def hide_mail_field_conf_html
	r = <<-HTML
   <h3>�ĥå��ߤ����ʸ</h3>
   <p>�ĥå��ߥե�����ξ��ɽ���������ʸ�����ꤷ�ޤ����᡼���󤬾ä��Ƥ��뤳�Ȥ��ɼԤˤ�������Τ餻�ޤ��礦<br>
   <textarea name="comment_description" cols="70" rows="5">#{h comment_description}</textarea><br>
	��: �ĥå��ߡ������Ȥ�����Фɤ���! spam�к���E-mail��ϱ����Ƥ���ޤ����⤷E-mail�󤬸����Ƥ��Ƥ⡢�������Ϥ��ʤ��ǲ�������</p>
	HTML
end
