# navi_user.rb footnote.rb $Revision: 1.1 $
#
# navi_user: ������������������������������
#   mode��day/comment�ΤȤ���ɽ�������������ס������ץʥӥ��������
#   ��󥯤򡤡����������ס��ּ��������פ��ѹ�����plugin��������������
#   ���������ʤ����ϡ��ʥӥ���������ɽ�����ʤ�����ޤ����ˤ��б���
#
#   @secure=true �Ǥ�ư��ޤ���
#
# Copyright (c) 2002 Junichiro KITA <kita@kitaj.no-ip.com>
# Distributed under the GPL

eval( <<MODIFY_CLASS, TOPLEVEL_BINDING )
class TDiaryMonth
  attr_reader :diaries
end
MODIFY_CLASS

def navi_user
	result = ''
	result << %Q[<span class="adminmenu"><a href="#{@index_page}">�ȥå�</a></span>\n] unless @index_page.empty?
	if /^(day|comment)$/ =~ @mode
		cgi = CGI.new
		days = []
		yms = []
		today = @date.strftime('%Y%m%d')
		this_month = @date.strftime('%Y%m')

		@years.keys.each do |y|
			yms += @years[y].collect {|m| y + m}
		end
		yms |= [this_month]
		yms.sort!
		yms.unshift(nil).push(nil)
		yms[yms.index(this_month) - 1, 3].each do |ym|
			next unless ym
			cgi.params['date'] = [ym]
			m = TDiaryMonth.new(cgi, '')
			days += m.diaries.keys.sort
		end
		days |= [today]
		days.sort!
		days.unshift(nil).push(nil)
		prev_day, cur_day, next_day = days[days.index(today) - 1, 3]
		if prev_day
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor prev_day}">&lt;��������(#{Time::local(*prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0]).strftime(@date_format)})</a></span>\n]
		end
		if next_day
			result << %Q[<span class="adminmenu"><a href="#{@index}#{anchor next_day}">��������(#{Time::local(*next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0]).strftime(@date_format)})&gt;</a></span>\n]
		end
	end
	result << %Q[<span class="adminmenu"><a href="#{@index}">�ǿ�</a></span>\n] unless @mode == 'latest'
	result
end
