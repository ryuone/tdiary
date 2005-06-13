# $Revision: 1.20 $
# recent_list: 最近書いた日記のタイトル，サブタイトルを表示する
#   パラメタ(カッコ内は未指定時の値):
#     days:            何日分の日記を表示するか(20)
#     date_format:     日付表示フォーマット(日記の日付フォーマット)
#     title_with_body: trueで各パラグラフへのリンクのtitle属性にそのパラグラフの一部を指定(false)
#     show_size:       trueで日記長を表示(false)
#     show_title:      trueで各日のタイトルを表示(false)
#
#   注意: セキュアモードでは使えません。
#   備考: タイトルリストを日記に埋め込むは、レイアウトを工夫しなければ
#         なりません。ヘッダやフッタでtableタグを使ったり、CSSを書き換
#         える必要があるでしょう。
#
# Copyright (c) 2001,2002 Junichiro KITA <kita@kitaj.no-ip.com>
# Distributed under the GPL
#
eval( <<MODIFY_CLASS, TOPLEVEL_BINDING )
module TDiary
	class TDiaryMonth
		attr_reader :diaries
	end
end
MODIFY_CLASS

def recent_list( days = 30, date_format = nil, title_with_body = nil, show_size = nil, show_title = nil )
	days = days.to_i
	date_format ||= @date_format

	result = %Q|<ul class="recent-list">\n|

	cgi = CGI::new
	def cgi.referer; nil; end

	catch(:exit) {
		@years.keys.sort.reverse_each do |year|
			@years[year].sort.reverse_each do |month|
				cgi.params['date'] = ["#{year}#{month}"]
				m = TDiaryMonth::new(cgi, '', @conf)
				m.diaries.keys.sort.reverse_each do |date|
					next unless m.diaries[date].visible?
					result << %Q|<li><a href="#{@index}#{anchor date}">#{m.diaries[date].date.strftime(date_format)}</a>\n|
					if show_title and m.diaries[date].title
						result << %Q| #{m.diaries[date].title}|
					end
					if show_size == true
						s = 0
						m.diaries[date].each_section do |section|
							s = s + section.to_s.size.to_i
						end
						result << ":#{s}"
					end
					result << %Q|<ul class="recent-list-item">\n|
					i = 1
					if !@plugin_files.grep(/\/category.rb$/).empty? and m.diaries[date].categorizable?
						m.diaries[date].each_section do |section|
							if section.stripped_subtitle
								result << %Q|<li><a href="#{@index}#{anchor "%s#p%02d" % [date, i]}"|
								result << %Q| title="#{CGI::escapeHTML( @conf.shorten( apply_plugin( section.body_to_html, true) ) )}"| if title_with_body == true
								result << %Q|>#{i}</a>. | \
										<< %Q|#{section.stripped_subtitle_to_html}</li>\n|
							end
							i += 1
						end
					else
						m.diaries[date].each_section do |section|
							if section.subtitle
								result << %Q|<li><a href="#{@index}#{anchor "%s#p%02d" % [date, i]}"|
								result << %Q| title="#{CGI::escapeHTML( @conf.shorten( apply_plugin(section.body_to_html, true) ) )}"| if title_with_body == true
								result << %Q|>#{i}</a>. | \
										<< %Q|#{section.subtitle_to_html}</li>\n|
							end
							i += 1
						end
					end
					result << "</ul>\n"
					days -= 1
					throw :exit if days == 0
				end
			end
		end
	}
	apply_plugin( result << "</ul>\n" )
end
# vim: ts=3
