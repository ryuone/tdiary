# comment_mail_sendmail.rb $Revision: 1.1 $
#
# sendmail��Ȥäƥĥå��ߤ�᡼����Τ餻��
#   ����������ư��롣
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
#   @options['comment_mail.sendmail']
#        sendmail���ޥ�ɤΥѥ�����ꤹ�롣
#        ̵������ˤϡ�'/usr/sbin/sendmail'�ס�
#
# Copyright (c) 2003 TADA Tadashi <sho@spc.gr.jp>
# You can distribute this file under the GPL.
#
def comment_mail( text )
	begin
		sendmail = @options['comment_mail.sendmail'] || '/usr/sbin/sendmail'
		receivers = @options['comment_mail.receivers']
		open( "|#{sendmail} #{receivers.join(' ')}", 'w' ) do |o|
			o.write( text )
		end
	rescue
		$stderr.puts $!
	end
end

if @mode == 'comment' and @comment then
	comment_mail_send
end
