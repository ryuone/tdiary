# titile_list.rb $Revision: 1.6 $
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
		@diaries[date].each_section do |section|
			result << %Q[#{section.subtitle}<br>\n] if section.subtitle
		end
		result << "</div>\n"
	end
	if extra_erb and /<%=/ === result
		result.untaint if $SAFE < 3
		ERbLight.new( result ).result( binding )
	else
		result
	end
end

