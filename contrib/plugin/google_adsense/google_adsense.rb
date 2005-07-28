#
# Google AdSense plugin for tDiary
#
# Copyright (C) 2004 Kazuhiko <kazuhiko@fdiary.net>
# You can redistribute it and/or modify it under GPL2.
#
# modified by TADA Tadashi <sho@spc.gr.jp>
#
def google_adsense( layout = nil )
	google_adsense_init( layout )
	google_ad_client = "pub-3317603667498586"
	google_ad_size = [
		[468, 60],	# 0
		[120, 600],	# 1
		[728, 90],	# 2
		[300, 250],	# 3
		[125, 125],	# 4
		[160, 600],	# 5
		[120, 240],	# 6
		[180, 150], # 7
		[250, 250], # 8
		[336, 280]  # 9
	]
	<<-EOF
<script type="text/javascript"><!--
google_ad_client = "#{google_ad_client}";
google_alternate_ad_url = ""
google_ad_width = #{google_ad_size[@conf['google_adsense.layout']][0]};
google_ad_height = #{google_ad_size[@conf['google_adsense.layout']][1]};
google_ad_format = "#{google_ad_size[@conf['google_adsense.layout']][0]}x#{google_ad_size[@conf['google_adsense.layout']][1]}_as";
google_color_border = "#{@conf['google_adsense.color.border']}";
google_color_bg = "#{@conf['google_adsense.color.bg']}";
google_color_link = "#{@conf['google_adsense.color.link']}";
google_color_url = "#{@conf['google_adsense.color.url']}";
google_color_text = "#{@conf['google_adsense.color.text']}";
//--></script>
<script type="text/javascript"
	src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
  EOF
end

def google_adsense_init( layout )
	if layout != nil then
		@conf['google_adsense.layout'] = layout.to_i
	else
		@conf['google_adsense.layout'] = 0 unless @conf['google_adsense.layout']
	end
	@conf['google_adsense.layout'] = @conf['google_adsense.layout'].to_i
	if @conf['google_adsense.layout'] < 0 or @conf['google_adsense.layout'] > 9 then
		@conf['google_adsense.layout'] = 0
	end

	@conf['google_adsense.color.border'] = 'CCCCCC' unless @conf['google_adsense.color.border']
	@conf['google_adsense.color.bg'] = 'FFFFFF' unless @conf['google_adsense.color.bg']
	@conf['google_adsense.color.link'] = '000000' unless @conf['google_adsense.color.link']
	@conf['google_adsense.color.url'] = '666666' unless @conf['google_adsense.color.url']
	@conf['google_adsense.color.text'] = '333333' unless @conf['google_adsense.color.text']
end

add_conf_proc( 'google_adsense', 'Google AdSense' ) do
	if @mode == 'saveconf' then
		@conf['google_adsense.layout'] = @cgi.params['google_adsense.layout'][0].to_i
		@conf['google_adsense.color.border'] = @cgi.params['google_adsense.color.border'][0]
		@conf['google_adsense.color.bg'] = @cgi.params['google_adsense.color.bg'][0]
		@conf['google_adsense.color.link'] = @cgi.params['google_adsense.color.link'][0]
		@conf['google_adsense.color.url'] = @cgi.params['google_adsense.color.url'][0]
		@conf['google_adsense.color.text'] = @cgi.params['google_adsense.color.text'][0]
	else
		google_adsense_init( nil )
	end

	<<-HTML
	<h3>�Хʡ��Υ�����(#{@conf['google_adsense.layout']})</h3>
	<p>����Хʡ��Υ�������������7���ढ��ޤ����������ʥ�����������Ǥ���������</p>
	<select name="google_adsense.layout">
		<option value="0"#{' selected' if @conf['google_adsense.layout'] == 0}>��Ĺ��������2��(468, 60)</option>
		<option value="2"#{' selected' if @conf['google_adsense.layout'] == 2}>��Ĺ�硦����4��(728, 90)</option>
		<option value="4"#{' selected' if @conf['google_adsense.layout'] == 4}>��������������1��(125, 125)</option>
		<option value="7"#{' selected' if @conf['google_adsense.layout'] == 7}>������������1��(180, 150)</option>
		<option value="8"#{' selected' if @conf['google_adsense.layout'] == 8}>�����桦����3��(250, 250)</option>
		<option value="3"#{' selected' if @conf['google_adsense.layout'] == 3}> �����硦����4��(300, 250)</option>
		<option value="9"#{' selected' if @conf['google_adsense.layout'] == 9}> �������硦����4��(336, 280)</option>
		<option value="6"#{' selected' if @conf['google_adsense.layout'] == 6}> ��Ĺ��������2��(120, 240)</option>
		<option value="1"#{' selected' if @conf['google_adsense.layout'] == 1}> ��Ĺ�桦����4��(120, 600)</option>
		<option value="5"#{' selected' if @conf['google_adsense.layout'] == 5}> ��Ĺ�硦����5��(160, 600)</option>
	</select>
	<h3>�Хʡ��ο�</h3>
	<p>�Хʡ��γƥѡ��Ĥο������Ǥ��ޤ���HTML��CSS��Ʊ����6���16�ʿ��ǻ��ꤷ�ޤ���</p>
	<ul>
		<li>��: <input name="google_adsense.color.border" size="6" value="#{@conf['google_adsense.color.border']}"></li>
		<li>�ط�: <input name="google_adsense.color.bg" size="6" value="#{@conf['google_adsense.color.bg']}"></li>
		<li>���: <input name="google_adsense.color.link" size="6" value="#{@conf['google_adsense.color.link']}"></li>
		<li>URL: <input name="google_adsense.color.url" size="6" value="#{@conf['google_adsense.color.url']}"></li>
		<li>�ƥ�����: <input name="google_adsense.color.text" size="6" value="#{@conf['google_adsense.color.text']}"></li>
	</ul>
	HTML
end

