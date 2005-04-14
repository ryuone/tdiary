#!/usr/bin/env ruby
# rast-search.rb $Revision: 1.1 $
$KCODE= 'e'
BEGIN { $defout.binmode }

require 'rast'

if FileTest::symlink?( __FILE__ ) then
	org_path = File::dirname( File::readlink( __FILE__ ) )
else
	org_path = File::dirname( __FILE__ )
end
$:.unshift( org_path.untaint )
require 'tdiary'

#
# class TDiaryRast
#
module TDiary
	class TDiaryRast < TDiaryBase
		MAX_PAGES = 20
		SORT_OPTIONS = [
			["score", "��������"],
			["date", "���ս�"],
		]
		SORT_PROPERTIES = ["date"]
		ORDER_OPTIONS = [
			["asc", "����"],
			["desc", "�߽�"],
		]
		NUM_OPTIONS = [10, 20, 30, 50, 100]

		if Rast::const_defined?(:LocalDB)
			DB = Rast::LocalDB
		else
			DB = Rast::DB
		end

		def initialize( cgi, rhtml, conf )
			super
			@db_path = "#{cache_path}/rast"
			@encoding = conf.options['rast.encoding'] || 'euc_jp'
			conf.options['sp.selected'] = ''
			parse_args
			format_form
			if @query.empty?
				@msg = '�����������Ϥ��ơ��ָ����ץܥ���򲡤��Ƥ�������'
			else
				search
			end
		end

		private

		def parse_args
			@query = @cgi["query"].strip
			@start = @cgi["start"].to_i
			@num = @cgi["num"].to_i
			if @num < 1
				@num = 10
			elsif @num > 100
				@num = 100
			end
			@sort = @cgi["sort"].empty? ? "score" : @cgi["sort"]
			@order = @cgi["order"].empty? ? "desc" : @cgi["order"]
		end

		def search
			db = DB.open(@db_path, DB::RDONLY)
			begin
				options = create_search_options
				t = Time.now
				@result = db.search(convert(@query), options)
				@secs = Time.now - t
			rescue
				@msg = "���顼: #{_($!.to_s)}</p>"
			ensure
				db.close
			end
		end

		def format_result_item(item)
			@title, @date, @last_modified = *item.properties
			@summary = _(item.summary) || ''
			for term in @result.terms
				@summary.gsub!(Regexp.new(Regexp.quote(term.term), true, @encoding), "<strong>\\&</strong>")
			end
		end

		def format_links(result)
			page_count = (result.hit_count - 1) / @num + 1
			current_page = @start / @num + 1
			first_page = current_page - (MAX_PAGES / 2 - 1)
			if first_page < 1
				first_page = 1
			end
			last_page = first_page + MAX_PAGES - 1
			if last_page > page_count
				last_page = page_count
			end
			buf = "<p id=\"navi\" class=\"infobar\">\n"
			if current_page > 1
				buf.concat(format_link("����", @start - @num, @num))
			end
			if first_page > 1
				buf.concat("... ")
			end
			for i in first_page..last_page
				if i == current_page
					buf.concat("#{i} ")
				else
					buf.concat(format_link(i.to_s, (i - 1) * @num, @num))
				end
			end
			if last_page < page_count
				buf.concat("... ")
			end
			if current_page < page_count
				buf.concat(format_link("����", @start + @num, @num))
			end
			buf.concat("</p>\n")
			return buf
		end

		def format_link(label, start, num)
			return format('<a href="%s?query=%s;start=%d;num=%d;sort=%s;order=%s">%s</a> ',
				      _(@cgi.script_name), CGI::escape(@query),
				      start, num, _(@sort), _(@order), _(label))
		end

		def create_search_options
			options = {
				"properties" => [
					"title", "date", 'last_modified'
				],
				"need_summary" => true,
				"summary_nchars" => 150,
				"start_no" => @start,
				"num_items" => @num
			}
			if SORT_PROPERTIES.include?(@sort)
				options["sort_method"] = Rast::SORT_METHOD_PROPERTY
				options["sort_property"] = @sort
			end
			if @order == "asc"
				options["sort_order"] = Rast::SORT_ORDER_ASCENDING
			else
				options["sort_order"] = Rast::SORT_ORDER_DESCENDING
			end
			return options
		end

		def format_options(options, value)
			return options.collect { |val, label|
				if val == value
					"<option value=\"#{_(val)}\" selected>#{_(label)}</option>"
				else
					"<option value=\"#{_(val)}\">#{_(label)}</option>"
				end
			}.join("\n")
		end

		def format_form
			@num_options = NUM_OPTIONS.collect { |n|
				if n == @num
					"<option value=\"#{n}\" selected>#{n}�鷺��</option>"
				else
					"<option value=\"#{n}\">#{n}�鷺��</option>"
				end
			}.join("\n")
			@sort_options = format_options(SORT_OPTIONS, @sort)
			@order_options = format_options(ORDER_OPTIONS, @order)
		end

		def _(str)
			CGI::escapeHTML(str)
		end

		def convert(str)
			case @encoding
			when 'utf8'
				require 'nkf'
				NKF::nkf('-w -m0', str)
			else
				@conf.to_native(str)
			end
		end
	end
end

begin
	@cgi = CGI::new
	if TDiary::Config.instance_method(:initialize).arity > 0
		# for tDiary 2.1 or later
		conf = TDiary::Config::new(@cgi)
	else
		# for tDiary 2.0 or earlier
		conf = TDiary::Config::new
	end
	tdiary = TDiary::TDiaryRast::new( @cgi, 'rast.rhtml', conf )

	head = {
		'type' => 'text/html',
		'Vary' => 'User-Agent'
	}
	if @cgi.mobile_agent? then
		body = conf.to_mobile( tdiary.eval_rhtml( 'i.' ) )
		head['charset'] = conf.mobile_encoding
		head['Content-Length'] = body.size.to_s
	else
		body = tdiary.eval_rhtml
		head['charset'] = conf.encoding
		head['Content-Length'] = body.size.to_s
		head['Pragma'] = 'no-cache'
		head['Cache-Control'] = 'no-cache'
	end
	print @cgi.header( head )
	print body
rescue Exception
	if @cgi then
		print @cgi.header( 'type' => 'text/plain' )
	else
		print "Content-Type: text/plain\n\n"
	end
	puts "#$! (#{$!.class})"
	puts ""
	puts $@.join( "\n" )
end
