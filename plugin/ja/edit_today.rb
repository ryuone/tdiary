# Japanese resources of edit_today plugin.

@edit_today_caption = '���������Խ�'

def edit_today_edit_label( date )
	date.strftime( '%Y-%m-%d���Խ�' )
end

def edit_today_conf_html
	r = <<-HTML
	<h3 class="subtitle">���ʸ����</h3>
	<p>�Խ��ڡ����ؤΥ�󥯤򼨤�ʸ�������ꤷ�ޤ����������ѰդǤ���С���������ʤɤ�������ޤ���</p>
	<p><input name="edit_today_caption" size="70" value="#{h @conf['edit_today.caption']}"></p>
	HTML
end
