# html_anchor $Revision: 1.1 $
#
# anchor: ���󥫡����YYYYMMDD.html�ס�YYYYMM.html�׷������֤�������
#         tDiary���鼫ưŪ�˸ƤӽФ����Τǡ��ץ饰����ե������
#         ���֤�������Ǥ褤��mod_rewrite�ȹ�碌�����Ѥ��롣
#         ����: http://sho.tdiary.net/20020301.html#p04
#
# Copyright (c) 2002 TADA Tadashi <sho@spc.gr.jp>
# Distributed under the GPL
#

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

