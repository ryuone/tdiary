=begin
= Meta-scheme plugin((-$Id: referer_scheme.rb,v 1.5 2004-02-01 13:30:30 tadatadashi Exp $-))
�����Υ�󥯸��ִ��ꥹ�Ȥε��Ҥ�ڤˤ��ޤ���

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
  def scheme_��������̾( url, name )
    :
    yield( url_variants, name_variants )
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

	TdiaryNet = '.tdiary.net/'
	HatenaHost = 'http://d.hatena.ne.jp/'

	def scheme_tdiarynet( url, name )
		TdiaryDates.each do |a|
			yield( "http://#{url}#{TdiaryNet}#{a[0]}", name + a[1] )
		end
		yield( "http://#{url}#{TdiaryNet}.*", name )
	end

	def scheme_hatena( url, name )
		[
			['(\d{4})(\d{2})(\d{2}).*', '(\1-\2-\3)'],
			['(\d{4})(\d{2}).*', '(\1-\2)'],
		].each do |a|
			yield( "#{HatenaHost}#{url}/#{a[0]}", name + a[1] )
		end
		yield( "#{HatenaHost}#{url}/.*", name )
	end

	def scheme_cocolog( url, name )
		[  
			['(\d{4})/(\d\d)/post_(\d+).html', '(\1-\2[\3])'],
		].each do |a|
			yield( "http://[^\.]+\.cocolog-nifty.com/#{url}/#{a[0]}", name + a[1] )
		end
		yield( "http://[^\.]+\.cocolog-nifty.com/#{url}/.*", name )
	end
end
