# category.rb $Revision: 1.8 $
#
# Copyright (c) 2003 Junichiro KITA <kita@kitaj.no-ip.com>
# Distributed under the GPL
#

#
# initialize
#
def category_init
	@conf['category.header1'] ||= %Q[<div class="adminmenu">\n<p>\n<%= category_navi %>\n</p>\n</div>\n]
	@conf['category.header2'] ||= %Q[<p>Categories |\n<%= category_list %>\n</p>\n]
end
category_init

def category_form
	# define me!
end

def category_anchor(cname)
	if @options['category.icon'] and @options['category.icon'][cname]
		%Q|<a href="#{@index}?year=#{@date.year};month=#{(@date.month - 1) / 3 + 1}Q;category=#{CGI::escape(cname)}"><img src="#{@options['category.icon'][cname] }" alt="#{cname}"></a>|
	else
		%Q|[<a href="#{@index}?year=#{@date.year};month=#{(@date.month - 1) / 3 + 1}Q;category=#{CGI::escape(cname)}">#{cname}</a>]|
	end
end

def category_navi
	info = Category::Info.new(@cgi, @years, @conf)
	mode = info.mode

	result = ''
	case mode
	when :year, :half, :quarter, :month
		all_diary = Category::Info.new(@cgi, @years, @conf, :year => -1, :month => -1)
		all = Category::Info.new(@cgi, @years, @conf, :category => ['ALL'], :year => -1, :month => -1)
		result << %Q[<span class="adminmenu">#{info.prev.make_anchor(@conf['category.prev_' + mode.to_s])}</span>\n]
		result << %Q[<span class="adminmenu">#{info.next.make_anchor(@conf['category.next_' + mode.to_s])}</span>\n]
		result << %Q[<span class="adminmenu">#{all_diary.make_anchor(@conf['category.all_diary'])}</span>\n]
		result << %Q[<span class="adminmenu">#{all.make_anchor(@conf['category.all'])}</span>\n]
	when :all
		year = Category::Info.new(@cgi, @years, @conf, :year => Time.now.year.to_s)
		half = Category::Info.new(@cgi, @years, @conf, :year => Time.now.year.to_s, :month => "#{((Time.now.month - 1) / 6 + 1)}H")
		quarter = Category::Info.new(@cgi, @years, @conf, :year => Time.now.year.to_s, :month => "#{((Time.now.month - 1) / 3 + 1)}Q")
		month = Category::Info.new(@cgi, @years, @conf, :year => Time.now.year.to_s, :month => '%02d' % Time.now.month)
		result << %Q[<span class="adminmenu">#{year.make_anchor(@conf['category.this_year'])}</span>\n]
		result << %Q[<span class="adminmenu">#{half.make_anchor(@conf['category.this_half'])}</span>\n]
		result << %Q[<span class="adminmenu">#{quarter.make_anchor(@conf['category.this_quarter'])}</span>\n]
		result << %Q[<span class="adminmenu">#{month.make_anchor(@conf['category.this_month'])}</span>\n]
	end
	if !info.category.include?('ALL')
		all_category = Category::Info.new(@cgi, @years, @conf, :category => ['ALL'])
		result << %Q[<span class="adminmenu">#{all_category.make_anchor(@conf['category.all_category'])}</span>\n]
	end
	result
end


#
# list categories and times
#
def category_list_sections
	info = Category::Info.new(@cgi, @years, @conf)
	category = info.category
	years = info.years
	r = ''

	categorized = Category::Cache.new(@conf).categorize(category, years)
	categorized.keys.sort.each do |c|
		info.category = c
		r << <<HTML
<div class="conf day">
	<h2><span class="title">#{info.make_anchor}</span></h2>
	<div class="body">
		<p>
HTML
		categorized[c].keys.sort.each do |ymd|
			text = Time.local(ymd[0,4], ymd[4,2], ymd[6,2]).strftime(@conf.date_format)
			categorized[c][ymd].sort.each do |idx, title, content|
				r << %Q|\t\t\t<a href="#{@conf.index}#{anchor "#{ymd}#p#{'%02d' % idx}"}" title="#{CGI.escapeHTML(@conf.shorten(apply_plugin(content, true)))}">#{text}#p#{'%02d' % idx}</a> #{apply_plugin(title)}<br>\n|
			end
		end
		r << <<HTML
		</p>
	</div>
</div>
HTML
	end
	r
end

def category_list
	info = Category::Info.new(@cgi, @years, @conf)
	Category::Cache.new(@conf).restore_categories.map do |c|
		info.category = c
		info.make_anchor
	end.join(" | \n")
end

#
# misc
#
::TDiary::TDiaryMonth.module_eval do
	attr_reader :diaries
end


module Category

#
# Info
#
class Info
	def initialize(cgi, years, conf, args = {})
		@cgi = cgi
		@years = years
		@conf = conf
		@category = args[:category] || @cgi.params['category']
		@year = args[:year] || @cgi.params['year'][0]
		@month = args[:month] || @cgi.params['month'][0]
		@mode = :all
		set_mode
	end

protected
	attr_writer :year
	attr_writer :month
public
	attr :category, true
	attr_reader :year
	attr_reader :month
	attr_reader :mode

	def prev
		pp = self.dup

		case mode
		when :half
			h = @month.to_i
			if h == 1
				pp.month = "2H"
				pp.year = (@year.to_i - 1).to_s if @year
			else
				pp.month = "1H"
			end
		when :quarter
			q = @month.to_i
			if q == 1
				pp.month = "4Q"
				pp.year = (@year.to_i - 1).to_s if @year
			else
				pp.month = "#{q - 1}Q"
			end
		when :month
			m = @month.to_i
			if m == 1
				pp.month = "12"
				pp.year = (@year.to_i - 1).to_s if @year
			else
				pp.month = '%02d' % (m - 1)
			end
		when :year
			pp.year = (@year.to_i - 1).to_s
		end
		pp
	end

	def next
		pp = self.dup

		case mode
		when :half
			h = @month.to_i
			if h == 2
				pp.month = "1H"
				pp.year = (@year.to_i + 1).to_s if @year
			else
				pp.month = "2H"
			end
		when :quarter
			q = @month.to_i
			if q == 4
				pp.month = "1Q"
				pp.year = (@year.to_i + 1).to_s if @year
			else
				pp.month = "#{q + 1}Q"
			end
		when :month
			m = @month.to_i
			if m == 12
				pp.month = "01"
				pp.year = (@year.to_i + 1).to_s if @year
			else
				pp.month = '%02d' % (m + 1)
			end
		when :year
			pp.year = (@year.to_i + 1).to_s
		end
		pp
	end

	def make_anchor(label = nil)
		a = @category.map {|c| "category=#{CGI.escape(c)}"}.join(';')
		a << ";year=#{@year}" if @year
		a << ";month=#{@month}" if @month
		if label
			case mode
			when :year
				label = label.gsub(/\$1/, @year)
			when :month, :quarter, :half
				label = label.gsub(/\$2/, @month)
				label = label.gsub(/\$1/, @year || '*')
			end
		else
			label = @category.map {|c| CGI.escapeHTML(c)}.join(':')
		end
		%Q|<a href="#{@conf.index}?#{a}">#{label}</a>|
	end

	#
	# return ym_spec
	#
	# {"yyyy" => ["mm", ...], ...}
	#
	# date spec:
	#  (1) none               -> all diary
	#  (2) month=xH           -> all diary in xH of all year
	#  (3) year=YYYY;month=xH -> all diary in YYYY/xH
	#  (4) month=xQ           -> all diary in xQ of all year
	#  (5) year=YYYY;month=xQ -> all diary in YYYY/xQ
	#  (6) month=MM           -> all diary in MM of all year
	#  (7) year=YYYY;month=MM -> all diary in YYYY/MM
	#  (8) year=YYYY          -> all diary in YYYY
	#
	def years
		if @mode == :all
			return @years
		end

		months = case @mode
		when :half
			[('01'..'06'), ('07'..'12')][@month.to_i - 1].to_a
		when :quarter
			[['01', '02', '03'], ['04', '05', '06'], ['07', '08', '09'], ['10', '11', '12']][@month.to_i - 1]
		when :month
			[@month]
		else
			('01'..'12').to_a
		end

		r = {}
		(@year ? [@year] : @years.keys).each do |y|
			r[y] = months
		end
		r
	end

	#
	# date spec:
	#  (1) none                -> all
	#  (2) month=xH            -> half
	#  (3) year=YYYY;month=xH  -> half
	#  (4) month=xQ            -> quarter
	#  (5) year=YYYY;month=xQ  -> quarter
	#  (6) month=MM            -> month
	#  (7) year=YYYY;month=MM  -> month
	#  (8) year=YYYY           -> year
	#
	def set_mode
		if @year.nil? and @month.nil?
			@mode = :all
		end

		if /\d{4}/ === @year.to_s
			@mode = :year
		else
			@year = nil
		end

		if /[12]H/ === @month.to_s
			@mode = :half
		elsif /[1-4]Q/ === @month.to_s
			@mode = :quarter
		elsif (1..12).include?(@month.to_i)
			@mode = :month
		else
			@month = nil
		end

	end
end

#
# Cache
#
class Cache
	def initialize(conf)
		@conf = conf
		@dir = "#{conf.data_path}/category"
		Dir.mkdir(@dir) unless File.exist?(@dir) 
	end

	def cache_file(category = nil)
		if category
			"#{@dir}/#{CGI.escape(category)}".untaint
		else
			"#{@dir}/category_list"
		end
	end

	def add_categories(list)
		return if list.nil? or list.empty?
		replace_categories(restore_categories + list)
	end

	def replace_categories(list)
		PStore.new(cache_file).transaction do |db|
			db['category'] = list.sort.uniq
		end
	end

	#
	# restore category names
	# ["category1", "category2", ...]
	#
	def restore_categories
		list = nil
		PStore.new(cache_file).transaction do |db|
			list = db['category'] if db.root?('category')
			db.abort
		end
		list || []
	end

	#
	# categorize sections of diary
	#
	# {"category" => {"yyyymmdd" => [[idx, title, excerpt], ...]}}
	#
	def categorize_diary(diary)
		categorized = {}
		ymd = diary.date.strftime('%Y%m%d')

		idx = 1
		diary.each_section do |s|
			s.categories.each do |c|
				categorized[c] = {} if categorized[c].nil?
				categorized[c][ymd] = [] if categorized[c][ymd].nil?
				categorized[c][ymd] << [idx, s.stripped_subtitle_to_html, s.body_to_html]
			end
			idx +=1
		end

		categorized
	end

	#
	# cache each section of diary
	# used in recreate
	#
	def initial_replace_sections(diary)
		return if diary.nil? or !diary.visible? or !diary.categorizable?

		categorized = categorize_diary(diary)
		categorized.keys.each do |c|
			PStore.new(cache_file(c)).transaction do |db|
				db['category'] = {} unless db.root?('category')
				db['category'].update(categorized[c])
			end
		end
	end

	#
	# cache each section of diary
	# used in update_proc
	#
	def replace_sections(diary)
		return if diary.nil? or !diary.categorizable?

		categorized = categorize_diary(diary)
		categories = restore_categories
		deleted = []
		ymd = diary.date.strftime('%Y%m%d')

		categories.each do |c|
			PStore.new(cache_file(c)).transaction do |db|
				db['category'] = {} unless db.root?('category')
				if diary.visible? and categorized[c]
					db['category'].update(categorized[c])
				else
					# diary is invisible or sections of this category is deleted
					db['category'].delete(ymd)
					deleted << c if db['category'].empty?
				end
			end
		end

		if !deleted.empty?
			deleted.each do |c|
				File.unlink(cache_file(c))
			end
			replace_categories(categories - deleted)
		end
	end

	#
	# (re)create category cache
	#
	def recreate(years)
		cgi = CGI::new
		def cgi.referer; nil; end

		list = []
		years.each do |y, ms|
			ms.each do |m|
				ym = "#{y}#{m}"
				cgi.params['date'] = [ym]
				m = TDiaryMonth.new(cgi, '', @conf)
				sections = {}
				m.diaries.each do |ymd, diary|
					next if !diary.visible?
					initial_replace_sections(diary)
					diary.each_section do |s|
						list |= s.categories unless s.categories.empty?
					end
				end
			end
		end

		replace_categories(list)
	end

	#
	# categorize sections of category of years
	#
	# {"category" => {"yyyymmdd" => [[idx, title, excerpt], ...], ...}, ...}
	#
	def categorize(category, years)
		categories = category - ['ALL']
		if categories.empty?
			categories = restore_categories
		else
			categories &= restore_categories
		end

		categorized = {}
		categories.each do |c|
			PStore.new(cache_file(c)).transaction do |db|
				categorized[c] = db['category']
				db.abort
			end
			categorized[c].keys.each do |ymd|
				y, m = ymd[0,4], ymd[4,2]
				if years[y].nil? or !years[y].include?(m)
					categorized[c].delete(ymd)
				end
			end
			categorized.delete(c) if categorized[c].empty?
		end

		categorized
	end
end
end


#
# when update diary, update cache
#
add_update_proc do
	cache = Category::Cache.new(@conf)
	list = []
	diary = @diaries[@date.strftime('%Y%m%d')]
	diary.each_section do |s|
		list |= s.categories
	end
	cache.add_categories(list)
	cache.replace_sections(diary)
end


#
# configuration
#
if @mode == 'conf' || @mode == 'saveconf'
add_conf_proc('category', @category_conf_label) do
	cache = Category::Cache.new(@conf)
	if @mode == 'saveconf'
		nil
	elsif @cgi.valid?('category_initialize')
		cache.recreate(@years)
	end
	category_conf_html
end
end

# vim: ts=3
