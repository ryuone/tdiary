#
# ja/my-sequel.rb
# $Revision: 1.3 $
#
# show links to follow-up entries
#
# Copyright 2006 zunda <zunda at freeshell.org> and
#                NISHIMURA Takashi <nt at be.to>
#
# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work under the terms
# of GPL version 2.
#

@my_sequel_plugin_name ||= '�����̤ؤΥ��'
@my_sequel_description ||= <<_END
<p>my�ץ饰����ǲ��������˸��ڤ���ȡ�������������Υ�󥯤�ɽ�����ޤ���</p>
<p>���꤬��Ͽ�����Τϡ�OK�ץܥ���򲡤��Ƥ���Ǥ����ǥե���Ȥ�������᤹���Ǥ⡢��OK�ץܥ���򲡤��Ƥ���������</p>
_END
@my_sequel_restore_default_label ||= '�ǥե���Ȥ��᤹'
@my_sequel_default_hash ||= {
	:label => {
		:title => '��٥�',
		:default => '�ĤŤ�: ',
		:description => '�����̤ؤΥ�󥯤�����ɽ�������ʸ����Ǥ���',
		:index => 1,
	},
	:date_format => {
		:title => '���ʸ����',
		:default => @date_format,
		:description => '�����̤ؤΥ�󥯤�ʸ����ν񼰤Ǥ���%�ǻϤޤ�ѻ��ϼ��Τ褦���Ѵ�����ޤ�: ��%Y��(����ǯ)����%m��(�����)����%b��(û��̾)����%B��(Ĺ��̾)����%d��(��)����%a��(û����̾)����%A��(Ĺ����̾)��',
		:index => 2,
	},
	:inner_css => {
		:title => '��������',
		:default => <<'_END',
font-size: 75%;
text-align: right;
margin: 0px;
_END
		:description => '�����̤ؤΥ�󥯤����ꤵ���CSS�Ǥ���div.sequel��Ŭ�Ѥ���ޤ���',
		:index => 3,
		:textarea => {:rows => 5},
	},
}
