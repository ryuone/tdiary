# titile_list.rb $Revision: 1.4 $
#
# title_list: ����ɽ�����Ƥ����Υ����ȥ�ꥹ�Ȥ�ɽ��
#   �ѥ�᥿(���å����̤���������):
#     rev:       �ս�ɽ��(false)
#     extra_erb: �����ȥ�ꥹ�������夵���ERb���̤���(false)
#
# ����: �����ȥ�ꥹ�Ȥ�������������ϡ��쥤�����Ȥ��פ��ʤ����
# �ʤ�ޤ��󡣥إå���եå���table������Ȥä��ꡢCSS��񤭴�����ɬ
# �פ�����Ǥ��礦��
#
def title_list( rev = false, extra_erb = false )
	result = ''
	keys = @diaries.keys.sort
	keys = keys.reverse if rev
	keys.each do |date|
		next unless @diaries[date].visible?
		result << %Q[<p class="recentitem"><a href="#{@index}#{anchor date}">#{@diaries[date].date.strftime( @date_format )}</a></p>\n<div class="recentsubtitles">\n]
		@diaries[date].each_paragraph do |paragraph|
			result << %Q[#{paragraph.subtitle}<br>\n] if paragraph.subtitle
		end
		result << "</div>\n"
	end
	if extra_erb and /<%=/ === result
		ERbLight.new( result ).result( binding )
	else
		result
	end
end

