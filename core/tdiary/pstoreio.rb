#
# pstoreio.rb: tDiary IO class of tdiary 1.x format. $Revision: 1.7 $
#
require 'pstore'

class TDiary
	class PStoreIO
		def initialize( data_path )
			@data_path = data_path
		end
	
		#
		# block must be return boolean which dirty diaries.
		#
		def transaction( date, diaries = {} )
			filename = date.strftime( "#{@data_path}%Y%m" )
			begin
				PStore::new( filename ).transaction do |db|
					dirty = false
					begin
						diaries.update( db['diary'] )
					rescue PStore::Error
					end
					dirty = yield( diaries ) if iterator?
					if dirty then
						db['diary'] = diaries
					else
						db.abort
					end
				end
			rescue PStore::Error, NameError, Errno::EACCES
				raise PermissionError::new( 'make your @data_path to writable via httpd.' )
			end
			File::delete( filename ) if diaries.empty?
			return diaries
		end

		def calendar
			calendar = {}
			Dir["#{@data_path}??????"].sort.each do |file|
				year, month = file.scan( %r[/(\d{4})(\d\d)$] )[0]
				next unless year
				calendar[year] = [] unless calendar[year]
				calendar[year] << month
			end
			calendar
		end

		def diary_factory( date, title, body, format = nil )
			Diary::new( date, title, body )
		end
	end
end

=begin
== Paragraph class
Management a paragraph.
=end
class Paragraph
	attr_reader :subtitle, :body

	def initialize( fragment, author = nil )
		@author = author
		lines = fragment.split( /\n+/ )
		if lines.size > 1 then
			if /^<</ =~ lines[0]
				@subtitle = lines.shift.chomp.sub( /^</, '' )
			elsif /^[ ��<]/ !~ lines[0]
				@subtitle = lines.shift.chomp
			end
		end
		@body = lines.join( "\n" )
	end

	def text
		s = ''
		if @subtitle then
			s += "[#{@author}]" if @author
			s += '<' if /^</ =~ @subtitle
			s += @subtitle + "\n"
		end
		"#{s}#{@body}\n\n"
	end

	def to_s
		"subtitle=#{@subtitle}, body=#{@body}"
	end

	def author
		@author = @auther unless @author
		@author
	end
end

=begin
== Diary class
Management a day of diary
=end
class Diary
	attr_reader :date, :title

	include DiaryBase

	def initialize( date, title, body )
		init_diary
		replace( date, title, body )
	end

	def format
		'tDiary'
	end

	def replace( date, title, body )
		@date, @title = date, title
		@paragraphs = []
		append( body )
	end

	def append( body, author = nil )
		body.gsub( "\r", '' ).split( /\n\n+/ ).each do |fragment|
			paragraph = Paragraph::new( fragment, author )
			@paragraphs << paragraph if paragraph
		end
		@last_modified = Time::now
		self
	end

	def title=( t )
		@title = t
		@last_modified = Time::now
	end

	def each_paragraph
		@paragraphs.each do |paragraph|
			yield paragraph
		end
	end

	def to_text
		text = ''
		each_paragraph do |para|
			text << para.text
		end
		text
	end

	def to_html( opt, mode = :HTML )
		case mode
		when :CHTML
			to_chtml( opt )
		else
			to_html4( opt )
		end
	end

	def to_html4( opt )
		idx = 1
		r = ''
		each_paragraph do |paragraph|
			r << %Q[<div class="section">\n]
			if paragraph.subtitle then
				r << %Q[<h3><a ]
				if opt['anchor'] then
					r << %Q[name="p#{'%02d' % idx}" ]
				end
				r << %Q[href="#{opt['index']}<%=anchor "#{@date.strftime( '%Y%m%d' )}#p#{'%02d' % idx}" %>">#{opt['paragraph_anchor']}</a> ]
				if opt['multi_user'] and paragraph.author then
					r << %Q|[#{paragraph.author}]|
				end
				r << %Q[#{paragraph.subtitle}</h3>]
			end
			if /^</ =~ paragraph.body then
				r << %Q[#{paragraph.body}]
			elsif paragraph.subtitle
				r << %Q[<p>#{paragraph.body.collect{|l|l.chomp}.join( "</p>\n<p>" )}</p>]
			else
				r << %Q[<p><a ]
				if opt['anchor'] then
					r << %Q[name="p#{'%02d' % idx}" ]
				end
				r << %Q[href="#{opt['index']}<%=anchor "#{@date.strftime( '%Y%m%d' )}#p#{'%02d' % idx}" %>">#{opt['paragraph_anchor']}</a> #{paragraph.body.collect{|l|l.chomp}.join( "</p>\n<p>" )}</p>]
			end
			r << %Q[</div>]
			idx += 1
		end
		r
	end

	def to_chtml( opt )
		idx = 0
		r = ''
		each_paragraph do |paragraph|
			if paragraph.subtitle then
				r << %Q[<P><A NAME="p#{'%02d' % idx += 1}">*</A> #{paragraph.subtitle}</P>]
			end
			if /^</ =~ paragraph.body then
				idx += 1
				r << paragraph.body
			elsif paragraph.subtitle
				r << %Q[<P>#{paragraph.body.collect{|l|l.chomp}.join( "</P>\n<P>" )}</P>]
			else
				r << %Q[<P><A NAME="p#{'%02d' % idx += 1}">*</A> ]
				if opt['multi_user'] and paragraph.author then
					r << %Q|[#{paragraph.author}]|
				end
				r << %Q[#{paragraph.body.collect{|l|l.chomp}.join( "</P>\n<P>" )}</P>]
			end
		end
		r
	end

	def to_s
		"date=#{@date.strftime('%Y%m%d')}, title=#{@title}, body=[#{@paragraphs.join('][')}]"
	end
end

