#
# 05referer.rb: English resource of referer plugin
#
# Copyright (C) 2006, TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#

def referer_today; "Today's Links"; end
def volatile_referer; "Links to old diaries"; end

def label_no_referer; "Today's Links Excluding List"; end
def label_only_volatile; "Volatile Links List"; end
def label_referer_table; "Today's Links Conversion Rule"; end

def nyear_diary_label(date, years); "my old days"; end
def nyear_diary_title(date, years); "same days in past"; end

add_conf_proc( 'referer', "Today's Link", 'referer' ) do
	saveconf_referer

	<<-HTML
	<h3 class="subtitle">Show links</h3>
	#{"<p>Select show or hide about Today's Link</p>" unless @conf.mobile_agent?}
	<p><select name="show_referer">
		<option value="true"#{if @conf.show_referer then " selected" end}>Show</option>
		<option value="false"#{if not @conf.show_referer then " selected" end}>Hide</option>
	</select></p>
	<h3 class="subtitle">#{label_no_referer}</h3>
	#{"<p>List of excluding URL that is not recorded to Today's Link. Specify it in regular expression, and a URL into a line.</p>" unless @conf.mobile_agent?}
	<p>See <a href="#{@conf.update}?referer=no" target="referer">Default configuration is here</a>.</p>
	<p><textarea name="no_referer" cols="60" rows="10">#{@conf.no_referer2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">#{label_only_volatile}</h3>
	#{"<p>List of URLs recorded to only volatile lists. This list will be clear when update diary in new day. Specify it in regular expression, and a URL into a line.</p>" unless @conf.mobile_agent?}
	<p>See <a href="#{@conf.update}?referer=volatile" target="referer">Default configuration is here</a>.</p>
	<p><textarea name="only_volatile" cols="60" rows="10">#{@conf.only_volatile2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">#{label_referer_table}</h3>
	#{"<p>A table to convert URL to words in Today's Link. Specify it in regular expression, and a URL into a line.<p>" unless @conf.mobile_agent?}
	<p>See <a href="#{@conf.update}?referer=table" target="referer">Default configurations</a>.</p>
	<p><textarea name="referer_table" cols="60" rows="10">#{@conf.referer_table2.collect{|a|a.join( " " )}.join( "\n" )}</textarea></p>
	HTML
end
