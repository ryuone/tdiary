# my-ex.rb $Revision: 1.5 $
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
			section = nil
			idx = 1
			@diaries[date].each_section do |s|
				section = s
				break if idx == frag.to_i 
				idx += 1
			end
			if section and section.subtitle then
				title = CGI::escapeHTML( "#{apply_plugin(section.subtitle_to_html, true)}" )
				result = %Q[<a href="#{@index}#{anchor a}" title="#{title}">#{str}</a>]
			end
		else # comment
			com = nil
			@diaries[date].each_comment( frag.to_i ) {|c| com = c}
			if com then
				title = CGI::escapeHTML( "[#{com.name}] #{com.shorten( @conf.comment_length )}" )
				result = %Q[<a href="#{@index}#{anchor a}" title="#{title}">#{str}</a>]
			end
		end
	end
	result
end
