#
# 05referer.rb: Japanese resource of referer plugin
#
# Copyright (C) 2006, TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#

def referer_today; '�����Υ�󥯸�'; end
def volatile_referer; '�����������ؤΥ�󥯸�'; end

def label_no_referer; '��󥯸���Ͽ�����ꥹ��'; end
def label_only_volatile; '�����������ؤΥ�󥯸��˵�Ͽ����ꥹ��'; end
def label_referer_table; '����ִ��ꥹ��'; end

add_conf_proc( 'referer', '��󥯸�', 'referer' ) do
	saveconf_referer

	<<-HTML
	<h3 class="subtitle">��󥯸���ɽ��</h3>
	#{"<p>��󥯸��ꥹ�Ȥ�ɽ�����뤫�ɤ�������ꤷ�ޤ���</p>" unless @conf.mobile_agent?}
	<p><select name="show_referer">
		<option value="true"#{if @conf.show_referer then " selected" end}>ɽ��</option>
		<option value="false"#{if not @conf.show_referer then " selected" end}>��ɽ��</option>
	</select></p>
	<h3 class="subtitle">#{label_no_referer}</h3>
	#{"<p>��󥯸��ꥹ�Ȥ��ɲä��ʤ�URL����ꤷ�ޤ�������ɽ���ǻ���Ǥ��ޤ���1��1�Ԥ����Ϥ��Ƥ���������</p>" unless @conf.mobile_agent?}
	<p>��<a href="#{@conf.update}?referer=no" target="referer">��¸����Ϥ�����</a></p>
	<p><textarea name="no_referer" cols="70" rows="10">#{@conf.no_referer2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">#{label_only_volatile}</h3>
	#{"<p>�ְ����������ؤΥ�󥯸��פˤΤߵ�Ͽ������URL�Ϥ�����˵��Ҥ��ޤ����ְ����������ؤΥ�󥯸��פϡ����������դ�������񤯤Ⱦõ��ޤ�������ɽ���ǻ���Ǥ��ޤ���1��1�Ԥ����Ϥ��Ƥ���������</p>" unless @conf.mobile_agent?}
	<p>��<a href="#{@conf.update}?referer=volatile" target="referer">��¸����Ϥ�����</a></p>
	<p><textarea name="only_volatile" cols="70" rows="10">#{@conf.only_volatile2.join( "\n" )}</textarea></p>
	<h3 class="subtitle">#{label_referer_table}</h3>
	#{"<p>��󥯸��ꥹ�Ȥ�URL�������ʸ������Ѵ������б�ɽ�����Ǥ��ޤ���1��ˤĤ���URL��ɽ��ʸ��������Ƕ��ڤäƻ��ꤷ�ޤ�������ɽ�����Ȥ���Τǡ�URL��˸��줿��(��)�פϡ��ִ�ʸ������ǡ�\\1�פΤ褦�ʡ�\�����פ����ѤǤ��ޤ���</p>" unless @conf.mobile_agent?}
	<p>��<a href="#{@conf.update}?referer=table" target="referer">��¸����Ϥ�����</a></p>
	<p><textarea name="referer_table" cols="70" rows="10">#{@conf.referer_table2.collect{|a|a.join( " " )}.join( "\n" )}</textarea></p>
	HTML
end

