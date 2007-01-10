# navi_user.rb $Revision: 1.9 $
#
# navi_user: ������������������������������
#   mode��day/comment�ΤȤ���ɽ�������������ס������ץʥӥ��������
#   ��󥯤򡤡����������ס��ּ��������פ��ѹ�����plugin��������������
#   ���������ʤ����ϡ��ʥӥ���������ɽ�����ʤ�����ޤ����ˤ��б���
#
# Copyright (c) 2002 Junichiro KITA <kita@kitaj.no-ip.com>
# Distributed under the GPL

eval( <<MODIFY_CLASS, TOPLEVEL_BINDING )
module TDiary
	class TDiaryMonth
	  attr_reader :diaries
	end
end
MODIFY_CLASS

add_header_proc do
	cgi = CGI.new
	def cgi.referer; nil; end
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
		m = TDiaryMonth.new(cgi, '', @conf)
		days += m.diaries.keys.sort
	end
	days |= [today]
	days.sort!
	days.unshift(nil).push(nil)
	@navi_user_days = days[days.index(today) - 1, 3]
	''
end

def navi_user_day
	result = ''
	result << navi_item( "#{h @index}#{anchor @navi_user_days[0]}", "&laquo;#{h navi_prev_diary(navi_user_format(@navi_user_days[0]))}" ) if @navi_user_days[0]
	result << navi_item( h(@index), h(@navi_user_days[1]) )
	result << navi_item( "#{h @index}#{anchor @navi_user_days[2]}", "#{h navi_next_diary(navi_user_format(@navi_user_days[2]))}&raquo;" ) if @navi_user_days[2]
	result
end

def navi_user_format( day )
	Time::local( *day.scan( /^(\d{4})(\d\d)(\d\d)$/ )[0] )
end
