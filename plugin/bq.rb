# bq.rb $Revision: 1.5 $
#
# bq: blockquote��Ȥä����Ѥ���������
#   �ѥ�᥿:
#     src:   ���Ѥ���ƥ�����
#     title: ���Ѹ��Υ����ȥ�
#     url:   ���Ѹ���URL
#
#   ���Ѹ������ȥ�򤦤ޤ�ɽ������ˤϡ��������륷���Ȥ�p.source��
#   �������ɬ�פ�����ޤ��������������:
#
#       p.source {
#          margin-top: 0.3em;
#          text-align: right;
#          font-size: 90%;
#       }
#
# Copyright (C) 2002 s.sawada <moonwave@ba2.so-net.ne.jp>
# You can redistribute it and/or modify it under GPL2.
#
def bq( src, title = nil, url = nil )
	if url then
		result = %Q[<blockquote cite="#{h url}" title="#{h title}">\n]
	elsif title
		result = %Q[<blockquote title="#{h title}">\n]
	else
		result = %Q[<blockquote>\n]
	end
	result << %Q[<p>#{src.gsub( /\n/, "</p>\n<p>" )}</p>\n].sub( %r[<p></p>], '' )
	result << %Q[</blockquote>\n]
	if url then
		cite = %Q[<cite><a href="#{h url}" title="#{h bq_cite_from( title )}">#{title}</a></cite>]
		result << %Q[<p class="source">[#{bq_cite_from cite}]</p>\n]
	elsif title
		cite = %Q[<cite>#{title}</cite>]
		result << %Q[<p class="source">[#{bq_cite_from( cite )}]</p>\n]
	end
	result
end

