# edit.rb $Revision: 1.1 $
#
# navi_admin: ����ɽ���ǡֹ����פ���Խ��פ��֤������롣��������������
#             �������Խ��Ǥ��ޤ������Υե������plugin�˥��ԡ��������
#             �Ǽ�ưŪ���֤��Ѥ��ޤ���
#
def navi_admin
	if @mode == 'day' then
		result = %Q[<span class="adminmenu"><a href="#{@update}?edit=true;year=#{@date.year};month=#{@date.month};day=#{@date.day}">�Խ�</a></span>\n]
	else
		result = %Q[<span class="adminmenu"><a href="#{@update}">����</a></span>\n]
	end
	result << %Q[<span class="adminmenu"><a href="#{@update}?conf=OK">����</a></span>\n] if /^(latest|month|day|comment)$/ !~ @mode
	result
end
