=begin
= �ץ饰��������ץ饰����((-$Id: select_plugins.rb,v 1.4 2003-09-25 14:35:28 tadatadashi Exp $-))
Please see below for an English description.

== ����
�ɤΥץ饰�����Ȥ��Τ����Ӥޤ�

���Υץ饰�����00defaults.rb�μ����ɤޤ졢���Υץ饰���󼫿Ȥ��������
ǽ�ʥץ饰�����ɤޤ�ޤ������θ�˥ǥե���ȤΥѥ��ˤ���ץ饰������
�߹��ޤ�ޤ��Τǡ�Ʊ���᥽�åɤ�������Ƥ�����ˤϡ��ǥե���ȤΥѥ���
��Τ�ͭ���ˤʤ�ޤ���

== �Ȥ���
���Υץ饰�����plugin/�ǥ��쥯�ȥ�����֤��Ƥ���������

�ޤ���00defaults.rb�䤳�Υץ饰����ʤɡ����Ф�ɬ�פʥץ饰����ʳ��ϡ�
http�����С����鸫�����̤Υǥ��쥯�ȥ�˰ܤ��Ƥ����������ʲ�����Ǥϡ�
plugin�ǥ��쥯�ȥ�β���selectable�Ȥ����ǥ��쥯�ȥ���äƤ��ޤ���

�Ǹ�ˡ�tdiary.rb��Ʊ�����ˤ���tdiary.conf�ˡ�
  @options['select_plugins.path'] = 'plugin/selectable'
�ʤɤȡ�����Ǥ���ץ饰����Τ���ǥ��쥯�ȥ��tdiary.rb�Τ���ǥ��쥯
�ȥ꤫������Хѥ������Хѥ��ǻ��ꤷ�Ƥ���������

secure==true�������Ǥ�Ȥ��ޤ���

== ���ץ����
:@options['select_plugins.path']
  'plugin/selectable'�ʤɤȡ�����Ǥ���ץ饰����Τ���ǥ��쥯�ȥ��
  tdiary.rb�Τ���ǥ��쥯�ȥ꤫������Хѥ������Хѥ��ǻ��ꤷ�Ƥ���������

:@options['select_plugins.hidehelp']
  ����ɽ�����������ˤ�false�����ꤷ�Ƥ���������

:@options['select_plugins.hidesource']
  ��������ɽ�����������ˤ�false�����ꤷ�Ƥ���������

:@options['select_plugins.hidemandatory']
  ���Ф�ɬ�פʥץ饰����ξ����ɽ�����������ˤ�false�����ꤷ�Ƥ���������

:@options['select_plugins.usenew']
  ���������󥹥ȡ��뤵�줿�ץ饰�����ǥե���ȤǻȤ��褦�ˤ������
  true�����ꤷ�Ƥ������������������󥹥ȡ��뤵�줿�ץ饰����򸡽Ф����
  �ϡ����˥ץ饰�������򤵤����Ǥ���

== TODO
���򤵤�Ƥ����ץ饰���󤬾õ�줿���ˤɤ����뤫�����ߤμ����Ǥϡ��ץ�
�������ɤ߹��߻��ˤ�̵�뤷�ơ���������򤷤ʤ��������˾ä��롣

= Select-plugin plugin

== Abstract
Selects which plugin to be actually used.

== Usage
Put this file into the plugin/ directory.

Next, move the plugins you want to be optional into another directory.
In the example below, these plugins are assumed to be in
plugin/selectable directory.

Finally, edit the tdiary.conf file in the same directory as tdiary.rb
and add the following line:
  @options['select_plugins.path'] = 'plugin/selectable'
to indicate the directory you have put the optional plugins. It can be
an absolute path.

You can use this plugin in a secure diary.

== Options
:@options['select_plugins.path']
	Directory name where the optional plugins are, relative from the
  directory where tdiary.rb is or absolute.

:@options['select_plugins.hidehelp']
	Define false when you want the users (writers of the diaries) to see
  the comments of the plugins.

:@options['select_plugins.hidesource']
	Define false when you want the users  to see the sources of the
	plugins.

:@options['select_plugins.hidemandatory']
	Define false when you want to show what plugins are installed in the
  non-optional path.

:@options['select_plugins.usenew']
  Define true if you want to the users to try a newly installed plugin.
	Newly installed plugins are detected next time when the user configures
	this plugin.

== ����ˤĤ��� (Copyright notice)
Copyright (C) 2003 zunda <zunda at freeshell.org>

Permission is granted for use, copying, modification, distribution, and
distribution of modified versions of this work under the terms of GPL
version 2 or later.

You should be able to find the latest version of this pluigin at
((<URL:http://zunda.freeshell.org/d/plugin/select_plugins.rb>)).
=end

=begin ChangeLog
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

Select_plugin_prefix = 'select_plugins'

if @options["#{Select_plugin_prefix}.path"] then

	# list of plugins
	def sp_list_plugins
		r = ''
		if false == @options["#{Select_plugin_prefix}.hidemandatory"] then
			case @conf.lang
			when 'en'
				r << <<-_HTML
					<h4>Mandatory plugins</h4>
					<p>These plugins must always be used.</p>
					<ul>
				_HTML
			else
				r << <<-_HTML
					<h4>��˻Ȥ���ץ饰����</h4>
					<p>�Ȥ����ɤ������򤹤뤳�ȤϤǤ��ޤ���</p>
					<ul>
				_HTML
			end
			@sp_defs.keys.sort.each do |file|
				case @conf.lang
				when 'en'
					 r << <<-_HTML
						<li>#{CGI::escapeHTML( file )}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};help=d#{CGI::escape( file )}\">comments</a>" if false == @options["#{Select_plugin_prefix}.hidehelp"]}#{', ' if false == @options["#{Select_plugin_prefix}.hidehelp"] and false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=d#{CGI::escape( file )}\">source</a>" if false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"(#{@sp_ver[ "d#{file}" ]})" if @sp_ver[ "d#{file}" ]}
					_HTML
				else
					 r << <<-_HTML
						<li>#{CGI::escapeHTML( file )}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};help=d#{CGI::escape( file )}\">���</a>" if false == @options["#{Select_plugin_prefix}.hidehelp"]}
							#{'��' if false == @options["#{Select_plugin_prefix}.hidehelp"] and false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=d#{CGI::escape( file )}\">������</a>" if false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"(#{@sp_ver[ "d#{file}" ]})" if @sp_ver[ "d#{file}" ]}
					_HTML
				end
			end
			case @conf.lang
			when 'en'
				r << <<-_HTML
					</ul>
					<h4>Optional plugins</h4>
				_HTML
			else
				r << <<-_HTML
					</ul>
					<h4>�Ȥ����ɤ�������Ǥ���ץ饰����</h4>
				_HTML
			end
		end	# if false == @options["#{Select_plugin_prefix}.hidemandatory"] then
		unless @sp_opt.empty? then
			known = (@conf["#{Select_plugin_prefix}.selected"] ? @conf["#{Select_plugin_prefix}.selected"].split( /\n/ ) : []) + (@conf["#{Select_plugin_prefix}.notselected"] ? @conf["#{Select_plugin_prefix}.notselected"].split( /\n/ ) : [])
			case @conf.lang
			when 'en'
				r << <<-_HTML
					<p>Please check the plugins you want to use.</p>
					<ul>
				_HTML
			else
				r << <<-_HTML
					<p>ͭ���ˤ������ץ饰����˥����å����Ƥ���������</p>
					<ul>
				_HTML
			end
			@sp_opt.keys.sort.each do |file|
				case @conf.lang
				when 'en'
					r << <<-_HTML
						<li><input name="sp.#{CGI::escapeHTML( file )}" type="checkbox" value="t"#{((@conf["#{Select_plugin_prefix}.selected"] and @conf["#{Select_plugin_prefix}.selected"].split( /\n/ ).include?( file )) or (@conf["#{Select_plugin_prefix}.usenew"] and not known.include?( file ))) ? ' checked' : ''}>
							#{CGI::escapeHTML( file )}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};help=o#{CGI::escape( file )}\">comments</a>" if false == @options["#{Select_plugin_prefix}.hidehelp"]}#{', ' if false == @options["#{Select_plugin_prefix}.hidehelp"] and false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=o#{CGI::escape( file )}\">source</a>" if false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"(#{@sp_ver[ "o#{file}" ]})" if @sp_ver[ "o#{file}" ]}
							#{'[New! Try this.]' unless known.include?( file )}
					_HTML
				else
					r << <<-_HTML
						<li><input name="sp.#{CGI::escapeHTML( file )}" type="checkbox" value="t"#{((@conf["#{Select_plugin_prefix}.selected"] and @conf["#{Select_plugin_prefix}.selected"].split( /\n/ ).include?( file )) or (@conf["#{Select_plugin_prefix}.usenew"] and not known.include?( file ))) ? ' checked' : ''}>
							#{CGI::escapeHTML( file )}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};help=o#{CGI::escape( file )}\">���</a>" if false == @options["#{Select_plugin_prefix}.hidehelp"]}
							#{'��' if false == @options["#{Select_plugin_prefix}.hidehelp"] and false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=o#{CGI::escape( file )}\">������</a>" if false == @options["#{Select_plugin_prefix}.hidesource"]}
							#{"(#{@sp_ver[ "o#{file}" ]})" if @sp_ver[ "o#{file}" ]}
							#{'[�����١��������������]' unless known.include?( file )}
					_HTML
				end
			end
			r << "</ul>\n"
		else
			case @conf.lang
			when 'en'
				r << "<li>There is no optional plugins.\n"
			else
				r << "<li>�����ǽ�ʥץ饰����Ϥ���ޤ���\n"
			end
		end
		r
	end

	# comments
	# file is prefixed with 'o' (optional/selectable) or 'd' (default/mandatory)
	def sp_help( file )
		help = nil
		if false == @options["#{Select_plugin_prefix}.hidehelp"] and @sp_src[file] then
			if /^=begin$(.*?)^=end$/m =~ @sp_src[file] then
				help =  $1
			elsif /((^#.*?\n)+)/ =~ @sp_src[file] then
				help =  $1.gsub( /^#/, '' )
			end
			if help then
				case @conf.lang
				when 'en'
					<<-_HTML
						<p>Comments in #{CGI::escapeHTML( file.slice( 1..-1 ) )}.#{" Click <a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=#{CGI::escape( file )}\">here</a> for the source." if false == @options["#{Select_plugin_prefix}.hidesource"]}</p>
						<p><a href="#{@conf.update}?conf=#{Select_plugin_prefix}">Back</a>
						<hr>
						<pre>#{CGI::escapeHTML( help )}</pre>
						<hr>
					_HTML
				else
					<<-_HTML
						<p>#{CGI::escapeHTML( file.slice( 1..-1 ) )}�����Ǥ���#{"�������򸫤�ˤϡ�<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=#{CGI::escape( file )}\">������</a>��" if false == @options["#{Select_plugin_prefix}.hidesource"]}</p>
						<p><a href="#{@conf.update}?conf=#{Select_plugin_prefix}">���</a>
						<hr>
						<pre>#{CGI::escapeHTML( help )}</pre>
						<hr>
					_HTML
				end
			else
				case @conf.lang
				when 'en'
					<<-_HTML
						<p>There is no comment in #{CGI::escapeHTML( file.slice( 1..-1 ))}.#{" Click <a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=#{CGI::escape( file )}\">here</a> for the source." if false == @options["#{Select_plugin_prefix}.hidesource"] and @sp_src[file]}</p>
					_HTML
				else
					<<-_HTML
						<p>#{CGI::escapeHTML( file.slice( 1..-1 ))}�����Ϥ���ޤ���#{"�������򸫤�ˤϡ�<a href=\"#{@conf.update}?conf=#{Select_plugin_prefix};src=#{CGI::escape( file )}\">������</a>��" if false == @options["#{Select_plugin_prefix}.hidesource"] and @sp_src[file]}</p>
					_HTML
				end
			end
		else
			case @conf.lang
			when 'en'
				<<-_HTML
				<p>Comments from #{CGI::escapeHTML( file.slice( 1..-1 ))} can't be viewed.</p>
				_HTML
			else
				<<-_HTML
				<p>#{CGI::escapeHTML( file.slice( 1..-1 ))}�����ϸ����ޤ���</p>
				_HTML
			end
		end
	end

	# source
	# file is prefixed with 'o' (optional/selectable) or 'd' (default/mandatory)
	def sp_src( file )
		if false == @options["#{Select_plugin_prefix}.hidesource"] and @sp_src[file] then
			case @conf.lang
			when 'en'
				<<-_HTML
				<p>Source for #{CGI::escapeHTML( file.slice( 1..-1 ) )}</p>
				<p><a href="#{@conf.update}?conf=#{Select_plugin_prefix}">Back</a>
				<hr>
				<pre>#{CGI::escapeHTML( @sp_src[file] )}</pre>
				<hr>
				_HTML
			else
				<<-_HTML
				<p>#{CGI::escapeHTML( file.slice( 1..-1 ) )}�Υ������Ǥ���</p>
				<p><a href="#{@conf.update}?conf=#{Select_plugin_prefix}">���</a>
				<hr>
				<pre>#{CGI::escapeHTML( @sp_src[file] )}</pre>
				<hr>
				_HTML
			end
		else
			case @conf.lang
			when 'en'
				<<-_HTML
				<p>Source for #{CGI::escapeHTML( file.slice( 1..-1 ) )} can't be viewed.</p>
				_HTML
			else
				<<-_HTML
				<p>#{CGI::escapeHTML( file.slice( 1..-1 ) )}�Υ������ϸ����ޤ���</p>
				_HTML
			end
		end
	end 

	# header for configuration menu
	def sp_description
		case @conf.lang
		when 'en'
			<<-_HTML
			<p>Selects which plugins you want to use.</p>
			_HTML
		else
			<<-_HTML
			<p>�ɤΥץ饰�����Ȥ������򤷤ޤ���</p>
			_HTML
		end
	end

	# configuration menu
	# options are updated when we are eval'ed
	add_conf_proc( Select_plugin_prefix,
		case @conf.lang
		when 'en'
			'Plugin selection'
		else
			'�ץ饰��������'
		end
	) do
		r = sp_description
		if @cgi.params['help'][0] then
			r << sp_help( @cgi.params['help'][0] )
		elsif false == @options["#{Select_plugin_prefix}.hidesource"] and @cgi.params['src'][0] then
			r << sp_src( @cgi.params['src'][0] )
		else
			r << sp_list_plugins
		end
	end

	# we need information from all the plugins in configuration mode
	if Select_plugin_prefix == @cgi.params['conf'][0] then
		if /conf/ =~ @mode then
			# mandatory plugins
			if false == @options["#{Select_plugin_prefix}.hidemandatory"] then
				@sp_defs = Hash.new	# path to the plugin
				def_paths = Dir::glob( ( @conf.plugin_path || "#{PATH}/plugin" ) + "/*.rb" )
				def_paths.each do |path|
					@sp_defs[ File.basename( path ) ] = path
				end
			end
			# selectable plugins
			@sp_opt = Hash.new	# path to the plugin
			opt_paths = Dir::glob( @options["#{Select_plugin_prefix}.path"] + "/*.rb" )
			opt_paths.each do |path|
				@sp_opt[ File.basename( path ) ] = path
			end
			# other information
			@sp_ver = Hash.new	# revision number of the plugin
			@sp_src = Hash.new	# source
			[['d', def_paths], ['o', opt_paths]].each do |prefix, paths|
				next unless paths
				paths.each do |path|
					file = File.basename( path )
					source = File.open( path ) { |f| f.read }
					# source
					@sp_src[ prefix + file ] = source
					# versions
					if /\$(Revision.*?)\s*\$/ =~ source then
						@sp_ver[ prefix + file ] = $1
					elsif /\$(Id.*?)\s*\$/ =~ source then
						@sp_ver[ prefix + file ] = $1
					end
				end
			end
		end	# if /conf/ =~ @mode

		# update options
		# we have to do this when we are eval'ed to update the config menu
		if /saveconf/ =~ @mode then
			@conf["#{Select_plugin_prefix}.selected"] = ''
			@conf["#{Select_plugin_prefix}.notselected"] = ''
			@sp_opt.each_key do |file|
				if 't' == @cgi.params[ "sp.#{file}" ][0] then
					@conf["#{Select_plugin_prefix}.selected"] << "#{file}\n"
				else
					@conf["#{Select_plugin_prefix}.notselected"] << "#{file}\n"
				end
			end
		end
	end # if Select_plugin_prefix == @cgi.params['conf'][0] then

	# Finally, we can eval the selected plugins as tdiary.rb does
	if @conf["#{Select_plugin_prefix}.selected"] then
		@conf["#{Select_plugin_prefix}.selected"].split( /\n/ ).sort.each do |file|
			next if /(\/|\\)/ =~ file	# / or \ should not appear
			path = "#{@options["#{Select_plugin_prefix}.path"]}/#{file}"
			begin
				load_plugin( path.untaint )
				@plugin_files << path
			rescue IOError, Errno::ENOENT	# for now, just ignore missing plugins
			end
		end
	end

end	# if @options["#{Select_plugin_prefix}.path"] then
