# comment_mail-smtp.rb $Revision: 1.1 $
#
# SMTP�ץ�ȥ����Ȥäƥĥå��ߤ�᡼����Τ餻��
#   ����������ư���
#
# Options:
#   @options['comment_mail.header']
#        �᡼���Subject�˻Ȥ�ʸ���󡣿���ʬ�����������ʤ褦�˻��ꤹ�롣
#        �ºݤ�Subject�ϡֻ���ʸ����:����-1�פΤ褦�ˡ����դȥ������ֹ椬
#        �դ�������������ʸ������ˡ�%��³���ѻ������ä���硢�����
#        ���եե����ޥåȻ���򸫤ʤ����Ĥޤ�����աפ���ʬ��
#        ��ưŪ���ղä���ʤ��ʤ�(�������ֹ���ղä����)��
#        ̵������ˤ϶�ʸ����
#   @options['comment_mail.receivers']
#        �᡼������륢�ɥ쥹������̵������ˤ�����ɮ�ԤΥ��ɥ쥹�ˤʤ롣
#   @options['comment_mail.smtp_host']
#   @options['comment_mail.smtp_port']
#        ���줾�졢�᡼�������˻Ȥ�SMTP�����ФΥۥ���̾�ȥݡ����ֹ档
#        ̵������Ϥ��줾���'localhost'�֤ȡ�25�ס�
#
# Copyright (c) 2003 TADA Tadashi <sho@spc.gr.jp>
# You can distribute this file under the GPL.
#
def comment_mail( text )
	begin
		require 'net/smtp'
		host = @options['comment_mail.smtp_host'] || 'localhost'
		port = @options['comment_mail.smtp_port'] || 25
		Net::SMTP.start( host, port ) do |smtp|
			smtp.send_mail( text, @conf.author_mail, @options['comment_mail.receivers'] )
		end
	rescue
		$stderr.puts $!
	end
end

if @mode == 'comment' and @comment then
	@options['comment_mail.smtp_host'] = @conf.smtp_host || 'localhost'
	@options['comment_mail.smtp_port'] = @conf.smtp_port || 25
	comment_mail_send
end

