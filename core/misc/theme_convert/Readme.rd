=begin

=theme_convert.rb
==�ޤޤ��ե�����
	* Readme.rd: ���Υե�����
	* append.rcss: 1.5 ���ѤΥĥå��ߡ������ե��������� CSS ����
	* theme_convert.rb: ���Υ�����ץ�

==�Ȥ���
 $ ruby theme_convert.rb hoge.css

�ȼ¹Ԥ���ȡ�hoge-2.css �� hoge-simple.css ����������ޤ���
hoge-2.css �� 1.5 ���Ѥ��Ѵ����줿 CSS �ե�����Ǥ���
�٤������Ϥ��� CSS �ե�������ǽ������Ƥ���������
��hoge-simple.css �ϰ���ե�����Ǥ���

�¹Ԥ��뤿��ˤϡ�������ˤ�� ERb �Ȥ����饤�֥�꤬ɬ�פǤ���tDiary �����ۥե�����˴ޤޤ�Ƥ��ޤ���erb �Ȥ����ǥ��쥯�ȥ�� theme_convert.rb ��Ʊ���ǥ��쥯�ȥ���֤��Ƥ��������������Υե�����ˤĤ��Ƥ����� http://www2a.biglobe.ne.jp/~seki/ruby/ �򤴤�󲼤�����

==��ɽŪ�ʥ��顼���н�λ���
 $ ruby theme_convert.rb tdiary1/tdiary1.css 
 Error!: in tdiary1/tdiary1-simple.css:3: parse error on "}"
 Are there empty blocks in your css? Check your css file.

���Τ褦�ʥ��顼��ȯ�������Ȥ��ϡ�tdiary1/tdiary1-simple.css �� 3 ���ܤ�
�ѡ���������˥��顼��ȯ�����Ƥ��ޤ������Υ��顼����ͳ�ϲ����Ρִ��Τ����¡�
�ˤ���ΤǤ����ѡ������顼��ȯ�����Ƥ���Τ� tdiary1/tdiary1.css �� 3 ����
�ǤϤʤ����Ȥ���դ��Ƥ���������

��������ˤϡ�tdiary1/tdiary1-simple.css �򸫤�����ս���İ����Ƥ��顢
tdiary1/tdiary1.css �γ����ս��Ĵ�����Ƥ���������

==���Τ�����

�ʲ��ε��Ҥ�ޤ�ơ��ޥե�����ˤϻȤ��ޤ���

1. �֥�å�����Ȥ����Τ��
 	��. span.title {
 	    }

=end
