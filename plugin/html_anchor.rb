# html_anchor $Revision: 1.3 $
#
# anchor: ���󥫡����YYYYMMDD.html�ס�YYYYMM.html�׷������֤�������
#         tDiary���鼫ưŪ�˸ƤӽФ����Τǡ��ץ饰����ե������
#         ���֤�������Ǥ褤�����Υץ饰�����ͭ���˻Ȥ�����ˤϡ�
#         Web������¦�������ѹ���ɬ�ס�Apache��Ȥ���硢�ʲ���2�Ĥ�
#         ��ˡ���Τ��Ƥ��롣
#
#         (1) mod_rewrite�ȹ�碌�����Ѥ���(�侩)
#             ����: http://sho.tdiary.net/20020301.html#p04
#
#         (2) ErrorDocument�����Ѥ���
#             ������°��dot.htaccess�Υ����Ȥ򻲾�
#
# Copyright (c) 2002 TADA Tadashi <sho@spc.gr.jp>
# Distributed under the GPL
#

def anchor( s )
	if /^(\d+)#?([pct]\d*)?$/ =~ s then
		if $2 then
			"#$1.html##$2"
		else
			"#$1.html"
		end
	else
		""
	end
end

