#
# antirefspam.rb 
#
# Copyright (c) 2004 T.Shimomura <redbug@netlife.gr.jp>
#

@antispamref_html_myurl = <<-TEXT
	<h3>���Ƥ�������λ���</h3>
	<p>
	�ȥåץڡ���URL(#{unless @conf.index_page.empty? then @conf.index_page else "̤����" end})�ʳ��˥����Ȥ��Ƶ��Ƥ���URL����ꤷ�ޤ���
	����ɽ�������Ѳ�ǽ�Ǥ���
	</p>
	TEXT

@antispamref_html_trustedurl = <<-TEXT
	<h3>���ꤹ���󥯸��λ���</h3>
	<p>
	�ҥ�ȡ�
	<ul>
	<li>���Ԥˣ��Ĥ� URL ��񤤤Ƥ���������</li>
	<li>\#�ǻϤޤ�ԡ����Ԥ�̵�뤵��ޤ���</li>
	<li>"���ꤹ���󥯸�" �ϣ��ʳ���ʬ���ƥ����å�����ޤ���</li>
	<ul>
	<li>�����ܤϡ�����ɽ����ȤäƤ��ʤ���ΤȤ��ƥ����å����ޤ����񤫤줿 URL ����󥯸���
	    �ޤޤ�Ƥ�������С����ꤹ���󥯸��Ȥߤʤ��ޤ���<br>
	    �� : ��󥯸��� http://www.foo.com/bar/ �� http://www.foo.com/baz/ �ξ�硢
	         URL �ˤ� http://www.foo.com/ �Ƚ񤱤Ф褤��</li>
	<li>�����ܤϡ�����ɽ����ȤäƤ����ΤȤ��ƥ����å����ޤ������ξ�硢URL�� �� : (�����) �� / (����å���) ��
	    �����ǥ��������פ���ޤ�������ɽ����Ȥ���硢��󥯸������Τ˥ޥå�����ɬ�פ�����������դ��Ƥ���������<br>
	    �� : ��󥯸��� http://aaa.foo.com/bar/ �� http://bbb.foo.com/baz/ �ξ�硢
	         URL �ˤ� http://\\w+\.foo\.com/.* �Ƚ񤱤Ф褤��</li>
	</ul>
	</ul>
	</p>
	TEXT

@antispamref_html_faq = <<-TEXT
	<p>
	����¾���ǿ���FAQ�� <a href="http://www.netlife.gr.jp/redbug/diary/?date=20041018\#p02">http://www.netlife.gr.jp/redbug/diary/?date=20041018\#p02</a> �򻲾Ȥ��Ƥ���������
	</p>
	TEXT

