#!/usr/bin/env ruby
$KCODE= 'e'
#
# squeeze: make HTML text files from tDiary's database. $Revision: 1.4 $
#
# Copyright (C) 2001,2002, All right reserved by TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.

=begin How to usage
ruby squeeze.rb [-p <tDiary path>] [-c <tdiary.conf path>] [-d] <dest path>

-p <tDiary path>     : tDiaryのインストールパス。未指定時はカレントディレクトリ
                       例: -p /usr/local/tdiary
-c <tdiary.conf path>: tdiary.confが存在するパス。未指定時はカレントディレクトリ
                       例: -c /home/hoge/public_html/diary
-d                   : 隠された日のHTMLファイルを削除する
<dest path>          : HTMLファイルの生成先ディレクトリ
=end

=begin ChangeLog
2002-05-15 TADA Tadashi <sho@spc.gr.jp>
	* follow up tDiay 1.5 series.
	* make_years -> calendar.

2002-03-13 Junichiro Kita <kita@kitaj.no-ip.com>
	* version 1.0.4
	* -d option.
	* opt['hide_comment_form'] force true.

2002-02-27 TADA Tadashi <sho@spc.gr.jp>
	* version 1.0.3
	* -c option.
	* strip @header and @footer.
	* @show_referer force false.
	* @show_comment force true.

2002-01-12 TADA Tadashi <sho@spc.gr.jp>
	* version 1.0.2
	* fix usage.

2001-12-21 TADA Tadashi <sho@spc.gr.jp>
	* version 1.0.1
	* follow changing spacification of TDiary#transaction.

2001-11-26 TADA Tadashi <sho@spc.gr.jp>
	* version 1.0.0
=end

def usage
	puts "squeeze: making html files from tDiary's database."
	puts "usage: ruby squeeze.rb [-p <tDiary path>] [-c <tdiary.conf path>] [-d] <dest path>"
	exit
end

require 'getoptlong'
parser = GetoptLong::new
tdiary_path = '.'
tdiary_conf = nil
$opt_delete = nil
parser.set_options(
	['--path', '-p', GetoptLong::REQUIRED_ARGUMENT],
	['--conf', '-c', GetoptLong::REQUIRED_ARGUMENT],
	['--delete', '-d', GetoptLong::NO_ARGUMENT]
)
begin
	parser.each do |opt, arg|
		case opt
		when '--path'
			tdiary_path = arg
		when '--conf'
			tdiary_conf = arg
		when '--delete'
			$opt_delete = true
		end
	end
rescue
	usage
end
dest = ARGV.shift
usage unless dest
dest = File::expand_path( dest )
dest += '/' if /\/$/ !~ dest

tdiary_conf = tdiary_path unless tdiary_conf
Dir::chdir( tdiary_conf )

begin
	ARGV << '' # dummy argument against cgi.rb offline mode.
	require "#{tdiary_path}/tdiary"
rescue LoadError
	$stderr.puts 'squeeze.rb: cannot load tdiary.rb. try -p option.'
	exit
end


class TDiarySqueeze < TDiary
	def initialize( dest )
		super( nil, 'day.rhtml' )
		eval <<-DIARY_CLASS, TOPLEVEL_BINDING
			class Diary
				alias :__eval_rhtml :eval_rhtml
				def eval_rhtml(opt, path)
					opt['hide_comment_form'] = true
					__eval_rhtml(opt, path)
				end
			end
		DIARY_CLASS
		@header = ''
		@footer = ''
		@show_comment = true
		@show_referer = false
		calendar
		@years.keys.sort.each do |year|
			@years[year.to_s].sort.each do |month|
				@io.transaction( Time::local( year.to_i, month.to_i ) ) do |diaries|
					diaries.each do |day,diary|
						@diary = diary
						@date = @diary.date
						file = "#{dest}#{day}"
						if not @diary.visible?
							if $opt_delete and FileTest::exist?( file )
								puts "#{file} -> removed."
								File::delete( file )
							end
						elsif not FileTest::exist?( file ) or File::mtime( file ) < @diary.last_modified then
							puts file
							File::open( file, 'w' ) do |f| f.write( eval_rhtml ) end
						end
					end
					false
				end
			end
		end
	end

protected
	def cookie_name
		''
	end

	def cookie_mail
		''
	end
end

TDiarySqueeze::new( dest )

