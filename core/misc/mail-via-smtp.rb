=begin
�ڥĥå��ߥ᡼�������᥽�åɤκ������

�����Υե������Ʊ���Ƥ����Ǥ˥ǥե���ȵ�ǽ�Ȥ���ư���褦�ˤʤ�
���Ƥ��ޤ��Τǡ��ºݤ�Ŭ�Ѥ���ɬ�פϤ���ޤ��󡣤����ޤǥ���ץ�Ǥ���

TDiaryComment#sendmail�᥽�åɤ��������뤳�Ȥǡ��᡼�������᥽�å�
���ѹ����뤳�Ȥ���ǽ�Ǥ����ʲ���SMTP��Ȥäƥ᡼�������򤹤���Υ�
��ץ�Ǥ���tdiary.conf��˼��Τ褦�˻��ꤹ�뤳�Ȥ����ѤǤ��ޤ���

   require "#{TDiary::PATH}/misc/mail-via-smtp" 
   @smtp_host = "smtp.example.net" 
   @smtp_port = 25 

���Υ᥽�åɤ�TDiaryComment��ˤ���Τǡ�TDiaryComment��ˤ��륤��
�����ѿ���᥽�åɤ˼�ͳ�˥��������Ǥ��Ƥ��ޤ��ޤ�����갷���ˤϽ�
ʬ��դ��Ƥ���������
=end

module TDiary
	class TDiaryComment
		def sendmail( text )
			return unless @conf.smtp_host
			begin
				require 'net/smtp'
				Net::SMTP.start( @conf.smtp_host, @conf.smtp_port ) do |smtp|
					smtp.ready( @conf.author_mail, @conf.mail_receivers ) do |adapter| adapter.write( text ) end
				end
			rescue
			end
		end
	end
end
