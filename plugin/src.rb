# src.rb $Revision: 1.3 $
#
# src: �����ե��������������(HTML�����������դ�)
#   �ѥ�᥿:
#     file: �ե�����̾
#
# Copyright (c) 2005 TADA Tadashi <sho@spc.gr.jp>
# You can distribute this file under the GPL2.
#
def src( file )
	h( File::readlines( file ).join )
end

#
# src_inline: �ƥ����Ȥ���������(HTML�����������դ�)
#
# �ѥ�᥿: �ƥ�����ʸ����
#
def src_inline( str )
	h( str )
end

