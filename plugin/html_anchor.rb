# html_anchor $Revision: 1.6 $
#
# anchor: ���󥫡����YYYYMMDD.html�ס�YYYYMM.html�׷������֤�������
#         tDiary���鼫ưŪ�˸ƤӽФ����Τǡ��ץ饰����ե������
#         ���֤�������Ǥ褤�����Υץ饰�����ͭ���˻Ȥ�����ˤϡ�
#         Web������¦�������ѹ���ɬ�ס�Web�����Ф�����˴ؤ��Ƥϡ�
#         �ʲ��Υ����Ȥ����ͤˤʤ롣
#
#         http://tdiary-users.sourceforge.jp/cgi-bin/wiki.cgi?html%A4%C7%A5%A2%A5%AF%A5%BB%A5%B9%A4%B7%A4%BF%A4%A4
#
# Copyright (c) 2002 TADA Tadashi <sho@spc.gr.jp>
# Distributed under the GPL
#

def anchor( s )
	if /^([\-\d]+)#?([pct]\d*)?$/ =~ s then
		if $2 then
			"#$1.html##$2"
		else
			"#$1.html"
		end
	else
		""
	end
end

