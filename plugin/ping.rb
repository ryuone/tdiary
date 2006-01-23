# ping.rb: $Revision: 1.8 $
#
# ping to weblog ping servers.
#
# Copyright (c) 2004 TADA Tadashi <sho@spc.gr.jp>
# Distributed under the GPL
#
# Modified: by MoonWolf <moonwolf@moonwolf.com>
#
add_update_proc do
	if @conf['ping.list'] then
		list = @conf['ping.list'].split
		ping( list ) unless list.empty?
	end
end

def ping( list )
	return unless @cgi.params['plugin_ping_send'][0] == 'true'

	xml = @ping_encoder.call( <<-XML )
<?xml version="1.0" encoding="#{@ping_encode}"?>
<methodCall>
  <methodName>weblogUpdates.ping</methodName>
  <params>
    <param>
      <value>#{@conf.html_title}</value>
    </param>
    <param>
      <value>#{@conf.base_url}</value>
    </param>
  </params>
</methodCall>
	XML

	require 'net/http'
	require 'timeout'
	Net::HTTP.version_1_1
	threads = []
	list.each do |url|
		threads << Thread.start( url, xml ) do |url, xml|
			if %r|^http://([^/]+)(.*)$| =~ url then
				begin
					request = $2.empty? ? '/' : $2
					host, port = $1.split( /:/, 2 )
					port = '80' unless port
					timeout(@conf['ping.timeout'].to_i) do
						Net::HTTP.start( host.untaint, port.to_i ) do |http|
							response, = http.post( request, xml, 'Content-Type' => 'text/xml' )
						end
					end
				rescue Exception,Timeout::Error
				end
			end
		end
	end
	threads.each {|t| t.join }
end

add_conf_proc( 'ping', @ping_label_conf, 'update' ) do
	ping_conf_proc
end

def ping_conf_proc
	if @mode == 'saveconf' then
		@conf['ping.list'] = @cgi.params['ping.list'][0]
		@conf['ping.timeout'] = @cgi.params['ping.timeout'][0]
	end
	@conf['ping.list'] = '' unless @conf['ping.list']
	@conf['ping.timeout'] = '3' unless @conf['ping.timeout']

	result = <<-HTML
		<h3>#{@ping_label_list}</h3>
		<p>#{@ping_label_list_desc}</p>
		<p><textarea name="ping.list" cols="70" rows="5">#{CGI::escapeHTML( @conf['ping.list'] )}</textarea></p>
		<h3>#{@ping_label_timeout}</h3>
		<p><input type="text" name="ping.timeout" value="#{CGI::escapeHTML( @conf['ping.timeout'] )}" /></p>
	HTML
end

add_edit_proc do
	ping_edit_proc
end

def ping_edit_proc
	checked = ' checked'
	if @mode == 'preview' then
		checked = @cgi.params['plugin_ping_send'][0] == 'false' ? ' checked' : ''
	end
	r = <<-HTML
	<div class="ping">
	<input type="checkbox" name="plugin_ping_send" value="true"#{checked}  tabindex="400" />
	#{@ping_label_send}
	</div>
	HTML
end
# vim: ts=3

