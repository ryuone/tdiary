# jmonth.rb $Revision: 1.1 $
#
#��%i�פ����ܸ�α����̾��Ф�
#    plugin������������ư��롣
#    ���եե����ޥåȤʤɤǡ�%i�פ���ꤹ��Ȥ����������̾�ˤʤ�
#
# Copyright (c) 2005 sasasin/SuzukiShinnosuke<sasasin@sasasin.sytes.net>
# You can distribute this file under the GPL.
#
unless Time::new.respond_to?( :strftime_jmonth_backup ) then
	eval( <<-MODIFY_CLASS, TOPLEVEL_BINDING )
		class Time
		   alias strftime_jmonth_backup strftime
		   JMONTH = %w(�ӷ� ǡ�� ���� ���� ���� ��̵�� ʸ�� �շ� Ĺ�� ��̵�� ���� ����)
		   def strftime( format )
		      strftime_jmonth_backup( format.gsub( /%i/, JMONTH[self.month-1] ) )
		   end
		end
	MODIFY_CLASS
end
