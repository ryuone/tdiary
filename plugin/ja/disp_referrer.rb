=begin
= �����Υ�󥯸��⤦����äȤ��������ץ饰����((-$Id: disp_referrer.rb,v 1.32 2006-12-20 04:51:34 zunda Exp $-))
���ܸ�꥽����

== ����
����ƥʤ���Υ�󥯡����������󥸥�θ�����̤��̾�Υ�󥯸��β��ˤ�
�Ȥ��ɽ�����ޤ������������󥸥�θ�����̤ϡ���������ˤޤȤ���ޤ���

�ǿ���������ɽ���Ǥϡ��̾�Υ�󥯸��ʳ��Υ�󥯸��򱣤��ޤ���

== ���
��������(1.1.2.39����)���饳���ɤΤۤȤ�ɤ�������ʤ��������ᡢ
* �������󥸥�˴ؤ���ư��㤦
* �ѻߤ��줿���ץ���󤬤���
* ���ץ����̾���ѹ����줿
�Ȥ�����ߴ�������ޤ�������Ū�������WWW�֥饦������Ǥ���褦�ˤʤä�
���ޤ��Τǡ��������Ƥ������������ߤޤ���

�������Ǥ���٤�ȡ�
* ����å���ˤ��ɽ������®�����줿((-�긵�Ǥϡ�����å����Ȥ�ʤ���
  ��ˤ���٤ơ�1��ʬ��2/3�ۤɡ��ǿ�3��ʬ��1/2�ۤɤμ»��֤�����������
  ����ޤ���-))�����ε�ǽ�ϻ�ǰ�ʤ��顢��󥿥������ʤ�secure=true������
  �ǤϻȤ��ޤ���
* ��󥯸��ִ��ꥹ�Ȥˤʤ�URL�����Ū��ñ��WWW�֥饦������ꥹ�Ȥ��ɲä�
  ����褦�ˤʤä�
* �ִ����ʸ����κǽ��[]�ǰϤޤ줿ʸ��������뤳�Ȥˤ�äơ��桼����
  �����ƥ��꡼�����ߤǤ���褦�ˤʤä���((-tDiary���ΤȤϰ㤤�����Ĥ�
  URL�ϣ��ĤΥ��ƥ��꡼�������Ƥʤ����Ȥˤ���դ���������-))
* ����Ū�������WWW�֥饦������Ǥ���褦�ˤʤä�
* disp_referrer.rb��̵���Ƥ�Ȥ���
* Uconv�饤�֥���Nora�饤�֥�꤬����Ф���ʤ�ˡ�̵����Фʤ��ʤ��
  ư���
�Ȥ�������������ޤ���

== �Ȥ���
���Υץ饰����򥤥󥹥ȡ��뤹�뤳�Ȥǡ��ǥե���ȤǤϡ�
* ����ʬ��������ɽ���ǡ��������Υ�󥯸��פ�����ƥʡ��������󥸥󡢤���
  ¾�ˤޤȤ��ɽ�������褦�ˤʤ�ޤ����ִ����ʸ����κǸ��()�������
  �����ȥ�ǥ��롼�פ��ޤ����ޤ����������󥸥󤫤�Υ�󥯤ϡ��������
  �̤ˤޤȤ���ޤ���
* �ǿ���������ɽ���ǡ��������Υ�󥯸��פ˥���ƥʤ両�����󥸥󤫤�Υ�
  �󥯤�ɽ������ʤ��ʤ�ޤ���
��󥯸�URL�Υ����ȥ�ؤ��ִ��ϡ�tDiary���ΤΥ�󥯸��ִ��ꥹ�Ȥ�Ȥ���
����

���ץ����ˤĤ��Ƥϲ���������������������Ū�ʥ��ץ����ϡ�tDiary����
����̤��顢�֥�󥯸��⤦����äȶ����פ򥯥�å����뤳�Ȥ�����Ǥ��ޤ���
�������ꤹ����ˤϡ�
  Insecure: can't modify hash (SecurityError)
�Ȥ������顼���Ф��ǽ��������ޤ��������tDiary������Ǥ������ξ��ˤϡ�
tDiary�򿷤�������1.5.5.20030806�ʹߤ�Ȥ������ִ��ܡפ��鲿���ѹ����� 
�ˡ�OK�פ򲡤����Ȥǥ��顼�����Ǥ���Ǥ��礦��

��󥯸��ִ��ꥹ�Ȥ䥪�ץ������ѹ��������ϡ�����å���ǥ��쥯�ȥ�
�ˤ��륭��å���ե�����disp_referrer2.cache��disp_referrer2.cache~���
�饰�����������̤��鹹������ɬ�פ�����ޤ������Υץ饰�����������̤�
���ѹ��������ܤˤĤ��Ƥϡ��ѹ����˥���å���ι����⤷�ޤ���

��󥯸��ϡ��ʲ��Τ褦�ʴ���ʬ�व��ޤ���

: �̾�Υ�󥯸�(�������Υ�󥯸���)
  ��󥯸��ִ��ꥹ�Ȥˤ��ƤϤޤ�URL�Τ����������ʳ��Τ�Ρ�
  @options['disp_referrer2.unknown.divide']=false�ξ��ϡ���󥯸��ִ�
  �ꥹ�Ȥˤ��ƤϤޤ�ʤ�URL�⤳���˴ޤޤ�ޤ���

  ����ˡ���󥯸��ִ��ꥹ�Ȥˤ�ä��ִ����줿���ʸ����κǽ��[]�ǰϤ�
  �줿ʸ���󤬤�����ϡ�����򥫥ƥ��꡼�Ȳ�ᤷ�ƥ��ƥ��꡼�̤�ɽ����
  ʬ���ޤ������ε�ǽ����������ˤϡ�WWW�֥饦������������̤����Ѥ��뤫��
  tdiary.conf��@options['disp_referrer2.normal.categorize']=false�ˤ���
  �������������Υ��ץ������ѹ��������ˤϥ���å���򹹿�����ɬ�פ���
  ��ޤ���

: ����ƥ�
  URL�� /a/ antenna/ antenna. �ʤɤ�ʸ���󤬴ޤޤ�뤫���ִ����ʸ����ˡ�
  ����ƥ� links �ʤɤ�ʸ���󤬴ޤޤ���󥯸��Ǥ��������ξ��ϡ�
  @options['disp_referrer2.antenna.url']��
  @options['disp_referrer2.antenna.title']�ˤ�ä��ѹ��Ǥ��ޤ���
  tdiary.conf���Խ����Ƥ�������������å���򹹿�����ɬ�פ�����ޤ���

: ����¾
  ��󥯸��ִ��ꥹ�Ȥˤʤ��ä�URL�Ǥ������ޤ�Ĺ��URL�ϡ�tDiary���Τ��ִ�
  �ꥹ�Ȥˤ�ä��̾�Υ�󥯸���ʬ�व��Ƥ��ޤ���ǽ��������ޤ���

: ����
  ���Υץ饰����˴ޤޤ�븡�����󥸥�Υꥹ�Ȥ˰��פ���URL�Ǥ����ꥹ��
  ��DispRef2Setup::Engines�ˤ���ޤ������ޤ��������󥸥��ǧ������ʤ�
  URL�ϡ��ۤȤ�ɤξ�硢�̾�Υ�󥯸��˺����ä�ɽ������Ƥ��ޤ��Ǥ���
  �������Τ褦�ʾ��ϡ�URL��
  ((<URL:http://tdiary-users.sourceforge.jp/cgi-bin/wiki.cgi?disp_referrer2.rb>))
  ���Τ餻�Ƥ���������Ⱥ�Ԥ���Ӥޤ���

=== �Ķ�
ruby-1.6.7��1.8.0��ư����ǧ���Ƥ��ޤ�������ʳ��ΥС�������Ruby�Ǥ�
ư��뤫�⤷��ޤ���

tdiary-1.5.3-20030509�ʹߤǻȤ��ޤ������������tDiary-1.5�Ǥϡ�
00default.rb��bot?�᥽�åɤ��������Ƥ��ʤ����ᡢ�������󥸥�Υ�����
���Ф��ƥ�󥯸���ɽ������Ƥ��ޤ��ޤ���

secure�⡼�ɤǤ�Ȥ��ޤ�������å���ˤ���®�����Ǥ��ޤ���

mod_ruby�Ǥ�ư��Ϻ��ΤȤ����ǧ���Ƥ��ޤ���

=== ���󥹥ȡ�����ˡ
���Υե������tDiary��plugin�ǥ��쥯�ȥ���˥��ԡ����Ƥ������������Υץ�
������κǿ��Ǥϡ�
((<URL:http://zunda.freeshell.org/d/plugin/disp_referrer2.rb>))
�ˤ���Ϥ��Ǥ���

�ޤ���Nora�饤�֥�꤬���󥹥ȡ��뤵��Ƥ�����ˤϡ�URL�β���HTML��
���������פˡ�Ruby��ɸ��ź�դ�CGI�饤�֥��������Nora�饤�֥����
�Ѥ��ޤ�������ˤ�ꡢ����®�٤��㴳®���ʤ�ޤ�((-�긵�ǻ���Ȥ���
����ʬ��ɽ���ˤ�������֤�1������û�����ʤ�ޤ�����-))��Nora�ˤĤ��Ƥξ�
�٤ϡ�((<URL:http://raa.ruby-lang.org/list.rhtml?name=Nora>))�򻲾Ȥ���
����������

=== ���ץ����
��������������Ǥ��륪�ץ����ΰ����ϡ�DispRef2Setup::Defaults�ˤ����
���������Υ��ץ�����key�κǽ�ˡ���disp_referrer2.�פ��ɲä��뤳��
�ǡ�tdiary.conf��@options��key�Ȥʤꡢtdiary.conf��������Ǥ���褦�ˤ�
��ޤ��������Υ��ץ����Τ�����DispRef2URL::Cached_options�˵󤲤��
�Ƥ����Τϡ��ѹ��κݤ˥���å���ι�����ɬ�פǤ���

�ޤ���tDiary��������̤���֥�󥯸��⤦����äȶ����פ����֤��Ȥ�WWW��
�饦����������Ǥ�����ܤ⤢��ޤ���

== �ռ�
���Υץ饰����ϡ�
* UTF-8ʸ�����EUCʸ����ؤ��Ѵ���ǽ
* �����θ������󥸥�̾�Ȥ���URL
* �������󥸥�Υ�ܥåȤΥ�����󥰤κݤ˥�󥯸���ɽ�����ʤ���ǽ
��MUTOH Masao�����disp_referrer.rb���饳�ԡ����Խ����ƻȤ碌�Ƥ�����
���Ƥ��ޤ���(�������󥸥�Υ�ܥåȤ˴ؤ��뵡ǽ�ϸ��ߤ�tDiary���ΤˤȤ�
���ޤ�Ƥ��ޤ���)

�ޤ���URL���᤹�뵡ǽ�ΰ�����Ruby����°��cgi.rb���饳�ԡ����Խ�����
�Ȥ碌�Ƥ��������Ƥ��ޤ���

����ˡ��̾�Υ�󥯸���[]�ǰϤޤ줿ʸ�����Ȥäƥ��ƥ���ʬ�����륢����
�����ϡ�kazuhiko����Τ�ΤǤ���

���ͤ˴��դ������ޤ���

== Todos
* secure=true�ǥ�󥯸��ִ��ꥹ�ȤΥƥ����ȥե�����ɤǥ꥿����򲡤����ݤ�ư��
* parse_as_search��®��: hostname�Υ���å��塩

== ����ˤĤ���
Copyright (C) 2003 zunda <zunda at freeshell.org>

Please note that some methods in this plugin are written by other
authors as written in the comments.

Permission is granted for use, copying, modification, distribution, and
distribution of modified versions of this work under the terms of GPL
version 2 or later.
=end

=begin ChangeLog
See ../ChangeLog for changes after this.

* Mon Sep 29, 2003 zunda <zunda at freeshell.org>
- forgot to change arguments after changing initialize()
* Thu Sep 25, 2003 zunda <zunda at freeshell.org>
- name.untaint to eval name
* Thu Sep 25, 2003 zunda <zunda at freeshell.org>
- use to_native instead of to_euc
* Mon Sep 19, 2003 zunda <zunda at freeshell.org>
- disp_referrer2.rb,v 1.1.2.104 commited as disp_referrer.rb
* Mon Sep  1, 2003 zunda <zunda at freeshell.org>
- more strcit check for infoseek search enigne
* Wed Aug 27, 2003 zunda <zunda at freeshell.org>
- rd.yahoo, Searchalot, Hotbot added
* Tue Aug 12, 2003 zunda <zunda at freeshell.org>
- search engine list cleaned up
* Mon Aug 11, 2003 zunda <zunda at freeshell.org>
- instance_eval for e[2] in the search engine list
* Wed Aug  7, 2003 zunda <zunda at freeshell.org>
- WWW browser configuration interface
  - ����å���ι�������μ¤ˤ���褦�ˤ��ޤ�����WWW�֥饦�������ִ�
    �ꥹ�Ȥ��ä����ˤϥꥹ�Ȥκǽ���ɲä���ޤ���
  - secure=true�������Ǥ���¾�Υ�󥯸��ꥹ�Ȥ�ɽ���Ǥ���褦�ˤʤ�ޤ�����
- Regexp generation for Wiki sites
* Wed Aug  6, 2003 zunda <zunda at freeshell.org>
- WWW browser configuration interface
  - ��ʥ��ץ����ȥ�󥯸��ִ��ꥹ�Ȥθ�ΨŪ���Խ���WWW�֥饦�������
    ����褦�ˤʤ�ޤ�����secure=true�������Ǥϰ����ε�ǽ�ϻȤ��ޤ���
* Sat Aug  2, 2003 zunda <zunda at freeshell.org>
- Second version
- basic functions re-implemented
  - ���ץ�����̿̾���ʤ����ޤ������ޤ����פʥ��ץ�����ä��ޤ�����
    tdiary.conf���Խ����Ƥ������ϡ�������Ǥ�������򤷤ʤ����Ƥ���������
  - Nora�饤�֥��ȥ���å�������Ѥǹ�®�����ޤ�����
  - �������󥸥�Υꥹ�Ȥ�ץ饰����ǻ��Ĥ褦�ˤʤ�ޤ�����&��;��ޤม
    ��ʸ���������̤����ФǤ��ޤ���
* Mon Feb 17, 2003 zunda <zunda at freeshell.org>
- First version
=end

# Message strings
Disp_referrer2_name = '��󥯸��⤦����äȶ���'.taint
Disp_referrer2_abstract = <<'_END'.taint
<p>
	����ƥʤ���Υ�󥯡����������󥸥�θ�����̤�
	�̾�Υ�󥯸��β��ˤޤȤ��ɽ�����ޤ���
	���������󥸥�θ�����̤ϡ���������ˤޤȤ���ޤ���
</p>
_END
Disp_referrer2_with_Nora = <<'_END'.taint
<p>
	Nora�饤�֥���ȤäƤ��ޤ��Τǡ�ɽ��������®���Ϥ��Ǥ���
</p>
_END
Disp_referrer2_without_Nora = <<'_END'.taint
<!-- p>
	ɽ��®�٤����ˤʤ���ϡ�
	<a href="http://www.moonwolf.com/ruby/archive/nora-20040830.tar.gz">Nora
	�饤�֥��</a>�򥤥󥹥ȡ��뤷�ƤߤƤ���������
</p -->
_END
Disp_referrer2_cache_info = <<'_END'.taint
<p>
	���ߡ�����å�����礭����%1$s�Х��ȤǤ���
</p>
_END
Disp_referrer2_update_info = <<'_END'.taint
<p>
	��<a href="%1$s">��󥯸�</a>�פ��ѹ��θ�ˤϡ�
	���Υ����å��ܥå���
  ��<input name="dr2.cache.update" value="force" type="checkbox">����å���򥯥ꥢ�����
	�����å����Ƥ���OK�򥯥�å����ơ�
	����å���Υ��ꥢ�򤷤Ƥ�������
</p>
_END
Disp_referrer2_move_to_refererlist = <<'_END'.taint
	����¾�Υ�󥯸����ִ��ꥹ�Ȥ��Խ���<a href="%s">�ܤ�</a>��
_END
Disp_referrer2_move_to_config = <<'_END'.taint
	����Ū�������<a href="%s">�ܤ�</a>��
_END
Disp_referrer2_also_todayslink = <<'_END'.taint
	��󥯸��ִ��ꥹ�Ȥϡ�<a href="%s">��󥯸�</a>�פ�����Խ��Ǥ��ޤ���
_END
Disp_referrer2_antenna_label = '����ƥ�'.taint
Disp_referrer2_unknown_label = '����¾�Υ�󥯸�'.taint
Disp_referrer2_search_label = '����'.taint
Disp_referrer2_search_unknown_keyword = '�����������'.taint
Disp_referrer2_cache_label = '(%s�Υ���å���)'.taint

class DispRef2SetupIF

	# show options
	def show_options
		r = <<-_HTML
			<h3>��󥯸���ʬ���ɽ��</h3>
			<table>
			<tr>
				<td><input name="dr2.current_mode" value="#{Options}" type="hidden">
				��󥯸��ִ��ꥹ�Ȥˤʤ���󥯸���
				<td><input name="dr2.unknown.divide" value="true" type="radio"#{' checked'if @setup['unknown.divide']}>#{@setup['unknown.label']}�Ȥ���ʬ����
				<td><input name="dr2.unknown.divide" value="false" type="radio"#{' checked'if not @setup['unknown.divide']}>�̾�Υ�󥯸��Ⱥ����롣
			<tr>
				<td>#{@setup['unknown.label']}��
				<td><input name="dr2.unknown.hide" value="false" type="radio"#{' checked'if not @setup['unknown.hide']}>ɽ������
				<td><input name="dr2.unknown.hide" value="true" type="radio"#{' checked'if @setup['unknown.hide']}>������
			<tr>
				<td>��󥯸��ִ��ꥹ�Ȥ��ִ����ʸ����κǽ��[]�򥫥ƥ��꡼ʬ����
				<td><input name="dr2.normal.categorize" value="true" type="radio"#{' checked'if @setup['normal.categorize']}>�Ȥ�
				<td><input name="dr2.normal.categorize" value="false" type="radio"#{' checked'if not @setup['normal.categorize']}>�Ȥ�ʤ���
			<tr>
				<td>����ʬ��ɽ���ǡ��̾�Υ�󥯸��ʳ��Υ�󥯸���
				<td><input name="dr2.long.only_normal" value="false" type="radio"#{' checked'if not @setup['long.only_normal']}>ɽ������
				<td><input name="dr2.long.only_normal" value="true" type="radio"#{' checked'if @setup['long.only_normal']}>������
			<tr>
				<td>�ǿ���ɽ���ǡ��̾�Υ�󥯸��ʳ��Υ�󥯸���
				<td><input name="dr2.short.only_normal" value="false" type="radio"#{' checked'if not @setup['short.only_normal']}>ɽ������
				<td><input name="dr2.short.only_normal" value="true" type="radio"#{' checked'if @setup['short.only_normal']}>������
			</table>
			<p>�ǿ���ɽ���ǡ��̾�Υ�󥯸��ʳ��Υ�󥯸���ɽ��������ˤϡ����Υץ饰����̵�����Ȥޤä���Ʊ��ɽ���ˤʤ�ޤ���</p>
			<h3>�̾�Υ�󥯸��Υ��롼�ײ�</h3>
			<table>
			<tr>
				<td>�̾�Υ�󥯸���
				<td><input name="dr2.normal.group" value="true" type="radio"#{' checked'if @setup['normal.group']}>�ִ����ʸ����ǤޤȤ��
				<td><input name="dr2.normal.group" value="false" type="radio"#{' checked'if not @setup['normal.group']}>URL���ʬ���롣
			<tr>
				<td>�̾�Υ�󥯸����ִ����ʸ����ǤޤȤ����ˡ��Ǹ��()��
				<td><input name="dr2.normal.ignore_parenthesis" value="true" type="radio"#{' checked'if @setup['normal.ignore_parenthesis']}>̵�뤹�� /
				<td><input name="dr2.normal.ignore_parenthesis" value="false" type="radio"#{' checked'if not @setup['normal.ignore_parenthesis']}>̵�뤷�ʤ���
			</table>
			<h3>����ƥʤ���Υ�󥯤Υ��롼�ײ�</h3>
			<table>
			<tr>
				<td>����ƥʤ���Υ�󥯤�
				<td><input name="dr2.antenna.group" value="true" type="radio"#{' checked'if @setup['antenna.group']}>�ִ����ʸ����ǤޤȤ��
				<td><input name="dr2.antenna.group" value="false" type="radio"#{' checked'if not @setup['antenna.group']}>URL���ʬ���롣
			<tr>
				<td>����ƥʤ���Υ�󥯤��ִ����ʸ����ǤޤȤ����ˡ��Ǹ��()��
				<td><input name="dr2.antenna.ignore_parenthesis" value="true" type="radio"#{' checked'if @setup['antenna.ignore_parenthesis']}>̵�뤹��
				<td><input name="dr2.antenna.ignore_parenthesis" value="false" type="radio"#{' checked'if not @setup['antenna.ignore_parenthesis']}>̵�뤷�ʤ���
			</table>
			<h3>����������ɤ�ɽ��</h3>
			<table>
			<tr>
				<td>�������󥸥�̾��
				<td><input name="dr2.search.expand" value="true" type="radio"#{' checked'if @setup['search.expand']}>ɽ������
				<td><input name="dr2.search.expand" value="false" type="radio"#{' checked'if not @setup['search.expand']}>ɽ�����ʤ���
			</table>
		_HTML
		unless @setup.secure then
		r << <<-_HTML
			<h3>����å���</h3>
			<table>
			<tr>
				<td>����å����
				<td><input name="dr2.no_cache" value="false" type="radio"#{' checked'if not @setup['no_cache']}>���Ѥ���
				<td><input name="dr2.no_cache" value="true" type="radio"#{' checked'if @setup['no_cache']}>���Ѥ��ʤ���
			<tr>
				<td>����å�����礭����
				<td colspan="3"><input name="dr2.cache_max_size" value="#{@setup['cache_max_size']}" type="text">�Х��ȤޤǤˤ��롣
			<tr>
				<td>����������ѹ��ǡ�����å����
				<td><input name="dr2.cache.update" value="force" type="radio">���ꥢ����
				<td><input name="dr2.cache.update" value="auto" type="radio" checked>ɬ�פʤ饯�ꥢ����
				<td><input name="dr2.cache.update" value="never" type="radio">���ꥢ���ʤ���
			</table>
			<p>����å�����礭�������¤��ܰ¤Ǥ�����������礭���ʤ���⤢��ޤ�������å�����礭�������¤�0�ˤ���ȡ�����å�����礭�������¤��ʤ��ʤ�ޤ����Ǹ��K��M��Ĥ���ȡ�����Х��ȡ��ᥬ�Х���ñ�̤ˤʤ�ޤ���</p>
		_HTML
		end # unless @setup.secure
		r
	end

	# shows URL list to be added to the referer_table or no_referer
	def show_unknown_list
		if @setup.secure then
			urls = DispRef2Latest.new( @cgi, 'latest.rhtml', @conf, @setup ).unknown_urls
		else
			urls = DispRef2Cache.new( @setup ).urls( DispRef2URL::Unknown ).keys
			if urls.size == 0 then
				urls = DispRef2Latest.new( @cgi, 'latest.rhtml', @conf, @setup ).unknown_urls
			end
		end
		urls.reject!{ |url| DispRef2String::url_match?( url, @setup['reflist.ignore_urls'] ) }
		r = <<-_HTML
			<h3>��󥯸��ִ��ꥹ��</h3>
			<input name="dr2.current_mode" value="#{RefList}" type="hidden">
			<p>��󥯸�̵��ꥹ�Ȥ˰��פ���URL�Ϥ����ˤ�ɽ������ޤ���</p>
		<p>
			��󥯸��ִ��ꥹ�Ȥ䵭Ͽ�����ꥹ�Ȥˤ����줿���ʤ�URL�ϡ�
			̵��ꥹ�Ȥ�����Ƥ������Ȥǡ�
			�����Υꥹ�Ȥ˸���ʤ��ʤ�ޤ���
			̵��ꥹ�Ȥϡ�
			�����Υꥹ�Ȥ�URL��ɽ�����뤫�ɤ�����Ƚ�Ǥˤ����Ȥ��ޤ���
			<input name="dr2.clear_ignore_urls" value="true" type="checkbox">̵��ꥹ�Ȥ���ˤ�����ϥ����å����Ʋ�������
		</p>
		_HTML
		if urls.size > 0 then
			r << <<-_HTML
				<p>��󥯸��ִ��ꥹ�Ȥˤʤ�������URL��
					��󥯸��ִ��ꥹ�Ȥ��������ϡ�
					���ʤζ���˥����ȥ�����Ϥ��Ƥ���������
					�ޤ�����󥯸���Ͽ�����ꥹ�Ȥ��ɲä���ˤϡ�
					�����å��ܥå���������å����Ƥ���������
				</p>
				<p>
					����ɽ���ϥ�󥯸��ִ��ꥹ�Ȥ��ɲä���Τ�Ŭ���ʤ�ΤˤʤäƤ��ޤ���
					��ǧ���ơ��Զ�礬������Խ����Ƥ���������
					��󥯸��ִ��ꥹ�Ȥˤ����ɲä�����ˤϡ�
					�⤦�����ޥå��ξ�郎�ˤ���ΤǤ⤫�ޤ��ޤ���
				</p>
				<p>
					�Ǹ�ζ���ϡ���󥯸��ִ��ꥹ�Ȥ��ɲä���ݤΥ����ȥ�Ǥ���
					URL��˸��줿��(��)�פϡ�
					�ִ�ʸ������ǡ�\\1�פΤ褦�ʡֿ����פ����ѤǤ��ޤ���
					�ޤ���sprintf('[tdiary:%d]', $1.to_i+1) �Ȥ��ä���
					������ץ��Ҥ����ѤǤ��ޤ���
				</p>
			_HTML
			if @cgi.auth_type and @cgi.remote_user and @setup['configure.use_link'] then
				r << <<-_HTML
					<p>
						���줾���URL�ϥ�󥯤ˤʤäƤ��ޤ���������򥯥�å����뤳�Ȥǡ�
						�����ˡ����������ι����������Ѥ�URL���Τ��뤳�Ȥˤʤ�ޤ���
						Ŭ�ڤʥ����������¤�̵�����ˤϥ���å����ʤ��褦�ˤ��Ƥ���������
					</p>
				_HTML
			end
			r << <<-_HTML
				<p>
					�����ˤʤ�URL�ϡ�<a href="#{@conf.update}?conf=referer">��󥯸�</a>�פ��齤�����Ƥ���������
				</p>
				<dl>
			_HTML
			i = 0
			urls.sort.each do |url|
				shown_url = DispRef2String::escapeHTML( @setup.to_native( DispRef2String::unescape( url ) ) )
				if @cgi.auth_type and @cgi.remote_user and @setup['configure.use_link'] then
					r << "<dt><a href=\"#{url}\">#{shown_url}</a>"
				else
					r << "<dt>#{shown_url}"
				end
				r << <<-_HTML
					<dd>
						<input name="dr2.#{i}.noref" value="true" type="checkbox">�����ꥹ�Ȥ��ɲ�
						<input name="dr2.#{i}.ignore" value="true" type="checkbox">̵��ꥹ�Ȥ��ɲ�<br>
						<input name="dr2.#{i}.reg" value="#{DispRef2String::escapeHTML( DispRef2String::url_regexp( url ) )}" type="text" size="70"><br>
						<input name="dr2.#{i}.title" value="" type="text" size="70">
				_HTML
				i += 1
			end
			r << <<-_HTML
				<input name="dr2.urls" type="hidden" value="#{i}">
				</dl>
			_HTML
		else
			r << <<-_HTML
				<p>���ߡ�#{@setup['unknown.label']}�Ϥ���ޤ���</p>
			_HTML
		end
		r << <<-_HTML
			<h3>����ƥʤΤ��������ɽ��</h3>
			<p>����ƥʤ�URL���ִ����ʸ����˥ޥå���������ɽ���Ǥ���
				����������ɽ���˥ޥå������󥯸��ϡ֥���ƥʡפ�ʬ�व��ޤ���</p>
			<ul>
			<li>URL:
				<input name="dr2.antenna.url" value="#{DispRef2String::escapeHTML( @setup.to_native( @setup['antenna.url'] ) )}" type="text" size="70">
				<input name="dr2.antenna.url.default" value="true" type="checkbox">�ǥե���Ȥ��᤹
			<li>�ִ����ʸ����:<input name="dr2.antenna.title" value="#{DispRef2String::escapeHTML( @setup.to_native( @setup['antenna.title'] ) )}" type="text" size="70">
				<input name="dr2.antenna.title.default" value="true" type="checkbox">�ǥե���Ȥ��᤹
			</ul>
			_HTML
		r
	end
end

# Hash table of search engines
# key: company name
# value: array of:
# [0]:url regexp [1]:title [2]:keys for search keyword [3]:cache regexp
DispReferrer2_Google_cache = /cache:[^:]+:([^+]+)+/
DispReferrer2_Yahoofs = /u=(.+)/
DispReferrer2_Engines = {
	'google' => [
		[%r{\Ahttp://(?:[^./]+\.)*?google\.([^/]+)/(search|custom|ie)}i, '".#{$1}��Google����"', ['as_q', 'q', 'as_epq'], DispReferrer2_Google_cache],
		[%r{\Ahttp://.*?\bgoogle\.([^/]+)/.*url}i, '".#{$1}��Google��URL����?"', ['as_q', 'q'], DispReferrer2_Google_cache],
		[%r{\Ahttp://.*?\bgoogle/search}i, '"���֤�Google����"', ['as_q', 'q'], DispReferrer2_Google_cache],
		[%r{\Ahttp://eval.google\.([^/]+)}i, '".#{$1}��Google Accounts"', [], nil],
		[%r{\Ahttp://(?:[^./]+\.)*?google\.([^/]+)}i, '".#{$1}��Google����"', [], nil],
		[%r{\Ahttp://images\.google\.([^/]+)/imgres}i, '".#{$1}��Google���᡼������"', ['imgurl'], DispReferrer2_Google_cache],
	],
	'yahoo' => [
		[%r{\Ahttp://.*?\.rd\.yahoo\.([^/]+)}i, '".#{$1}��Yahoo�Υ�����쥯��"', 'split(/\*/)[1]', nil],
		[%r{\Ahttp://srd\.yahoo\.co\.jp}i, '"Yahoo�Υ�����쥯��"', [], nil],
		[%r{\Ahttp://rd.+\.yahoo\.com}i, '"Yahoo�Υ�����쥯��"', [], nil], # ���󥸥�� inktomi ���ȸ�����
		[%r{\Ahttp://[^bm]*?\.yahoo\.([^/]+)}i, '".#{$1}��Yahoo!����"', ['p', 'va', 'vp'], DispReferrer2_Google_cache],
		[%r{\Ahttp://wrs\.search\.yahoo\.([^/]+)/(?:.*)K=([^/]+)}i, 'keyword=$2; "#{$1}��Yahoo!����"', [], nil],
	],
	'yahoofs' => [[%r{\Ahttp://cache\.yahoofs\.jp/}i, '"Yahoo!����"', ['w'], DispReferrer2_Yahoofs]],
	'netscape' => [[%r{\Ahttp://.*?\.netscape\.([^/]+)}i, '".#{$1}��Netscape����"', ['search', 'query'], DispReferrer2_Google_cache]],
	'msn' => [[%r{\Ahttp://.*?\.MSN\.([^/]+)}i, '".#{$1}��MSN������"', ['q', 'MT'], nil ]],
	'metacrawler' => [[%r{\Ahttp://.*?.metacrawler.com}i, '"MetaCrawler"', ['q'], nil ]],
	'metabot' => [[%r{\Ahttp://.*?\.metabot\.ru}i, '"MetaBot.ru"', ['st'], nil ]],
	'altavista' => [[%r{\Ahttp://.*altavista\.([^/]+)}i, '".#{$1}��AltaVista����"', ['q'], nil ]],
	'infoseek' => [[%r{\Ahttp://(www\.)?infoseek\.co\.jp}i, '"����ե�������"', ['qt'], nil ]],
	'odn' => [[%r{\Ahttp://.*?\.odn\.ne\.jp}i, '"ODN����"', ['QueryString', 'key'], nil ]],
	'lycos' => [[%r{\Ahttp://.*?\.lycos\.([^/]+)}i, '".#{$1}��Lycos"', ['query', 'q', 'qt'], nil ]],
	'fresheye' => [[%r{\Ahttp://.*?\.fresheye}i, '"�ե�å��奢��"', ['kw'], nil ]],
	'goo' => [
		[%r{\Ahttp://((www|ocn|dictionary|kids|eco|oshiete|.*search|community|machi|bb|bsearch|dir|channel|ocnsearch)\.)?goo\.ne\.jp}i, '"goo"', ['MT'], nil ],
		[%r{\Ahttp://((www|ocn|dictionary|kids|eco|oshiete|.*search|community|machi|bb|bsearch|dir|channel|ocnsearch)\.)?goo\.ne\.jp}i, '"goo"', [], nil ],
		[%r{\Ahttp://.*mobile\.goo\.ne\.jp/search_i.jsp}i, '"goo"', ['MT'], nil ],
	],
	'nifty' => [
		[%r{\Ahttp://search\.nifty\.com}i, '"@nifty/@search"', ['q', 'Text'], DispReferrer2_Google_cache],
		[%r{\Ahttp://srchnavi\.nifty\.com}i, '"@nifty�Υ�����쥯��"', ['title'], nil ],
	],
	'eniro' => [[%r{\Ahttp://.*?\.eniro\.se}i, '"Eniro"', ['q'], DispReferrer2_Google_cache]],
	'excite' => [[%r{\Ahttp://.*?\.excite\.([^/]+)}i, '".#{$1}��Excite"', ['search', 's', 'query', 'qkw'], nil ]],
	'biglobe' => [
		[%r{\Ahttp://.*?search\.biglobe\.ne\.jp}i, '"BIGLOBE������"', ['q'], nil ],
		[%r{\Ahttp://.*?search\.biglobe\.ne\.jp}i, '"BIGLOBE������"', [], nil ],
	],
	'dion' => [[%r{\Ahttp://dir\.dion\.ne\.jp}i, '"Dion"', ['QueryString', 'key'], nil ]],
	'naver' => [[%r{\Ahttp://.*?\.naver\.co\.jp}i, '"NAVER Japan"', ['query'], nil ]],
	'webcrawler' => [[%r{\Ahttp://.*?\.webcrawler\.com}i, '"WebCrawler"', ['qkw'], nil ]],
	'euroseek' => [[%r{\Ahttp://.*?\.euroseek\.com}i, '"Euroseek.com"', ['string'], nil ]],
	'aol' => [
		[%r{\Ahttp://.*?\.aol\.}i, '"AOL������"', ['query', 'query_contain'], nil ],
		[%r{\Ahttp://aolsearch\..+\.aol\.com/redir_convert.adp}i, '"AOL������"', ['query_contain'], nil]
	],
	'alltheweb' => [
		[%r{\Ahttp://.*?\.alltheweb\.com}i, '"AlltheWeb.com"', ['q'], nil ],
		[%r{\Ahttp://.*?\.alltheweb\.com}i, '"AlltheWeb.com"', [], nil ],
	],
	'kobe-u' => [
		[%r{\Ahttp://bach\.scitec\.kobe-u\.ac\.jp/cgi-bin/metcha.cgi}i, '"��å��㸡�����󥸥�"', ['q'], nil ],
		[%r{\Ahttp://bach\.istc\.kobe-u\.ac\.jp/cgi-bin/metcha.cgi}i, '"��å��㸡�����󥸥�"', ['q'], nil ],
	],
	'tocc' => [[%r{\Ahttp://www\.tocc\.co\.jp/search/}i, '"TOCC/Search"', ['QRY'], nil ]],
	'yappo' => [[%r{\Ahttp://i\.yappo\.jp/}i, '"iYappo"', [], nil ]],
	'suomi24' => [[%r{\Ahttp://.*?\.suomi24\.([^/]+)/.*query}i, '"Suomi24"', ['q'], DispReferrer2_Google_cache]],
	'earthlink' => [[%r{\Ahttp://search\.earthlink\.net/search}i, '"EarthLink Search"', ['as_q', 'q', 'query'], DispReferrer2_Google_cache]],
	'infobee' => [[%r{\Ahttp://infobee\.ne\.jp/}i, '"�������󸡺�"', ['MT'], nil ]],
	't-online' => [[%r{\Ahttp://brisbane\.t-online\.de/}i, '"T-Online"', ['q'], DispReferrer2_Google_cache]],
	'walla' => [[%r{\Ahttp://find\.walla\.co\.il/}i, '"Walla! Channels"', ['q'], nil ]],
	'mysearch' => [[%r{\Ahttp://.*?\.mysearch\.com/}i, '"My Search"', ['searchfor'], nil ]],
	'jword' => [[%r{\Ahttp://.*\.jword.jp/}i, '"JWord"', ['name'], nil ]],
	'nytimes' => [[%r{\Ahttp://query\.nytimes\.com/search}i, '"New York Times: Search"', ['as_q', 'q', 'query'], DispReferrer2_Google_cache]],
	'aaacafe' => [[%r{\Ahttp://search\.aaacafe\.ne\.jp/search}i, '"AAA!CAFE"', ['key'], nil]],
	'virgilio' => [[%r{\Ahttp://search\.virgilio\.it/search}i, '"VIRGILIO Ricerca"', ['qs'], nil]],
	'ceek' => [[%r{\Ahttp://www\.ceek\.jp}i, '"ceek.jp"', ['q'], nil]],
	'cnn' => [[%r{\Ahttp://websearch\.cnn\.com}i, '"CNN.com"', ['query', 'as_q', 'q', 'as_epq'], DispReferrer2_Google_cache]],
	'webferret' => [[%r{\Ahttp://webferret\.search\.com}i, '"WebFerret"', 'split(/,/)[1]', nil]],
	'eniro' => [[%r{\Ahttp://www\.eniro\.se}i, '"Eniro"', ['query', 'as_q', 'q'], DispReferrer2_Google_cache]],
	'passagen' => [[%r{\Ahttp://search\.evreka\.passagen\.se}i, '"Eniro"', ['q', 'as_q', 'query'], DispReferrer2_Google_cache]],
	'redbox' => [[%r{\Ahttp://www\.redbox\.cz}i, '"RedBox"', ['srch'], nil]],
	'odin' => [[%r{\Ahttp://odin\.ingrid\.org}i, '"ODiN����"', ['key'], nil]],
	'kensaku' => [[%r{\Ahttp://www\.kensaku\.}i, '"kensaku.jp����"', ['key'], nil]],
	'hotbot' => [[%r{\Ahttp://www\.hotbot\.}i, '"HotBot Web Search"', ['MT'], nil ]],
	'searchalot' => [[%r{\Ahttp://www\.searchalot\.}i, '"Searchalot"', ['q'], nil ]],
	'cometsystems' => [[%r{\Ahttp://search\.cometsystems\.com}i, '"Comet Web Search"', ['qry'], nil ]],
	'bulkfeeds' => [
		[%r{\Ahttp://bulkfeeds\.net/app/search2}i, '"Bulkfeeds: RSS Directory & Search"', ['q'], nil ],
		[%r{\Ahttp://bulkfeeds\.net/app/similar}i, '"Bulkfeeds Similarity Search"', ['url'], nil ],
	],
	'answerbus' => [
		[%r{\Ahttp://www\.answerbus\.com}i, '"AnswerBus"', [], nil ],
		[%r{\Ahttp://answerbus\.coli\.uni-sb\.de/cgi-bin/answerbus/answer.cgi}i, '"AnswerBus"', [], nil ],
	],
	'dogplile' => [[%r{\Ahttp://www.\dogpile\.com/info\.dogpl/search/web/}i, '"dogpile"', [], nil ]],
	'www' => [[%r{\Ahttp://www\.google/search}i, '"Google����?"', ['as_q', 'q'], DispReferrer2_Google_cache]],	# TLD missing
	'planet' => [[%r{\Ahttp://www\.planet\.nl/planet/}i, '"Planet-Zoekpagina"', ['googleq', 'keyword'], DispReferrer2_Google_cache]], # googleq parameter has a strange prefix
	'dcn' => [[%r{\Ahttp://www\.dcn\.to/~comment/cgi-bin/commenton\.cgi}i, '"�᥿������COMMENTON"', ['q'], nil ]],
	'ask' => [[%r{\Ahttp://ask\.jp/web.asp}i, '"ask.jp"', ['q'], nil ]],
	'searchscout' => [[%r{\Ahttp://results\.searchscout\.com/search}i, '"SearchSout"', ['k'], nil ]],
	'inktomi' => [[%r{\Ahttp://rdrw1.inktomi.com/click}i, '"inktomi �Υ�����쥯��"', [], nil]],
	'3721' => [[%r{\Ahttp://(seek|nmsearch)\.3721\.com/}i, '"3721����Ӻ�"', ['p','name'], nil]],
	'yisou' => [[%r{\Ahttp://www\.yisou\.com}i, '"����"', ['p'], nil]],
	'devilfinder' => [[%r{\Ahttp://www\.devilfinder\.com/find.php}i, '"The Devilfinder"', ['q'], nil]],
	'lyricsuniverse' => [[%r{\Ahttp://www\.lyricsuniverse\.com/}, '"LYRICS Universe"', [], nil]],
	'vivisimo' => [[%r{\Ahttp://.+\.vivisimo\.com/search}i, '"Vivisimo"', [], nil]],
	'a9' => [[%r{\Ahttp://a9\.com}i, '"A9"', ['q'], nil]],
	'nttrd' => [[%r{\Ahttp://labs\.nttrd\.com/cgi-bin/index\.cgi}, '"goo���"', ['q'], nil]],
	'whatis' => [[%r{\Ahttp://whatis\.techtarget\.com/wsearchResults/}i, '"WhatIs.com | web search"', ['query'], nil]],
	'comcast' => [[%r{\Ahttp://www\.comcast\.net/qry/websearch}i, '"COMCAST"', ['query'], nil]],
	'mywebsearch' => [[%r{\Ahttp://www\.mywebsearch\.com/jsp/GGmain.jsp}i, '"My Web Search"', ['seachfor'], nil]],
	'wisenut' => [[%r{\Ahttp://www\.wisenut\.com/search/query.dll}, '"WiseNut"', ['q'], nil]],
	'livedoor' => [[%r{\Ahttp://(sf|www|search)\.livedoor\.}i, '"Livedoor"', ['q'], nil ]],
	'tkensaku' => [[%r{\Ahttp://www\.tkensaku\.com/sclient\.cgi}i, '"TKENSAKU"', ['value'], nil]],
	'yahoofs' => [[%r{\Ahttp://cache\.yahoofs\.jp/(?:search/)?cache}i, '"Yahoo! cache"', ['p', 'w'], nil]],
	'googlie' => [[%r{\Ahttp://www\.googlie\.com/search}i, '"Google����(�ؤΥ�����쥯��)"', ['as_q', 'q'], DispReferrer2_Google_cache]],
	'toppg' => [[%r{\Ahttp://g\.toppg\.to/search}i, '"Google����(�ؤΥ�����쥯��)"', ['as_q', 'q'], DispReferrer2_Google_cache]],
	'naoya' => [[%r{\Ahttp://naoya\.dyndns\.org/feedback/app/search}i, '"FeedBack"', ['keyword'], nil]],
	'blogpeople' => [[%r{\Ahttp://bst\.blogpeople\.net/search_result\.jsp}i, '"blogpeople"', ['keyword'], nil]],
	'matome' => [[%r{\Ahttp://\w+\.matome\.jp/(keyword|tag)/(.*(?=\.html\Z)|.*\Z)}i, 'keyword=$2; "�ޤȤḡ��"', [], nil]],
	'210' => [[%r{\Ahttp://210\.174\.160\.70/se_root.phtml}i, '"JWord�����ܸ쥭����ɡ�"', ['name'], nil]],
	# % whois 64.233.160
	# NetRange:   64.233.160.0 - 64.233.191.255
	# CIDR:       64.233.160.0/19
	# NetName:    GOOGLE
	'233' => [[%r{\Ahttp://64\.233\.(1[6-8][0-9]|190|191)\.}i, '"Google����"', ['as_q', 'q'], DispReferrer2_Google_cache]],
	# % whois 66.102.0.0
	# NetRange:   66.102.0.0 - 66.102.15.255
	# CIDR:       66.102.0.0/20
	# NetName:    GOOGLE-2
	'102' => [[%r{\Ahttp://66\.102\.([0-9]|1[0-5])\.}i, '"Google����"', ['as_q', 'q'], DispReferrer2_Google_cache]],
	# other google candidates:
	'216' => [[%r{\Ahttp://(\d+\.){3}\d+/search}i, '"Google����?"', ['as_q', 'q'], DispReferrer2_Google_cache]],		# cache servers of google?
	# % whois whois 72.14.203.104
	# NetRange:   72.14.192.0 - 72.14.239.255 
	# CIDR:       72.14.192.0/19, 72.14.224.0/20 
	# NetName:    GOOGLE
	'14' => [[%r{\Ahttp://72\.14\.(19[2-9]|2\d\d)\.}i, '"Google����"', ['as_q', 'q'], DispReferrer2_Google_cache]],
	'ezweb' => [[%r{\Ahttp://ezsch\.ezweb\.ne\.jp/search/}i, '"EZweb����"', ['query'], nil]],
	'overture' => [[%r{\Ahttp://(\w+\.)?overture\.com/}i, '"Overture����"', ['Keywords'], nil]],
	'multimeta' => [[%r{\Ahttp://(\w+\.)?multimeta\.com/}i, '"Multimeta����"', ['suchbegriff'], nil]],
	'starware' => [[%r{\Ahttp://search\.starware\.com/}i, '"Starware����"', ['qry'], nil]],
	'rambler' => [[%r{\Ahttp://\w+\.rambler\.ru/}i, '"Rambler"', ['words'], nil]],
	'technorati' => [
		[%r{\Ahttp://www\.technorati\.jp\/search\/search\.html}i, '"�ƥ��Υ�ƥ�"', ['query'], nil],
		[%r{\Ahttp://www\.technorati\.jp\/search\/(.*)}i, 'keyword=$1; "�ƥ��Υ�ƥ�"', [], nil],
	],
	'pagesupli' => [
		[%r{\Ahttp://www\.pagesupli\.com/cgi-bin/nph-image.exe}i, '"pageone����"', ['q'], nil],
		[%r{\Ahttp://www\.pagesupli\.com/\w+/(.*)}i, 'keyword=$1; "pageone����"', [], nil],
	],
	'yahoogle' => [[%r{\Ahttp://www\.yahoogle\.jp/(?:yahoogle|google|yahoo)-\d+-(.*)\.html\Z}i, 'keyword=$1; "yahoogle!"', [], nil]],
	# $ whois 209.85.165.104
	# NetRange:   209.85.128.0 - 209.85.255.255
	# CIDR:       209.85.128.0/17
	# NetName:    GOOGLE
	'85' => [[%r{\Ahttp://209\.85\.(12[8-9]|1[3-9]\d|2\d\d)\.}i, '"Google����"', ['as_q', 'q'], DispReferrer2_Google_cache]],
}
