# 01sp.rb - select-plugins plugin $Revision: 1.8 $

=begin ChangeLog
See ../ChangeLog for changes after this.

* Thu Aug 28, 2003 zunda <zunda at freeshell.org>
- 1.3
- simpler configuration display

* Tue Aug 26, 2003 zunda <zunda at freeshell.org>
- 1.2
- option defaults are flipped
- Typo for @options are fixed

* Tue Aug 26, 2003 zunda <zunda at freeshell.org>
- 1.1
- English translation

* Fri Aug 22, 2003 zunda <zunda at freeshell.org>
- 1.1.2.6
- bug fix: check conf mode before updating the options

* Fri Aug 22, 2003 zunda <zunda at freeshell.org>
- 1.1.2.5
- following options are added: thanks to kaz
- @options['select_plugins.hidesource']
- @options['select_plugins.hidemandatory']
- @options['select_plugins.newdefault']
- new plugins are marked in the list until the user configures the selections

* Wed Aug 20, 2003 zunda <zunda at freeshell.org>
- 1.1.2.1
- first release
=end ChangeLog

SP_PREFIX = 'sp'
@sp_path = ( @conf["#{SP_PREFIX}.path"] || 'misc/plugin' ).to_a

# get plugin option
def sp_option( key )
	@conf["#{SP_PREFIX}.#{key}"]
end

# hash of paths from array of dirs
def sp_hash_from_dirs( dirs )
	r = Hash.new
	dirs.each do |dir|
		Dir::glob( "#{dir}/*.rb" ).each do |path|
			filename = File.basename( path )
			unless r[ filename ] then
				r[ filename ] = path
			else
				raise PluginError::new( "Dupliacte plugin filename: #{filename}" )
			end
		end
	end
	r
end

# hash of paths from array of paths
# dirs is an array of allowed directories
def sp_hash_from_paths( paths, dirs )
	r = Hash.new
	paths.each do |path|
		if dirs.include?( File.dirname( path ) ) and FileTest.readable?( path ) then
			r[ File.basename( path ) ] = path
		end
	end
	r
end

# url of the document
def sp_doc_url( file )
	"http://docs.tdiary.org/#{@conf.lang}/?#{CGI::escapeHTML( file )}"
end

# <li> list of plugins
def sp_li_plugins( paths, is_checked )
	r = ''
	paths.collect { |path| File.basename( path ) }.sort.each do |file|
		r += <<-_HTML
			<li><input name="#{SP_PREFIX}.#{CGI::escapeHTML( file )}" type="checkbox" value="t"#{is_checked ? ' checked' : ''}><a href="#{sp_doc_url( file )}">#{CGI::escapeHTML( file )}</a>
		_HTML
	end
	r
end

# lists of plugins
def sp_list_plugins( sp_opt )
	r = ''
	unless sp_opt.empty? then
		# categorize the available plugins
		used = Array.new
		notused = Array.new
		unknown = Array.new
		selected_array = sp_option( 'selected' ) ? sp_option( 'selected').split( /\n/ ) : []
		notselected_array = sp_option( 'notselected' ) ? sp_option( 'notselected').split( /\n/ ) : []
		sp_opt.values.each do |path|
			if selected_array.include?( path ) then
				used << path
			elsif notselected_array.include?( path ) then
				notused << path
			else
				unknown << path
			end
		end

		# list up
		r += @sp_label_please_select
		unless unknown.empty? then
			r += @sp_label_new
			r += "<ul>\n" 
			r += sp_li_plugins( unknown, sp_option( 'usenew' ) )
			r += "</ul>\n"
		end
		# selected plugins
		unless used.empty? then
			r += @sp_label_used
			r += "<ul>\n"
			r += sp_li_plugins( used, true )
			r += "</ul>\n"
		end
		# not selected plugins
		unless notused.empty? then
			r += @sp_label_notused
			r += "<ul>\n"
			r += sp_li_plugins( notused, false )
			r += "</ul>\n"
		end
	else
		r += @sp_label_noplugin
	end
	r
end

# things needed to configure this plugin
if SP_PREFIX == @cgi.params['conf'][0] then
	# list of plugins
	@sp_opt = sp_hash_from_dirs( @sp_path )

	# update options
	# we have to do this when we are eval'ed to update the config menu
	if /saveconf/ =~ @mode then
		@conf["#{SP_PREFIX}.selected"] = ''
		@conf["#{SP_PREFIX}.notselected"] = ''
		@sp_opt.each_key do |file|
			if 't' == @cgi.params["#{SP_PREFIX}.#{file}"][0] then
				@conf["#{SP_PREFIX}.selected"] << "#{@sp_opt[ file ]}\n"
			else
				@conf["#{SP_PREFIX}.notselected"] << "#{@sp_opt[ file ]}\n"
			end
		end
	end
end

# configuration menu
# options are updated when we are eval'ed
add_conf_proc( SP_PREFIX, @sp_label ) do
	r = @sp_label_description + sp_list_plugins( @sp_opt )
end

# Finally, we can eval the selected plugins as tdiary.rb does
if sp_option( 'selected' ) then
	used = sp_hash_from_paths( sp_option( 'selected' ).untaint.split( /\n/ ), @sp_path )
	used.keys.sort.each do |filename|
		path = used[ filename ]
		begin
			load_plugin( path )
			@plugin_files << path
		rescue Exception
			raise PluginError::new( "Plugin error in '#{filename}'.\n#{$!}" )
		end
	end
end
