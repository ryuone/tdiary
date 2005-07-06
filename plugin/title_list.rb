# titile_list.rb $Revision: 1.17 $
#
# title_list: ����ɽ�����Ƥ����Υ����ȥ�ꥹ�Ȥ�ɽ��
#   �ѥ�᥿(���å����̤���������):
#     rev:       �ս�ɽ��(false)
#
# ����: �����ȥ�ꥹ�Ȥ�������������ˤϡ��쥤�����Ȥ��פ��ʤ����
# �ʤ�ޤ��󡣥إå���եå���table������Ȥä��ꡢCSS��񤭴�����ɬ
# �פ�����Ǥ��礦��
#
def title_list( rev = false )
	result = %Q|<ul class="title-list">\n|
	keys = @diaries.keys.sort
	keys = keys.reverse if rev
	keys.each do |date|
		next unless @diaries[date].visible?
		result << %Q[<li><a href="#{@index}#{anchor date}">#{@diaries[date].date.strftime( @date_format )}</a>\n\t<ul class="title-list-item">\n]
		if !@plugin_files.grep(/\/category.rb$/).empty? and @diaries[date].categorizable?
			@diaries[date].each_section do |section|
				result << %Q[\t<li>#{section.stripped_subtitle_to_html}</li>\n] if section.stripped_subtitle
			end
		else
			@diaries[date].each_section do |section|
				result << %Q[<li>#{section.subtitle_to_html}</li>\n] if section.subtitle
			end
		end
		result << "\t</ul>\n</li>\n"
	end
	apply_plugin( result << "</ul>\n" )
end

