#	jyear.rb $Revision: 1.1 $
#	
#	�����������Ѵ�����ץ饰����
#	������ĥå��ߤ����եե����ޥåȤǻȤ���
#	��%Y�פǡ�2005�פΤȤ���򡢡�%K�פǡ�ʿ��17�פ�ɽ����
#	plugin������������ư��롣
#	
# Copyright (c) 2005 sasasin/SuzukiShinnosuke<sasasin@sasasin.sytes.net>
# You can distribute this file under the GPL.
#

unless Time::new.respond_to?( :strftime_jyear_backup ) then
	eval( <<-MODIFY_CLASS, TOPLEVEL_BINDING )
		class Time
			alias strftime_jyear_backup strftime
			def strftime( format )
				case self.year
					when 0 .. 1926
						gengo = "�Ρ�"
						if self.year = 1926 && self.month = 12 && self.wday >=25 then
							gengo = "���¸�ǯ"
						end
					when 1927 .. 1989
						jyear = self.year - 1925
						gengo = "����" + jyear.to_s
						if self.year = 1989 && self.month = 1 && self.wday >= 8 then
							gengo = "ʿ����ǯ"
						end
					else
						jyear = self.year - 1988
						gengo = "ʿ��" + jyear.to_s
				end
				strftime_jyear_backup( format.gsub( /%K/, gengo ) )
			end
		end
	MODIFY_CLASS
end