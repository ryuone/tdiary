# append-css.rb: $Revision%
#
# Append CSS fragment via Preferences Page.
#
# Copyright (c) 2002 TADA Tadashi <sho@spc.gr.jp>
# Distributed under the GPL
#
add_header_proc do
	<<-HTML if @conf['append-css.css']
	<style>
	#{CGI::escapeHTML( @conf['append-css.css'] )}
	</style>
	HTML
end

unless @resource_loaded then
	def append_css_label
		'CSSの追加'
	end

	def append_css_desc
		<<-HTML
		<h3>CSS断片</h3>
		<p>現在指定してあるテーマに、スタイルシートを追加設定する場合、
		以下にCSSの断片を入力してください。</p>
		HTML
	end
end

add_conf_proc( 'append-css', append_css_label ) do
	if @mode == 'saveconf' then
		@conf['append-css.css'] = @cgi.params['append-css.css'][0]
	end

	<<-HTML
	#{append_css_desc}
	<p><textarea name="append-css.css" cols="70" rows="15">#{CGI::escapeHTML( @conf['append-css.css'].to_s )}</textarea></p>
	HTML
end

