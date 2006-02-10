#
# 05referer.rb: Traditional-Chinese resource of referer plugin
#
# Copyright (C) 2006, TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#

def referer_today; "�����嵲"; end
def volatile_referer; "Links to old diaries"; end

def label_no_referer; "�o�O���ѥ��C�X���嵲�C��"; end
def label_only_volatile; "Volatile Links List"; end
def label_referer_table; "Today's Link Conversion Rule"; end

# referer
add_conf_proc( 'referer', "�����嵲", 'referer' ) do
	saveconf_referer

	<<-HTML
	<h3 class="subtitle">�O�_�q�X�嵲</h3>
	#{"<p>�z�i�H��ܬO�_�n�q�X�u�����嵲�v�C </p>" unless @conf.mobile_agent?}
	<p><select name="show_referer">
		<option value="true"#{if @conf.show_referer then " selected" end}>�n</option>
		<option value="false"#{if not @conf.show_referer then " selected" end}>���n</option>
	</select></p>
	<h3 class="subtitle">#{label_no_referer}</h3>
	#{"<p>�b�u�����嵲�v�̤��n�O���_�Ӫ��嵲�C�ХH regular expression �Φ��@��@����w�C�Ӥ��Q�O�������}�C </p>" unless @conf.mobile_agent?}
	<p>�Ь�<a href="#{@conf.update}?referer=no" target="referer">�w�]�]�w</a>�C</p>
	<p><textarea name="no_referer" cols="70" rows="10">#{@conf.no_referer2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">#{label_only_volatile}</h3>
	#{"<p>List of URLs recorded to only volatile lists. This list will be clear when update diary in new day. Specify it in regular expression, and a URL into a line.</p>" unless @conf.mobile_agent?}
	<p>See <a href="#{@conf.update}?referer=volatile" target="referer">Default configuration is here</a>.</p>
	<p><textarea name="only_volatile" cols="70" rows="10">#{@conf.only_volatile2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">#{label_referer_table}</h3>
	#{"<p>�N�u�����嵲�v���S�w�����}�ഫ����N�q���r���A�ХH regular expression �Φ��@��@����w�C�ӭn���r���ഫ�����}�C <p>" unless @conf.mobile_agent?}
	<p>�Ь�<a href="#{@conf.update}?referer=table" target="referer">�w�]�]�w</a>.</p>
	<p><textarea name="referer_table" cols="70" rows="10">#{@conf.referer_table2.collect{|a|a.join( " " )}.join( "\n" )}</textarea></p>
	HTML
end
