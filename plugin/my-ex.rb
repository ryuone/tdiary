# my-ex.rb $Revision: 1.1 $
#
# my(��ĥ��): my�ץ饰������ĥ����title°���˻���������Ƥ��������ޤ���
#             �����褬���������ξ���(�����)���֥����ȥ��
#             �ĥå��ߤξ��ϥĥå�����ͤ�̾�������Ƥΰ�����Ȥ��ޤ���
# �ѥ�᥿:
#   a:   ��ʬ��������Υ�������('YYYYMMDD#pNN' �ޤ��� 'YYYYMMDD#cNN')
#   str: ��󥯤ˤ���ʸ����
#
# Copyright (c) 2002 TADA Tadashi <sho@spc.gr.jp>
# Distributed under the GPL

def my( a, str )
	result = %Q[<a href="#{@index}#{anchor a}">#{str}</a>]
	date, place, frag = a.scan( /(\d{8})#?([cp])(\d\d)/ )[0]
	if date and frag and @diaries[date] then
		if place[0] == ?p then
			para = nil
			idx = 1
			@diaries[date].each_paragraph do |p|
				para = p
				break if idx == frag.to_i 
				idx += 1
			end
			if para and para.subtitle then
				title = CGI::escapeHTML( "#{para.subtitle}" )
				result = %Q[<a href="#{@index}#{anchor a}" title="#{title}">#{str}</a>]
			end
		else # comment
			com = nil
			@diaries[date].each_comment( frag.to_i ) {|c| com = c}
			if com then
				title = CGI::escapeHTML( "[#{com.name}] #{com.shorten}" )
				result = %Q[<a href="#{@index}#{anchor a}" title="#{title}">#{str}</a>]
			end
		end
	end
	result
end
