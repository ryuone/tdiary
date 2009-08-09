# -*- coding: utf-8 -*-
# navi_user.rb
#
# navi_user: 前日，翌日→前の日記，次の日記
#   modeがday/commentのときに表示される「前日」「翌日」ナビゲーション
#   リンクを，「前の日記」，「次の日記」に変更するplugin．前の日記，次
#   の日記がない場合は，ナビゲーションを表示しない．月またぎにも対応．
#
# Copyright (c) 2002 Junichiro KITA <kita@kitaj.no-ip.com>
# Distributed under the GPL

eval( <<MODIFY_CLASS, TOPLEVEL_BINDING )
module TDiary
	class TDiaryMonthWithoutFilter < TDiaryMonth
		def referer_filter(referer); end
	end
end
MODIFY_CLASS

class NaviUserCGI
	attr_reader :params, :referer, :user_agent
	def initialize(datestr)
		@params = {'date' => [datestr]}
		@referer = nil
		@user_agent = nil
	end

	def request_method
		'GET'
	end
end

add_header_proc do
	if @date then
		today = @date.strftime('%Y%m%d')
		cgi = NaviUserCGI.new(today)
		days = []
		yms = []
		this_month = today[0,6]

		@years.keys.each do |y|
			yms += @years[y].collect {|m| y + m}
		end
		yms |= [this_month]
		yms.sort!
		yms.unshift(nil).push(nil)
		yms[yms.index(this_month) - 1, 3].each do |ym|
			next unless ym
			cgi.params['date'] = [ym]
			m = TDiaryMonthWithoutFilter.new(cgi, '', @conf)
			m.diaries.delete_if {|date,diary| !diary.visible?}
			days += m.diaries.keys.sort
		end
		days |= [today]
		days.sort!
		days.unshift(nil).push(nil)
		@navi_user_days = days[days.index(today) - 1, 3]
	end
	''
end

def navi_user_day
	result = ''
	if @navi_user_days then
		result << navi_item( "#{h @index}#{anchor @navi_user_days[0]}", "&laquo;#{h navi_prev_diary(navi_user_format(@navi_user_days[0]))}" ) if @navi_user_days[0]
		result << navi_item( h(@index), h(navi_latest) )
		result << navi_item( "#{h @index}#{anchor @navi_user_days[2]}", "#{h navi_next_diary(navi_user_format(@navi_user_days[2]))}&raquo;" ) if @navi_user_days[2]
	end
	result
end

def navi_user_format( day )
	Time::local( *day.scan( /^(\d{4})(\d\d)(\d\d)$/ )[0] )
end
