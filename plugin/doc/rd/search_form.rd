=begin
= search_form.rb - �Ƽ︡�����󥸥�θ����ե�����ɽ���ץ饰����

== ��ǽ
�Ƽ︡�����󥸥�θ����ե�������������ޤ���

== �Ȥ����
�إå��⤷���ϥեå�

== ������ˡ
�ƥѥ�᡼���α����ͤ������Τϥǥե���Ȱ����Ǥ����ä��ѹ�����ɬ�פ��ʤ����Ͼ�ά��ǽ�Ǥ���

* url - �������󥸥��URL(�㡧/namazu/namazu.cgi)
* button_name - �ܥ���̾�Ρʾ�ά��ǽ��
* size - �ƥ����ȥܥå��������ʾ�ά��ǽ��
* default_text - �ƥ����ȥܥå����ν��ɽ��ʸ���ʾ�ά��ǽ��

--- namazu_form(url, button_name = "Search", size = 20, default_text = "")
    Namazu�Ѹ����ե����ࡣurl�ˤ�namazu.cgi��URL����ꤷ�Ƥ���������

  �㡧 <%=namazu_form("/namazu/namazu.cgi")%>

--- googlej_form(button_name = "Google ����", size = 20, default_text = "")
    Google�Ѹ����ե����ࡣ

  �㡧 <%=googlej_form%>

--- yahooj_form(button_name = "Yahoo! ����", size = 20, default_text = "")
    Yahoo!�Ѹ����ե����ࡣ

  �㡧��<%=yahooj_form%>

--- lycosj_form(button_name = " ���� ", size = 20)
    Lycos�Ѹ����ե�����

  ��: <%=lycosj_form%>

== ��ʬ���ȤǸ����ե��������������
���ּ�ü���ᤤ�Τϼ�ʬ���Ȥ�HTML��񤤤Ƥ��ޤ����ȤǤ���(^^;)���ܥץ饰����Υ᥽�åɤ�Ȥ����Ȥ�Ǥ��ޤ���

--- search_form(url, query, button_name = "Search", size = 20, default_text = "", first_form = "", last_form = "")

* url - �������󥸥��URL(�㡧/namazu/namazu.cgi)
* query - �ƥ����ȥܥå�����name°����
* button_name - �ܥ���̾�Ρʾ�ά��ǽ��
* size - �ƥ����ȥܥå��������ʾ�ά��ǽ��
* default_text - ���ɽ��ʸ���ʾ�ά��ǽ��
* first_form - <form>�����μ�����ʬ�ʾ�ά��ǽ��
* last_form - </form>������������ʬ�ʾ�ά��ǽ��

== �����
�Ƹ����ե�����ϡ��������󥸥���󶡤���ƼҤ��Ŀͥۡ���ڡ����������󶡤��Ƥ��븡���ե���������Ѥ��Ƥ��ޤ����Ŀ�Ū�������ǻ��Ѥ��뤳�ȤϤۤ�����ʤ��Ȼפ��ޤ��ʻ�ϲ�ᤷ�Ƥ��ޤ��ˤ������ˤʤ����ϡ��ƼҤΥ����Ȥǳ�ǧ���Ƥ������������Ѥ����Ѥ������ɬ���ƼҤ˳�ǧ����褦�ˤ��Ƥ���������

���ʤߤˡ������ե����༫�Τ�Ȥ����ϥե꡼�Ǥ�����������̤ˤĤ��Ƥ����¤���ʲù����򤷤ʤ����ե졼��ǻȤ�ʤ����������Ѥϱ��������ˡ��Ȥ���饤���󥹷��֤�¿���褦�Ǥ���

== �饤���󥹤ˤĤ���
Copyright (C) 2002 MUTOH Masao <mutoh@highwhay.ne.jp>

�ܥ��եȥ�������GNU General Public License Version 2(GNU���̸�ͭ���ѵ�����С������2)�˴�Ť��ƥ�꡼�������ե꡼���եȥ������Ǥ���
�ޤ����ܥץ�����̵�ݾڤǤ����ܥץ��������Ѥˤ�겿�餫�Υȥ�֥뤬�����Ƥ⡢�����ϰ�����Ǥ���餤�ޤ���

== ���ƥ�
�ܥ��եȥ������ˤĤ��ƤΤ��ո����Х���ݡ��Ȥ���ƣ�ޤǡ�
MUTOH Masao <mutoh@highway.ne.jp>

== ChangeLog
:2002-03-24 MUTOH Masao  <mutoh@highway.ne.jp>
    * Namazu, Google, Yahoo!, Lycos�θ����ե�����򥵥ݡ���
    * version 1.0.0

=end
