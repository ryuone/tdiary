# my-ex.rb $Revision: 1.7 $
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

def my( a, str, title = nil )
	date, noise, frag = a.scan( /^(\d{8}|\d{6}|\d{4})([^\dcpt]*)?([cpt]\d\d)?/ )[0]
	anc = frag ? "#{date}#{frag}" : date
	place, frag = frag.scan( /([cpt])(\d\d)/ )[0] if frag
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
			end
		else # comment
			com = nil
			@diaries[date].each_comment( frag.to_i ) {|c| com = c}
			if com then
				title = CGI::escapeHTML( "[#{com.name}] #{com.shorten( @conf.comment_length )}" )
			end
		end
	end
	if title then
		%Q[<a href="#{@index}#{anchor anc}" title="#{title}">#{str}</a>]
	else
		%Q[<a href="#{@index}#{anchor anc}">#{str}</a>]
	end
end

