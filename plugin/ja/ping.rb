# ping.rb Japanese resources
@ping_encode = 'UTF-8'
@ping_encoder = Proc::new {|s| NKF::nkf( "-m0 -Ew", s ) }

if /conf/ =~ @mode then
	@ping_label_conf = '��������'
	@ping_label_list = '������ꥹ��'
	@ping_label_list_desc = '�������Τ򤹤�ping�����ӥ���URL��1�ԤˤĤ�1�����Ϥ��Ƥ����������ʤ������ޤꤿ��������ꤹ��ȡ�����ǥ����ॢ���Ȥ��Ƥ��ޤ������Τ�ޤ���'
	@ping_label_timeout = '�����ॢ����(��)'
end

@ping_label_send = '�������������'
