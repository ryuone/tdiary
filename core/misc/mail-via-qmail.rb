=begin
�ڥĥå��ߥ᡼�������᥽�åɤκ���� - qmail�ǡ�

����բ�
���Υ᥽�åɤϡ�Web�����Фθ��¤Ǽ¹Ԥ���ȼ��Ԥ��뤫���Τ�ޤ���

TDiaryComment#sendmail�᥽�åɤ��������뤳�Ȥǡ��᡼�������᥽�å�
���ѹ����뤳�Ȥ���ǽ�Ǥ����ʲ���qmail-inject��Ȥäƥ᡼�������򤹤�
���Υ���ץ�Ǥ���tdiary.conf��˼��Τ褦�˻��ꤹ�뤳�Ȥ����ѤǤ�
�ޤ���

   require "#{TDiary::PATH}/misc/mail-via-qmail" 
   @qmail_inject = "/var/qmail/bin/qmail-inject" 

���Υ᥽�åɤ�TDiaryComment��ˤ���Τǡ�TDiaryComment��ˤ��륤��
�����ѿ���᥽�åɤ˼�ͳ�˥��������Ǥ��Ƥ��ޤ��ޤ�����갷���ˤϽ�
ʬ��դ��Ƥ���������
=end

module TDiary
	class TDiaryComment
		def sendmail( text )
			return unless @conf.qmail_inject
			begin
				open( "|#{@conf.qmail_inject} #{@conf.mail_receivers.join(' ')}", 'w' ) do |o|
					o.write( text )
				end
			rescue
			end
		end
	end
end
