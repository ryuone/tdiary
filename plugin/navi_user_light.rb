# navi_user_light.rb $Revision: 1.1 $
#
# navi_user.rb �η�����
#
# navi_user: ������������������������������
#   mode��day/comment�ΤȤ���ɽ�������������ס������ץʥӥ��������
#   ��󥯤򡤡����������ס��ּ��������פ��ѹ�����plugin��������������
#   ���������ʤ����ϡ�������������1���ؤΥ�󥯤�ɽ�����롥
#
# Copyright (c) 2002 Junichiro KITA <kita@kitaj.no-ip.com>
# Distributed under the GPL

=begin ChangeLog
=end

@debug=true
def navi_user
	result = ''
	result << %Q[<span class="adminmenu"><a href="#{@index_page}">�ȥå�</a></span>\n] unless @index_page.empty?
	if /^(day|comment)$/ =~ @mode
		days = []
		today = @date.strftime('%Y%m%d')
		days += @diaries.keys
		days |= [today]

		days.sort!
		days.unshift(nil).push(nil)
		prev_day, cur_day, next_day = days[days.index(today) - 1, 3]
		if prev_day
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor prev_day}">&lt;��������(#{Time::local(*prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0]).strftime(@date_format)})</a></span>\n]
		else
			pday = Time.local(@date.year, @date.month, 1) - 24*60*60
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor pday.strftime('%Y%m%d')}">&lt;�������(#{pday.strftime(@date_format)})</a></span>\n]
		end
		if next_day
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor next_day}">��������(#{Time::local(*next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0]).strftime(@date_format)})&gt;</a></span>\n]
		else
			nday = if @date.month == 12
				Time.local(@date.year + 1, 1, 1)
			else
				Time.local(@date.year, @date.month + 1, 1)
			end
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor nday.strftime('%Y%m%d')}">���1��(#{nday.strftime(@date_format)})&gt;</a></span>\n]
		end
	end
	result << %Q[<span class="adminmenu"><a href="#{@index}">�ǿ�</a></span>\n] unless @mode == 'latest'
	result
end
# vim: ts=3
