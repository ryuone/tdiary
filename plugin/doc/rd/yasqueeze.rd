=begin
= yasqueeze.rb��- Yet Another squeeze.rb

== ��ǽ
tDiary-1.3.x�ʹߤǷ�ɸ��ǤĤ��Ƥ���squeeze.rb�γ�ĥ�ǤǤ���
tDiary�Υǡ����١����������̤�HTML�ե��������������Ǥ�դΥǥ��쥯�ȥ����¸���ޤ���
�������󥸥�(���Namazu)�Ǥλ��Ѥ����ꤷ�Ƥ��ޤ���

 * ������ʸ����ĥå��ߤޤǤ�Ƹ�
 * ��ɽ�����������оݤˤ��뤫�ɤ���������Ǥ���
 * ǯ�̤˥ǥ��쥯�ȥ�������1�ǥ��쥯�ȥ����365�ե�����ˡ��ޤ������ƤΥե��������ĤΥǥ��쥯�ȥ�˺���(tDiary�ߴ��⡼��)
 * CGI�Ȥ��Ƥ⥳�ޥ�ɤȤ��Ƥ�tDiary�ץ饰����Ȥ��Ƥ�ư���

== �Ȥ���
yasqueeze.rb��3�ĤλȤ������Ǥ��ޤ���

=== �ץ饰����Ȥ��ƻ���(1����������HTML������)
tDiary��ɸ��Ǥ⹹������HTML�ե������Ǥ�դΥǥ��쥯�ȥ�˳�Ǽ���뤳�Ȥ��Ǥ��ޤ������ĥå��ߤʤɤ���¸����ʤ���HTML�����ǤϤʤ����ʤ��Դ����Ǥ���
���Ӥˤ�äƤϤ���ǽ�ʬ�Ǥ�����yasqueeze.rb�ץ饰�����Ȥ��д�����HTML�������Ǥ��ޤ����ޤ����ǥ��쥯�ȥ��ǯ�̤���¸���ޤ��Τǡ��㴳�ե�����λ�ǧ����������ޤ��ʤۤ�Ȥ����ˡ���������tDiary��Ʊ�ͤ�1�ĤΥǥ��쥯�ȥ�����ƤΥե�������֤����Ȥ��ǽ�Ǥ���

* tdiary.conf���ѹ����ޤ��� �ޤ���@text_output��false�ˤ��ޤ���

 @text_output = false
 @text_output_path = ''

* ����tdiary.conf�˰ʲ��Υ��ץ������ɲä��ޤ���

 # ������ǥ��쥯�ȥ�
 @options['yasqueeze.output_path'] = '/home/hoge/tdiary/html/'
 # ��ɽ�����������оݤȤ������true��false�ˤ���������ɽ���������Ͻ��Ϥ��������ġ����Ǥ˽��ϺѤߤΥե����뤬¸�ߤ������Ϻ�����ޤ���
 # �������󥸥�ǻ��Ѥ��뤳�Ȥ����ꤷ����硢������true�ˤ��Ƥ��ޤ��ȱ����Ƥ���Ĥ��������⸡���оݤˤʤäƤ��ޤ��Τ���դ�ɬ�פǤ���
 @options['yasqueeze.all_data'] = false
 # squeeze.rb��tDiaryɸ���Ʊ��������Υǥ��쥯�ȥ깽���ˤ������true
 @options['yasqueeze.compat_path'] = false
 
* ������Υǥ��쥯�ȥ��������ޤ������Υǥ��쥯�ȥ��WWW�����Ф�������¤���äƤ���ɬ�פ�����ޤ��Τ�ɬ�פ˱�����chmod���Ƥ���������
  �嵭����ξ��� /home/hoge/tdiary/html�Ȥʤ�ޤ���

* plugin�ǥ��쥯�ȥ��yasqueeze.rb���֤��ޤ���

��������ǡ���������Ͽ���������ĥå��ߤ���Ͽ���뤿�Ӥ�HTML�ե����뤬���������褦�ˤʤ�ޤ���

=== ���Ƥ����������̤�HTML������
1����tDiary��Ȥ��ͤϥץ饰����Ȥ���yasqueeze.rb��Ȥ������Ǥ�������ä�ɬ�פʤ��ΤǤ��������Ǥ�tDiary���Ѥ��Ƥ����硢���äڤ�˲���������HTML����������礬����ޤ���
���Τ褦�ʾ��ϰʲ���2�Ĥ���ˡ��HTML�������Ǥ��ޤ���

==== CGI�Ȥ��ƻ���
* ����tdiary.conf��Plugin�Ȥ��ƻȤ�����Ʊ�����ץ������ɲä��ޤ���

 @options['yasqueeze.output_path'] = '/home/hoge/tdiary/html/'
 @options['yasqueeze.all_data'] = false
 @options['yasqueeze.compat_path'] = false
 
  �ޤ���ɬ�פ˱����ơ�1���ܤ�#!/usr/bin/env ruby���Ԥ��ѹ����ޤ��� 

* ������Υǥ��쥯�ȥ��������ޤ���
  ���Υǥ��쥯�ȥ��WWW�����Ф�������¤���äƤ���ɬ�פ�����ޤ��Τ�ɬ�פ˱�����chmod���Ƥ���������
  �嵭����ξ��� /home/hoge/tdiary/html�Ȥʤ�ޤ���

* tDiary�����륵���Ф�Ʊ�������Ф�tdiary�ǥ��쥯�ȥ�ľ��(index.rb��update.rb��tdiary.conf������ǥ��쥯�ȥ�)��yasqueeze.rb���֤���index.rb,update.rb��Ʊ�������������¤ˤ��ޤ���

* WWW�֥饦������http://hogehoge/tdiary/yasqueeze.rb�˥����������ޤ���

==== ���ޥ�ɤȤ��ƻ���
tDiary�����륵���Ф�Ʊ�������ФǼ¹Ԥ���ɬ�פ�����ޤ���tdiary.conf�ǻ��ꤷ��@data_path�ؤν�����¤�ɬ�פǤ���
* ������Υǥ��쥯�ȥ��������ޤ���
  ���Υǥ��쥯�ȥ�ϥ����ȥ桼����������¤���äƤ���ɬ�פ�����ޤ��Τ�ɬ�פ˱�����chmod���Ƥ���������
* yasqueeze.rb��¹Ԥ��ޤ���

  $ruby squeeze.rb [-p <tDiary path>] [-c <tdiary.conf path>] [-a] [-s] <dest path>

:-p <tDiary path>
  tDiary�Υ��󥹥ȡ���ѥ���̤������ϥ����ȥǥ��쥯�ȥ�(��: -p /homge/hoge/tdiary)��
:-c <tdiary.conf path>
  tdiary.conf��¸�ߤ���ѥ���̤������ϥ����ȥǥ��쥯�ȥ�(��: -c /home/hoge/public_html/diary)��
:-a
  ��ɽ�����������оݤȤ��롣̤���������ɽ���������Ͻ��Ϥ��������ġ����Ǥ˽��ϺѤߤΥե����뤬¸�ߤ������Ϻ�����롣
:-s
  squeeze.rb�⡼�ɡ�squeeze.rb��tDiaryɸ���Ʊ��������Υǥ��쥯�ȥ깽���ˤ��롣
:<dest path>
  HTML�ե������������ǥ��쥯�ȥꡣ
  
* ���������ե�����ȥǥ��쥯�ȥ�򡢤��Τޤޥץ饰�������ǻ��Ѥ�����ϡ�WWW�����Ф�������¤���äƤ���ɬ�פ�����ޤ��Τ�ɬ�פ˱�����chmod���Ƥ���������

=== Namazu�ǻ��Ѥ���
yasqueeze.rb�ϼ��Namazu���θ������󥸥�ǻ��Ѥ��뤳�Ȥ���Ū�Ȥ��Ƥ��ޤ��������Ǥϡ�ŵ��Ū��Namazu��������ˡ�򼨤��ޤ���

* /home/hoge/namazu - Namazu�Υ���ǥå����ե�����Τ���ǥ��쥯�ȥ�
* /home/hoge/html/  - yasqueeze.rb�ν�����
* /home/hoge/public_html/tdiary/ - tdiary�Τ���ǥ��쥯�ȥ�
* /home/hoge/public_html/namazu/ - namazu.cgi, .namazurc�Τ���ǥ��쥯�ȥ�
* http://www.hoge.com/hoge/tdiary/ - tdiary��URL(/home/hoge/public_html/tdiary/�˥ޥåԥ�)
* http://www.hoge.com/hoge/namazu/ - namazu.cgi��URL(/home/hoge/public_html/namazu/�˥ޥåԥ�)

�˻��ꤵ��Ƥ���Ȥ��ޤ���

==== ���ꥸ�ʥ�⡼��(@options['yasqueeze.compat_path'] = false)�ξ��
�ʲ��Τ褦�˥ե����뤬��������ޤ���

 /home/hoge/html/2000/0101( ... 1231)
 /home/hoge/html/2001/0101( ... 1231)
 /home/hoge/html/2002/0101( ... 1231)

.namazurc�����Ƥ�ʲ��Τ褦�ˤ��ޤ���

 Index /home/hoge/namazu/
 Replace /home/hoge/html/(\d\d\d\d)/ http://www.hoge.com/hoge/tdiary/?date=\1
 Lang ja

==== tDiary�ߴ��⡼��(@options['yasqueeze.compat_path'] = true)�ξ��
�ʲ��Τ褦�˥ե����뤬��������ޤ���

 /home/hoge/html/20000101( ... 20001231)
 /home/hoge/html/20010101( ... 20011231)
 /home/hoge/html/20020101( ... 20021231)

.namazurc�����Ƥ�ʲ��Τ褦�ˤ��ޤ���

 Index /home/hoge/namazu/
 Replace /home/hoge/html/ http://www.hoge.com/hoge/tdiary/?date=
 Lang ja

=== Namazu�Υ���ǥå���������
�ե����뤬�����Ǥ���С����ȤϤ���򸵤�Namazu�Υ���ǥå����ե�������������ޤ���

 $mknmz /home/hoge/html --output-dir=/home/hoge/namazu

=== ư���ǧ
�����http://www.hoge.com/namazu/namazu.cgi��Namazu���鸡���Ǥ���Ȼפ��ޤ����Ǥ��ʤ��ä��餴�����(^^;)��

=== tDiary���鸡���Ǥ���褦�ˤ���
tDiary�˸����ѤΥե������ɽ�������뤳�Ȥ�Ǥ��ޤ���tDiary��������̤��顢����������ξ��˰ʲ��Υƥ����Ȥ��������ޤ���

 <div class="search">
  <form class="search" method="get" action="/namazu/namazu.cgi">
  <input class="search" type="text" name="query" size=20 value="">
  <input class="search" type="submit" value="Search">
  </form>
 </div>

�嵭��Ǥϡ�class��ʬ���Ƥ���Τǡ�CSS��Ȥ��Хǥ�����򤤤�����ѹ��Ǥ��ޤ���

((<search_form.rb|URL:search_form.html>))��Ȥ��ȡ��ʲ��Τ褦�˽񤯤��Ȥ��Ǥ��ޤ���

 <div class="search">
 <%=namazu_form "/namazu/namazu.cgi"%>
 </div>

���ä���������ñ�Ǥ��͡�

== �饤���󥹤ˤĤ���
Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>

�ܥ��եȥ�������GNU General Public License Version 2(GNU���̸�ͭ���ѵ�����С������2)�˴�Ť��ƥ�꡼�������ե꡼���եȥ������Ǥ���
�ޤ����ܥץ�����̵�ݾڤǤ����ܥץ��������Ѥˤ�겿�餫�Υȥ�֥뤬�����Ƥ⡢�����ϰ�����Ǥ���餤�ޤ���

�ʤ������Υ�����ץȤ�squeeze.rb�γ�ĥ�ǤǤ���squeeze.rb�Υ饤���󥹤ϰʲ����̤�Ǥ���

Copyright (C) 2001,2002, All right reserved by TADA Tadashi <sho@spc.gr.jp>
You can redistribute it and/or modify it under GPL2.

== ���ƥ�
�ܥ��եȥ������ˤĤ��ƤΤ��ո����Х���ݡ��Ȥ���ƣ�ޤǡ�
MUTOH Masao <mutoh@highway.ne.jp>

== ChangeLog
:2002-03-31 MUTOH Masao  <mutoh@highway.ne.jp>
    * TAB �� ���ڡ���
    * �ɥ�����ȥ����å�����

:2002-03-29 MUTOH Masao  <mutoh@highway.ne.jp>
    * ���ϥե���������դξ���ǥ����Ȥ���褦�ˤ���
    * squeeze.rb��Ʊ�ͤΥ��ޥ�ɥ��ץ����򥵥ݡ��Ȥ���
      �ʤ����� --delete���ץ����Ϥʤ������--all���ץ������Ѱա�
    * ���ޥ�ɥ饤�󥪥ץ������ɲä������Ȥ����פˤʤä�--nohtml���ץ�����ʤ�����
    * �ɥ�����ȺƸ�ľ��
    * tdiary.conf��@options�б�
    * add_update_proc do ����end �б�(���Τ��ᡢtDiary-1.3.x�ϤǤ�ư���ʤ��ʤ�ޤ���)
    * version 1.2.0

:2002-03-21 MUTOH Masao  <mutoh@highway.ne.jp>
    * ��ɽ��������������оݤ˴ޤ�뤫�ɤ���������Ǥ���褦�ˤ���
    * �ե��������¸�ǥ��쥯�ȥ�ι�����tDiaryɸ��Τ�Τ�version 1.0.0
      �Τ�Τ�����Ǥ���褦�ˤ���
    * �ɥ�����Ȥ򥽡��������ɤ��Ф���
    * version 1.1.0

:2002-03-19 MUTOH Masao <mutoh@highway.ne.jp>
    * version 1.0.0

=end
