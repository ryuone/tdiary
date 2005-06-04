# navi_user.rb $Revision: 1.6 $
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
module TDiary
	class TDiaryMonth
	  attr_reader :diaries
	end
end
MODIFY_CLASS

def navi_user
	result = navi_item( @index_page, navi_index ) unless @index_page.empty?

	case @mode
	when 'latest'
		result << navi_item( "#{@index}#{anchor( @conf['ndays.prev'] + '-' + @conf.latest_limit.to_s )}", "&laquo;#{navi_prev_ndays}" ) if @conf['ndays.prev']
		result << navi_item( @index, navi_latest ) if @cgi.params['date'][0]
		result << navi_item( "#{@index}#{anchor( @conf['ndays.next'] + '-' + @conf.latest_limit.to_s )}", "#{navi_next_ndays}&raquo;" ) if @conf['ndays.next']
	when 'day'
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
		prev_day, cur_day, next_day = days[days.index(today) - 1, 3]
		if prev_day
			result << navi_item( "#{@index}#{anchor prev_day}", "&laquo;#{navi_prev_diary(navi_user_format(prev_day))}" )
		end
		result << navi_item( @index, navi_latest )
		if next_day
			result << navi_item( "#{@index}#{anchor next_day}", "#{navi_next_diary(navi_user_format(next_day))}&raquo;" )
		end
	when 'nyear'
		result << navi_item( "#{@index}#{anchor @prev_day[4,4]}", "&laquo;#{navi_prev_nyear Time::local(*@prev_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}" ) if @prev_day     
		result << navi_item( @index, navi_latest ) 
		result << navi_item( "#{@index}#{anchor @next_day[4,4]}", "#{navi_next_nyear Time::local(*@next_day.scan(/^(\d{4})(\d\d)(\d\d)$/)[0])}&raquo;" ) if @next_day
	else
		result << navi_item( @index, navi_latest )
	end
	result
end

def navi_user_format( day )
	Time::local( *day.scan( /^(\d{4})(\d\d)(\d\d)$/ )[0] )
end
