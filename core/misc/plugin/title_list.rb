# titile_list.rb $Revision: 1.1 $
#
# title_list: ����ɽ�����Ƥ����Υ����ȥ�ꥹ�Ȥ�ɽ��
#   �ѥ�᥿: �ʤ�
#
# ����: �����ȥ�ꥹ�Ȥ�������������ϡ��쥤�����Ȥ��פ��ʤ����
# �ʤ�ޤ��󡣥إå���եå���table������Ȥä��ꡢCSS��񤭴�����ɬ
# �פ�����Ǥ��礦��
#
def title_list( rev = false )
	result = ''
	keys = @diaries.keys.sort
	keys = keys.reverse if rev
	keys.each do |date|
		result << %Q[<p class="recentitem"><a href="#{@index}?date=#{date}">#{@diaries[date].date.strftime( @date_format )}</a></p>\n<div class="recentsubtitles">\n]
		@diaries[date].each_paragraph do |paragraph|
			result << %Q[#{paragraph.subtitle}<br>\n] if paragraph.subtitle
		end
		result << "</div>\n"
	end
	result
end

