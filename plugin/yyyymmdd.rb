# yyyymmdd.rb $Revision: 1.1 $
#
# yyyymmdd: ���󥫡���URL��YYYYMMDD.html�������ѹ�����
#   plugin�ǥ��쥯�ȥ�˥��ԡ����������OK
#   ���Υץ饰���������뤳�Ȥǡ���ȡ������ȤΥڡ�����URL��
#   YYYYMM.html��YYYYMMDD.html��ؤ��褦���ѹ�����롣����URL��
#   �ƤӽФ���Ƥ⤭�����ư���褦�ˡ�Web������¦���ѹ���ɬ
#   �ס�Apache�ξ���mod_rewrite��Ȥäƽ񤭴����뤳�Ȥ�侩��
#   �뤬��ErrorDocument��Ȥä���ˡ�⤢��(dot.htaccess�Υ�����
#   �򻲾�)��
# 
# Copyright (C) 2002 by TADA Tadashi <sho@spc.gr.jp>
#
=begin ChangeLog
2002-10-12 TADA Tadashi <sho@spc.gr.jp>
	* 1st release.
=end

def anchor( s )							 
	if /^(\d+)#?([pc]\d*)?$/ =~ s then
		if $2 then
			"#$1.html##$2"
		else	  
			"#$1.html"
		end											  
	else 
		""
	end
end			  

