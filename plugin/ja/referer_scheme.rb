=begin
= Meta-scheme plugin((-$Id: referer_scheme.rb,v 1.1 2003-12-16 17:26:58 zunda Exp $-))
�����Υ�󥯸��ִ��ꥹ�Ȥε��Ҥ�ڤˤ��ޤ���

���ΤȤ������ʤ��Ȥ� ruby 1.6.7 (2002-03-01) �ǤϤ��ޤ�ư���ޤ���

== ������ˡ
���Υץ饰����򡢥ץ饰����Υǥ��쥯�ȥ������뤫�ץ饰��������ץ饰
���󤫤�ͭ���ˤ��Ƥ���������

���ˡ����ꡢ��󥯸����顢��󥯸��ִ��ꥹ�Ȥ��Խ����ơ�tdiary:��
hatena:�Ȥ����ץ�ե��å���(�᥿����������ȸƤ֤��Ȥˤ��ޤ�)��URL������
�դ��Ƥ���������

����ˤ�ꡢ���դ��ִ�����롼���񤫤ʤ��Ǥ⡢�ִ����ʸ����˼�ưŪ��
���դʤɤ��������뤳�Ȥ��Ǥ��ޤ���

�㤨�С����Τ褦�ʵ��Ҥ򤷤Ƥ���������
* tdiary:http://tdiary.tdiary.net/ tDiary.net��������
* tdiarynet:foo((-http://foo.tdiary.net/��Ÿ������ޤ�-)) foo���������
* hatena:bar((-http://d.hatena.ne.jp/bar/��Ÿ������ޤ�-)) bar���������
������Ǥϡ�URL�����դ��ޤޤ��С�(YYYY-MM-DD)�Ȥ����������ɲä��ޤ���

== ���
tdiary:�ǻϤޤ�URL�ϡ�
* ��̤�Ȥ�ʤ��Ǥ���������
* /�ǽ���餻�Ƥ���������

tdiarynet:��hatena:�ǻϤޤ�URL�ϡ�
* ��̤�Ȥ�ʤ��Ǥ���������
* URL�Ȥ��Ƥϥ桼����ID��������ꤷ�Ƥ���������

== �᥿����������κ����
��󥯸��ִ��ꥹ�Ȥ�URL������ɽ����ʸ������Ф��ơ�/^(\w+):/�Ȥ�������ɽ
���ǰ��פ���ʸ���󤬥᥿����������Ȥ��Ƹ��Ф���ޤ���
  def scheme_��������̾( url, name, block )
    :
    block.call( url_variants, name_variants )
    :
  end
�Ȥ���@conf.referer_table���ðۥ᥽�åɤ򥤥ƥ졼���Ȥ���������Ƥ����С�
�ִ��ꥹ�Ȥε��Ҥ˱����Ƥ��Υ᥽�åɤ��ƤФ�ޤ���url�ˤ�
�֥᥿����������̾:�פ����������ɽ�����Ϥ���뤳�Ȥ���դ��Ƥ���������

== Copyright
Copyright (C) 2003 zunda <zunda at freeshell.org>

Permission is granted for use, copying, modification, distribution, and
distribution of modified versions of this work under the terms of GPL
version 2 or later.
=end

class << @conf.referer_table
	private

	TdiaryDates = [
			['(?:\\?date=)?(\d{4})(\d{2})(\d{2})(?:\.html)?.*', '(\1-\2-\3)'],
			['(?:\\?date=)?(\d{4})(\d{2})(?:\.html)?.*', '(\1-\2)'],
			['(?:\\?date=)?(\d{2})(\d{2})(?:\.html)?.*', '(\1-\2)'],
	]
	TdiaryNet = '.tdiary.net/'
	HatenaHost = 'http://d.hatena.ne.jp/'

	def scheme_tdiary( url, name, block )
		TdiaryDates.each do |a|
			block.call( url + a[0], name + a[1] )
		end
		block.call( url, name )
	end

	def scheme_tdiarynet( url, name, block )
		TdiaryDates.each do |a|
			block.call( "http://#{url}#{TdiaryNet}/#{a[0]}", name + a[1] )
		end
		block.call( "http://#{url}#{TdiaryNet}/", name )
	end

	def scheme_hatena( url, name, block )
		[
			['(\d{4})(\d{2})(\d{2}).*', '(\1-\2-\3)'],
			['(\d{4})(\d{2}).*', '(\1-\2)'],
		].each do |a|
			block.call( "#{HatenaHost}#{url}/#{a[0]}", name + a[1] )
		end
		block.call( "#{HatenaHost}#{url}/", name )
	end

end
