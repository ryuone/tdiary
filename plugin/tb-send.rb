# tb-send.rb $Revision: 1.9 $
#
# Copyright (c) 2003 Junichiro Kita <kita@kitaj.no-ip.com>
# You can distribute this file under the GPL.
#

add_edit_proc do |date|
	url = @cgi.params['plugin_tb_url'][0] || ''
	excerpt = @cgi.params['plugin_tb_excerpt'][0] || ''
	section = @cgi.params['plugin_tb_section'][0] || ''
	select_sections = ''
	unless @conf['tb.no_section'] then
		diary = @diaries[@date.strftime('%Y%m%d')]
		if diary then
			section_titles = ''
	 		idx = 1
			diary.each_section do |t|
				anc = 'p%02d' % idx
				selected = (section == anc ) ? ' selected' : ''
				section_titles << %[<option value="#{anc}"#{selected}>#{CGI::escapeHTML( apply_plugin( t.subtitle_to_html, true ) ).chomp}</option>\n\t\t\t]
				idx += 1
			end
			anc = 'p%02d' % idx
			section_titles << %[<option value="#{anc}"#{(section == anc ) ? ' selected' : ''}>#{@tb_send_label_current_section}</option>]
	
			select_sections = <<-FROM
				<div class="field">
				#{@tb_send_label_section}: <select name="plugin_tb_section" tabindex="501">
				<option value="">#{@tb_send_label_no_section}</option>
				#{section_titles}
				</select>
				</div>
			FROM
		end
	end

	<<-FORM
		<h3 class="subtitle">TrackBack</h3>
		<div class="trackback">
			<div class="field title">
			#{@tb_send_label_url}: <input class="field" tabindex="500" name="plugin_tb_url" size="60" value="#{CGI::escapeHTML( url )}">
			</div>
			#{select_sections}
			<div class="textarea">
			#{@tb_send_label_excerpt}: <textarea tabindex="502" style="height: 4em;" name="plugin_tb_excerpt" cols="70" rows="4">#{CGI::escapeHTML( excerpt )}</textarea>
			</div>
		</div>
	FORM
end

add_update_proc do
	tb_send_trackback if /^(append|replace)$/ =~ @mode
end

def tb_send_trackback
	url = @cgi.params['plugin_tb_url'][0]
	unless url.nil? or url.empty?
		require 'net/http'

		title = @cgi.params['title'][0]
		excerpt = @cgi.params['plugin_tb_excerpt'][0]
		section = @cgi.params['plugin_tb_section'][0]
		blog_name = @conf.html_title

		date = @date.strftime( '%Y%m%d' )
		if section && !section.empty? then
			diary = @diaries[date].class.new( date, title, @cgi.params['body'][0] )
			ary = []; diary.each_section{|s| ary << s}
			num = section[1..-1].to_i - 1
			if num < ary.size
				title = ary[num].subtitle_to_html if ary[num].subtitle && !ary[num].subtitle.empty?
				excerpt = ary[num].body_to_html if excerpt.empty?
			end
		end

		if excerpt.empty?
			excerpt = @diaries[date].class.new( date, title, @cgi.params['body'][0] ).to_html({})
		end

		old_apply_plugin = @options['apply_plugin']
		@options['apply_plugin'] = true
		title = apply_plugin( title, true )
		excerpt = apply_plugin( excerpt, true )
		@options['apply_plugin'] = old_apply_plugin

		if excerpt.length > 255 then
			excerpt = @conf.shorten( excerpt.gsub( /\r/, '' ).gsub( /\n/, "\001" ), 252 ).gsub( /\001/, "\n" ) + '...'
		end

		my_url = %Q|#{@conf.base_url}#{@conf.index}#{anchor(@date.strftime('%Y%m%d'))}|.sub(%r|/\./|, '/')
		my_url += "##{section}" if section && !section.empty?
 
		trackback = "url=#{CGI::escape(my_url)}"
		trackback << "&charset=#{@tb_send_ping_charset}"
		trackback << "&title=#{CGI::escape( @conf.to_native( title ) )}" unless title.empty?
		trackback << "&excerpt=#{CGI::escape( @conf.to_native( excerpt) )}" unless excerpt.empty?
		trackback << "&blog_name=#{CGI::escape(blog_name)}"

		if %r|^http://([^/]+)(/.*)$| =~ url then
			request = $2
			host, port = $1.split( /:/, 2 )
			port = '80' unless port
			Net::HTTP.version_1_1
			begin
				Net::HTTP.start( host.untaint, port.to_i ) do |http|
					response, = http.post( request, trackback,
						"Content-Type" => 'application/x-www-form-urlencoded')
					
					error = response.body.scan(%r|<error>(\d)</error>|)[0][0]
					if error == '1'
						reason = response.body.scan(%r|<message>(.*)</message>|m)[0][0]
						raise TDiaryTrackBackError.new(reason)
					end
				end
			rescue
				raise TDiaryTrackBackError.new("when sending TrackBack Ping: #{$!.message}")
			end
		end
	end
end

# vim: ts=3
