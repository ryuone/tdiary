=begin
= �����Υ�󥯸��⤦����äȤ��������ץ饰����((-$Id: disp_referrer.rb,v 1.33 2003-10-14 17:38:18 zunda Exp $-))

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

=begin
== ���Υץ饰������������륯�饹�ȥ᥽�å�
=== Array
Array#values_at()��̵����硢�ɲä��ޤ���
=end
# 1.8 feature
unless [].respond_to?( 'values_at' ) then
	eval( <<-MODIFY_CLASS, TOPLEVEL_BINDING )
		class Array
			alias values_at indices
		end
	MODIFY_CLASS
end

# to be visible from inside classes
Dispref2plugin = self
Dispref2plugin_cache_path = @cache_path
Dispref2plugin_secure = @conf.secure

# cache format
Root_DispRef2URL = 'dispref2url' # root for DispRef2URLs

=begin
=== Tdiary::Plugin::DispRef2DummyPStore
PStore��Ʊ���᥽�åɤ��󶡤��ޤ����ʤˤ⤷�ޤ���db[key]������nil���֤�
���Ȥ���դ��Ƥ���������
=end
# dummy PStore
class DispRef2DummyPStore
	def initialize( file )
	end
	def transaction( read_only = false )
		yield
	end
	def method_missing( name, *args )
		nil
	end
end

=begin
=== Tdiary::Plugin::DispRef2PStore
@secure=false�������Ǥ�PStore��Ʊ���Υ᥽�åɤ�@secure=true�������Ǥ�
���⤷�ʤ��᥽�åɤ��󶡤��ޤ���

--- DispRef2PSTore#transaction( read_only = false )
     Ruby-1.7�ʹߤξ����ɤ߹������Ѥ˳������Ȥ�Ǥ��ޤ���Ruby-1.6�ξ�
     ���read_only = true�Ǥ��ɤ߽��Ѥ˳����ޤ���

--- DispRef2PSTore#real?
      ��ʪ��PSTore���Ȥ������true�������Ǥʤ�����false���֤��ޤ���
=end
unless @conf and @conf.secure then
	require 'pstore'
	class DispRef2PStore < PStore
		def real?
			true
		end
		def transaction( read_only = false )
			begin
				super
			rescue ArgumentError
				super()
			end
		end
	end
else
	class DispRef2PStore < DispRef2DummyPStore
		def real?
			false
		end
	end
end

=begin
=== Tdiary::Plugin::DispRef2String
ʸ�������ɤ��Ѵ���URL��HTML�Ǥμ�갷���˴ؤ���᥽�åɷ��Ǥ������󥹥�
�󥹤Ϻ��ޤ���Uconv�饤�֥���Nora�饤�֥�꤬����Ф����Ȥ���̵
�����̵���ʤ�˽������ޤ���

--- DispRef2String::nora?
      Nora���Ȥ�����ˤ�true�������Ǥʤ��Ȥ��ˤ�false���֤��ޤ���

--- DispRef2String::normalize( str )
      ³����������ä���site:...�Ȥ���ʸ�����ä����ꤷ�ơ���������
      ��ɤ򵬳ʲ����ޤ���

--- DispRef2String::parse_query( str )
      URL�˴ޤޤ��query��(key=value&...)����Ϥ�����̤�key�򥭡���
      value��������ͤȤ����ϥå���Ȥ����֤��ޤ����ͤΥ��󥨥������פ�
      ���ޤ���value��̵���ä����϶�ʸ�������ꤵ��ޤ���

--- DispRef2String::separate_query( str )
      URL��query��������ȸ��ʬ��������Ȥ����֤��ޤ���query����̵����
      ���nil���֤��ޤ���

--- DispRef2String::hostname( str )
      URL�˴ޤޤ��ۥ���̾���뤤��IP���ɥ쥹���֤��ޤ����ۥ���̾���ߤ�
      ����ʤ����ϡ�((|str|))���֤��ޤ���

--- DispRef2String::company_name( str, hash_list )
      URL��ꡢgoogle��biglobe�Ȥ��ä�̾���Τ���((|hash_list|))��key�˴�
      �ޤ���Τ��֤��ޤ����ߤĤ���ʤ����ϡ�nil���֤��ޤ���

--- DispRef2String::escapeHTML( str )
      HTML�˴ޤޤ�Ƥ�����ʤ褦�˥��������פ��ޤ���

--- DispRef2String::unescape( str )
      URL�򥢥󥨥������פ��ޤ���

--- DispRef2String::bytes( size )
      �Х���ñ�̤��礭����MB KB B��Ŭ�ڤ�ñ�̤��Ѵ����ޤ���

--- DispRef2String::comma( integer )
      �����򥫥�ޤ�3�夺�Ĥ�ʬ���ޤ���

--- DispRef2String::url_regexp( url )
      ((|url|))�����ִ��ꥹ���Ѥ�����ɽ��ʸ�����Ĥ���ޤ���

--- DispRef2String::url_match?( url, list )
      ((|url|))��((|list|))�Τɤ줫�˥ޥå����뤫�ɤ���Ĵ�٤ޤ���

=end
# string handling
class DispRef2String

	# strips site:... portion (google), multiple spaces, and start/end spaces
	def self::normalize( str )
		str.sub( /\bsite:(\w+\.)*\w+\b/, '' ).gsub( /[��\s\n]+/, ' ' ).strip
	end

	# parse_query parses the not unescaped query in a URL
	# copied from from CGI::parse in cgi.rb by
	#   Copyright (C) 2000  Network Applied Communication Laboratory, Inc.
	#   Copyright (C) 2000  Information-technology Promotion Agency, Japan
	#   Wakou Aoyama <wakou@ruby-lang.org>
	# eand edited
	def self::parse_query( str )
		params = Hash.new
		str.split( /[&;]/n ).each do |pair|
			k, v = pair.split( '=', 2 )
			( params[k] ||= Array.new ) << ( v ? v : '' )
		end
		params
	end

	# separate the query part (or nil) from a URL
	def self::separate_query( str )
		base, query = str.split( /\?/, 2 )
		if query then
			[ base, query ]
		else
			[ base, nil ]
		end
	end

	# get the host name (or nil) from a URL
	@@hostname_match = %r!https?://([^/]+)/?!
	def self::hostname( str )
		@@hostname_match =~ str ? $1 : str
	end

	# get the `company name' included in keys of hash_table (or nil) from a URL
	def self::company_name( str, hash_table )
		hostname( str ).split( /\./ ).values_at( -2, -3, 0 ).each do |s|
			return s if s and hash_table.has_key?( s.downcase )
		end
		nil
	end

	# escapeHTML: escape to be used in HTML
	# unescape: unesape the URL
	@@have_nora = false
	begin
		begin
			require 'web/escape'
			@@have_nora = true
		rescue LoadError
			require 'escape'
			@@have_nora = true
		end
		def self::escapeHTML( str )
			Web::escapeHTML( str )
		end
		def self::unescape( str )
			Web::unescape( str )
		end
	rescue LoadError
		def self::escapeHTML( str )
			CGI::escapeHTML( str )
		end
		def self::unescape( str )
			CGI::unescape( str )
		end
	end

	# Nora?
	def self::nora?
		@@have_nora
	end

	# add K, M with 1024 divisions
	def self::bytes( size )
		s = size.to_f
		t = s / 1024.0
		return( '%.0f' % s ) if t < 1
		s = t
		t = s / 1024.0
		return( '%.1fK' % s ) if t < 1
		return( '%.1fM' % t )
	end

	# insert comma
	def self::comma( integer )
		integer.to_s.reverse.scan(/.{1,3}/).join(',').reverse
		# [ruby-list:30144]
	end

	# make up a regexp from a url
	def self::url_regexp( url )
		r = url.dup
		r.sub!( /\/\d{4,8}\.html$/, '/' )	# from a tDiary?
		r.sub!( /\/(index\.(rb|cgi))?\?date=\d{4,8}$/, '/' )	# from a tDiary?
		r.gsub!( /\./, '\\.' )	# dots in the FQDN
		unless /(w|h)iki/i =~ r then
			r.sub!( /\?.*/, '.*' )
		else
			r.sub!( /\?.*/, '\?(.*)' )
		end
		r.sub!( /\/(index\.html?)$/, '/' )	# directory index
		r.sub!( /\/$/, '/?.*' )	# may be also from a lower level
		"^#{r}"	# always good to put a ^
	end

	# matchs to the regexp strings?
	def self::url_match?( url, list )
		list = list.split( /\n/ ) if String == list.class
		list.each do |entry|
			entry = entry[0] if Array == entry.class
			return true if /#{entry}/i =~ url
		end
		false
	end

end

=begin
=== Tdiary::Plugin::DispRef2Setup
�ץ饰�����ư������ѥ�᡼�������ꤷ�ޤ���

--- DispRef2Setup::Last_parenthesis
      ʸ����κǸ��()����Ȥ�$1�����ꤵ�������ɽ���Ǥ���

--- DispRef2Setup::First_bracket
      ʸ����κǽ��[]����Ȥ�$1�ˡ����θ��ʸ����$2�����ꤵ�������ɽ
      ���Ǥ���

--- DispRef2Setup::Defaults
      ���ץ����Υǥե�����ͤǤ���tDiary���Τ���@options�����ꤹ��ˤϡ�
      ���Υϥå����key�����ˡ�disp_referrer2.�פ�Ĥ���key��ȤäƤ���
      ���������ץ����ξܺ٤ϥ������Υ����Ȥ򻲾Ȥ��Ƥ���������

--- DispRef2Setup::new( conf, limit = 100, is_long = true )
      ((|conf|))�ˤ�tDiary��@conf��((|limit|))�ˤϰ���ܤ������ɽ����
      �󥯸�����((|is_long|))�ϰ���ʬ��ɽ���ξ��ˤ�true�򡢺ǿ���ɽ
      ���ξ��ˤ�false�����ꤷ�Ƥ���������

--- DispRef2Setup#update!
      tDiary��@options�ˤ�꼫�Ȥ򹹿����ޤ���

--- DispRef2Setup#is_long
--- DispRef2Setup#referer_table
--- DispRef2Setup#no_referer
--- DispRef2Setup#secure
      ���줾�졢����ʬ��ɽ�����ɤ�����tDiary���ִ��ơ��֥롢tDiary�Υ��
      ���������ꥹ�ȡ������Υ������ƥ�������֤��ޤ���

--- DIspRef2Setup#to_native( str )
      tDiary�θ���꥽�������������Ƥ���ʸ�������ɤ�����������᥽�å�
      �Ǥ���

--- DispRef2Setup#[]
      ���ꤵ��Ƥ����ͤ��֤��ޤ���
=end
# configuration of this plugin
class DispRef2Setup < Hash
	# useful regexps
	Last_parenthesis = /\((.*?)\)\Z/m
	First_bracket = /\A\[(.*?)\](.+)/m

	# default options
	Defaults = {
		'long.only_normal' => false,
			# true�ξ�硢����ʬ��ɽ���ǡ��̾�Υ�󥯸��ʳ��򱣤��ޤ���
		'short.only_normal' => true,
			# true�ξ�硢�ǿ���ɽ���ǡ��̾�Υ�󥯸��ʳ��򱣤��ޤ���
			# false�ξ��ϡ��ץ饰�����̵�������������ʤ�ɽ���ˤʤ�ޤ���
		'antenna.url' => '(\/a\/|(?!.*\/diary\/)antenna[\/\.]|\/tama\/|www\.tdiary\.net\/?(i\/)?(\?|$)|links?|kitaj\.no-ip\.com\/iraira\/)',
			# ����ƥʤ�URL�˰��פ�������ɽ����ʸ����Ǥ���
		'antenna.title' => '(����ƥ�|links?|����Ƥ�)',
			# ����ƥʤ��ִ����ʸ����˰��פ�������ɽ����ʸ����Ǥ���
		'normal.label' => Dispref2plugin.referer_today,
			# �̾�Υ�󥯸��Υ����ȥ�Ǥ����ǥե���ȤǤϡ��������Υ�󥯸��פǤ���
		'antenna.label' => '����ƥ�',
			# ����ƥʤΥ�󥯸��Υ����ȥ�Ǥ���
		'unknown.label' => '����¾',
			# ����¾�Υ�󥯸��Υ����ȥ�Ǥ���
		'unknown.hide' => false,
			# true�ξ��ϥ�󥯸��ִ��ꥹ�Ȥˤʤ�URL��ɽ�����ޤ���
		'search.label' => '����',
			# �������󥸥󤫤�Υ�󥯸��Υ����ȥ�Ǥ���
		'unknown.divide' => true,
			# true�ξ�硢�ִ��ꥹ�Ȥ�̵��URL���̾�Υ�󥯸���ʬ����ɽ�����ޤ���
			# false�ξ�硢�ִ��ꥹ�Ȥ�̵��URL���̾�Υ�󥯸��Ⱥ�����ɽ�����ޤ���
		'normal.group' => true,
			# true�ξ�硢�ִ����ʸ������̾�Υ�󥯸��򥰥롼�פ��ޤ���
			# false�ξ�硢URL����̤Υ�󥯸��Ȥ���ɽ�����ޤ���
		'normal.categorize' => true,
			# true�ξ�硢�ִ����ʸ����κǽ��[]��ʸ����ǥ��ƥ��꡼ʬ�����ޤ���
		'normal.ignore_parenthesis' => true,
			# true�ξ�硢���롼�פ���ݤ��ִ����ʸ����κǸ��()��̵�뤷�ޤ���
		'antenna.group' => true,
			# true�ξ�硢�ִ����ʸ������̾�Υ�󥯸��򥰥롼�פ��ޤ���
			# false�ξ�硢URL����̤Υ�󥯸��Ȥ���ɽ�����ޤ���
		'antenna.ignore_parenthesis' => true,
			# true�ξ�硢���롼�פ���ݤ��ִ����ʸ����κǸ��()��̵�뤷�ޤ���
		'search.expand' => false,
			# true�ξ�硢����������ɤȤȤ�˸������󥸥�̾��ɽ�����ޤ���
			# false�ξ�硢����Τߤ�ɽ�����ޤ���
		'search.unknown_keyword' => '�����������',
			# ������ɤ��狼��ʤ��������󥸥󤫤�Υ�󥯤˻Ȥ�ʸ����Ǥ���
		'search_engines' => DispReferrer2_Engines,
			# �������󥸥�Υϥå���Ǥ���
		'cache_label' => '(%s�Υ���å���)',
			# �������󥸥�Υ���å����URL��ɽ������ʸ����Ǥ���
		'cache_path' => "#{Dispref2plugin_cache_path}/disp_referrer2.cache",
			# ���Υץ饰����ǻȤ�����å���ե�����Υѥ��Ǥ���
		'no_cache' => false,
			# true�ξ�硢@secure=false�������Ǥ⥭��å����Ȥ��ޤ���
		'normal-unknown.title' => '\Ahttps?:\/\/',
			# �ִ����줿�֤���¾�פΥ�󥯸��Υ����ȥ롢���뤤���ִ�����Ƥ���
			# ����󥯸��Υ����ȥ�˥ޥå����ޤ���
		'configure.use_link' => true,
			# ��󥯸��ִ��ꥹ�Ȥ��Խ����̤ǡ���󥯸��ؤΥ�󥯤���ޤ���
		'reflist.ignore_urls' => '',
			# �ִ��ꥹ�ȤΥꥹ�ȥ��åפκݤ�̵�뤹��URL������ɽ����ʸ����
			# \n���ڤ��¤٤ޤ�
	}

	attr_reader :is_long, :referer_table, :no_referer, :secure

	def initialize( conf, limit = 100, is_long = true )
		super()
		@conf = conf

		# mode
		@is_long = is_long
		@limit = limit
		@options = conf.options

		# URL tables
		@referer_table = conf.referer_table
		@no_referer = conf.no_referer

		# security
		@secure = Dispref2plugin_secure

		# options from tDiary
		update!
	end

	def to_native( str )
		@conf.to_native( str )
	end

	# options from tDiary
	def update!
		# defaults
		self.replace( DispRef2Setup::Defaults.dup )

		# from tDiary
		self.each_key do |key|
			options_key = "disp_referrer2.#{key}"
			self[key] = @options[options_key] if @options.has_key?( options_key )
		end

		# additions
		self['labels'] = {
			DispRef2URL::Normal => self['normal.label'],
			DispRef2URL::Antenna => self['antenna.label'],
			DispRef2URL::Search => self['search.label'],
			DispRef2URL::Unknown => self['unknown.label'],
		}
		self['antenna.url.regexp'] = /#{self['antenna.url']}/i
		self['antenna.title.regexp'] = /#{self['antenna.title']}/i
		self['normal-unknown.title.regexp'] = /#{self['normal-unknown.title']}/i

		# limits
		self['limit'] = Hash.new
		self['limit'][DispRef2URL::Normal] = @limit || 0
		if ( @is_long ? self['long.only_normal'] : self['short.only_normal'] ) then
			[DispRef2URL::Antenna, DispRef2URL::Search, DispRef2URL::Unknown].each do
				|c| self['limit'][c] = 0
			end
		else
			[DispRef2URL::Antenna, DispRef2URL::Search, DispRef2URL::Unknown].each do |c|
				self['limit'][c] = @limit || 0
			end
		end
		if self['unknown.hide'] then
			self['limit'][DispRef2URL::Unknown] = 0
		end
		self
	end

end

=begin
=== Tdiary::Plugin::DispRef2URL

--- DispRef2URL::new( unescaped_url, setup = nil )
      �Ǥ�URL�򸵤ˤ��ƥ��󥹥��󥹤��������ޤ���((|setup|))��nil�ǤϤʤ�
      ���ˤϡ�parse( ((|setup|)) ) �⤷�ޤ���

--- DispRef2URL#restore( db )
      ����å��夫�鼫ʬ��URL���б�����������Ф��ޤ���((|db|))��
      DispRef2PStore�Υ��󥹥��󥹤Ǥ�������å��夵��Ƥ��ʤ��ä����
      �ˤ�nil���֤��ޤ���

--- DispRef2URL#parse( setup )
      DispRef2Setup�Υ��󥹥���((|setup|))�ˤ������äơ���ʬ����Ϥ��ޤ���

--- DispRef2URL::Cached_options
      DispRef2Setup�����ꤵ��륪�ץ����Τ���������å���˱ƶ���Ϳ��
      ���Τ�������֤��ޤ���

--- DispRef2URL#store( db )
      ����å���˼�ʬ��Ͽ���ޤ���((|db|))��DispRef2PStore�Υ��󥹥�
      �󥹤Ǥ�����Ͽ�������������ϼ�ʬ�򡢤����Ǥʤ����ˤ�nil���֤�
      �ޤ���

--- DispRef2URL#==( other )
      ���Ϸ�̤����������˿����֤��ޤ���

--- DispRef2URL#url
--- DispRef2URL#category
--- DispRef2URL#category_label
--- DispRef2URL#title
--- DispRef2URL#title_ignored
--- DispRef2URL#title_group
--- DispRef2URL#key
      ���줾�졢URL�����ƥ��꡼�����ƥ��꡼̾(�桼���������ꤷ�ʤ����nil)��
      �����ȥ롢���롼�ײ���������̵�뤵�줿�����ȥ�(̵�����nil)������
      ���ײ�������Υ����ȥ롢���롼�ײ�����ݤΥ������֤��ޤ���parse��
      �뤤��restore���ʤ������ꤵ��ޤ���

=end
# handling of a URL
class DispRef2URL
	attr_reader :url, :category, :category_label, :title, :title_ignored, :title_group, :key

	# category numbers
	Normal = :normal
	Antenna = :antenna
	Search = :search
	Unknown = :unknown
	Categories = [Normal, Antenna, Search, Unknown]

	# options which affects the cache
	Cached_options = %w(
		search_engines
		cache_label
		unknown.divide
		antenna.url.regexp
		antenna.url
		antenna.title.regexp
		antenna.title
		antenna.group
		antenna.ignore_parenthesis
		normal.categorize
		normal.group
		normal.ignore_parenthesis
		cache_path
	)

	def initialize( unescaped_url, setup = nil )
		@url = unescaped_url
		@dbcopy = nil
		parse( setup ) if setup
	end

	def restore( db )
		if db.real? and (
			begin
				db[Root_DispRef2URL]
			rescue PStore::Error
				false
			end
		) and db[Root_DispRef2URL][@url] then
			@category, @category_label, @title, @title_ignored, @title_group, @key = db[Root_DispRef2URL][@url]
			self
		else
			nil
		end
	end

	def parse( setup )
		parse_as_search( setup ) || parse_as_others( setup )
		self
	end

	def store( db )
	 if db.real? and (
			begin
				db[Root_DispRef2URL] ||= Hash.new
			rescue PStore::Error
				db[Root_DispRef2URL] = Hash.new
			end
		) then
			 unless @category == DispRef2URL::Search then
				db[Root_DispRef2URL]["#{@url}"] = [ @category, @category_label, @title, @title_ignored, @title_group, @key ]
			else
				db[Root_DispRef2URL].delete( @url )
			end
			self
		else
			nil
		end
	end

	def ==(other)
		return @url == other.url &&
			@category == other.category &&
			@category_label == other.category_label &&
			@title == other.title &&
			@title_ignored == other.title_ignored &&
			@title_group == other.title_group &&
			@key == other.key
	end

	private
		def parse_as_search( setup )
			# see which search engine is used
			engine = DispRef2String::company_name( @url, setup['search_engines'] )
			return nil unless engine

			# url and query
			urlbase, query = DispRef2String::separate_query( @url )

			# get titles and keywords
			title = nil
			keyword = nil
			cached_url = nil
			values = query ? DispRef2String::parse_query( query ) : nil
			catch( :done ) do
				setup['search_engines'][engine].each do |e|
					if( e[0] =~ urlbase ) then
						title = eval( e[1] )
						if e[2].empty? then
							keyword = setup['search.unknown_keyword']
							throw :done
						end
						if String == e[2].class then
							k, c = (query ? query : @url ).instance_eval( e[2] )
							if k then
								keyword = k
							else
								keyword = setup['search.unknown_keyword']
							end
							cached_url = c ? c : nil
							throw :done
						else	# should be an Array usually
							if not values then
								keyword = setup['search.unknown_keyword']
								throw :done
							end
							e[2].each do |k|
								if( values[k] and not values[k][0].empty? ) then
									unless( e[3] and e[3] =~ values[k][0] ) then
										cached_url = nil
										keyword = values[k][0]
										throw :done
									else
										cached_url = $1
										keyword = $` + $'
										throw :done
									end
								end
							end
						end
					end
				end
			end
			return nil unless keyword

			# format
			@category = Search
			@category_label = nil
			@title = DispRef2String::normalize( setup.to_native( DispRef2String::unescape( keyword ) ) )
			@title_ignored = setup.to_native( title )
			@title_ignored << sprintf( setup['cache_label'], setup.to_native( DispRef2String::unescape( cached_url ) ) ) if cached_url
			@title_group = @title
			@key = @title_group

			self
		end

		def parse_as_others( setup )

			# try to convert with referer_table
			matched = false
			title = setup.to_native( DispRef2String::unescape( @url ) )
			setup.referer_table.each do |url, name|
				unless /\$\d/ =~ name then
					if title.gsub!( /#{url}/i, name ) then
						matched = true
						break
					end
				else
					name.untaint unless setup.secure
					if title.gsub!( /#{url}/i ) { eval name } then
						matched = true
						break
					end
				end
			end

			if setup['antenna.url.regexp'] =~ @url or setup['antenna.title.regexp'] =~ title then
			# antenna
				@category = Antenna
				@category_label = nil
				grouping = setup['antenna.group']
				ignoring = setup['antenna.ignore_parenthesis']
			elsif matched and not setup['normal-unknown.title.regexp'] =~ title then
			# normal
				@category = Normal
				if setup['normal.categorize'] and DispRef2Setup::First_bracket =~ title then
					@category_label = $1
					title = $2
				else
					@category_label = nil
				end
				grouping = setup['normal.group']
				ignoring = setup['normal.ignore_parenthesis']
			else
			# unknown
				@title = title
				@title_ignored = nil
				@title_group = title
				@key = @url
				if setup['unknown.divide'] then
					@category = Unknown
					@category_label = nil
				else
					@category = Normal
					@category_label = nil
				end
				return self
			end

			# format the title
			if not grouping then
				@title  = title
				@title_group = title
				@title_ignored = nil
				@key = url
			elsif not ignoring then
				@title = title
				@title_group = title
				@title_ignored = nil
				@key = title_group
			else
				@title = title
				@title_group = title.gsub( DispRef2Setup::Last_parenthesis, '' )
				@title_ignored = $1
				@key = title_group
			end

			self
		end

	# private
end

=begin
=== Tdiary::Plugin::DispRef2Refs
--- DispRef2Refs::new( diary, setup )
      ����((|diary|))�Υ�󥯸���DispRef2Setup�Υ��󥹥���((|setup|))
      �ˤ������äƲ��Ϥ��ޤ���

--- DispRef2Refs#special_categories
      �ִ�ʸ����κǽ��[]�Ǥ����ä����ƥ���̾��٥���������뤳�Ȥˤ��
      �ƥ桼�����ˤ�ä�������줿���ƥ��꡼��������֤��ޤ���

--- DispRef2Refs#urls( category = nil )
      ��󥯸��Τ��������ƥ��꡼��((|category|))�˰��פ����Τ�
      DispRef2Cache#urls��Ʊ�ͤΥե����ޥåȤ��֤��ޤ���((|category|))
      ��nil�ξ������Ƥ�URL�ξ�����֤��ޤ���

--- DispRef2Refs#to_long_html
--- DispRef2Refs#to_short_html
      ��󥯸��Υꥹ�Ȥ�HTML���Ҥˤ��ޤ���

=end
class DispRef2Refs
	def initialize( diary, setup )
		@setup = setup
		@refs = Hash.new
		@has_ref = false
		return unless diary

		done_flag = Hash.new
		DispRef2URL::Categories.each do |c|
			done_flag[c] = (@setup['limit'][c] < 1)
		end

		db = @setup['no_cache'] ? DispRef2DummyPStore.new( @setup['cache_path'] ) : DispRef2PStore.new( @setup['cache_path'] )

		h = Hash.new
		db.transaction do
			diary.each_referer( diary.count_referers ) do |count, url|
				ref = DispRef2URL.new( url )
				@has_ref = true
				unless ref.restore( db ) then
					ref.parse( @setup )
					ref.store( db )
				end
				if @setup.is_long and @setup['normal.categorize'] then
					cat_key = ref.category_label || ref.category
				else
					cat_key = ref.category
				end
				next if done_flag[cat_key]
				h[cat_key] ||= Hash.new
				unless h[cat_key][ref.key] then
					h[cat_key][ref.key] = [count, ref.title_group, [[count, ref]]]
				else
					h[cat_key][ref.key][0] += count
					h[cat_key][ref.key][2] << [count, ref] if h[cat_key][ref.key].size < @setup['limit'][ref.category]
				end
				if h[cat_key].size >= @setup['limit'][ref.category] then
					done_flag[ref.category] = true
					break unless done_flag.has_value?( false )
				end
			end
		end
		db = nil

		h.each_pair do |cat_key, hash|
			@refs[cat_key] = hash.values
			@refs[cat_key].sort! { |a, b| b[0] <=> a[0] }
		end
	end

	def special_categories
		@refs.keys.reject!{ |c| DispRef2URL::Categories.include?( c ) }
	end

	# urls in the diary as a hash
	def urls( category = nil )
		h = Hash.new
		category = [ category ] unless category.class == Array
		(category ? category : @refs.keys).each do |cat|
			next unless @refs[cat]
			@refs[cat].each do |a|
				a[2].each do |b|
					h[b[1].url] = [ b[1].category, b[1].category_label, b[1].title, b[1].title_ignored, b[1].title_group, b[1].key ]
				end
			end
		end
		h
	end

	def to_short_html
		return '' if not @refs[DispRef2URL::Normal] or @refs[DispRef2URL::Normal].size < 1
		result = %Q[#{@setup['labels'][DispRef2URL::Normal]} | ]
		@refs[DispRef2URL::Normal].each do |a|
			result << %Q[<a href="#{DispRef2String::escapeHTML( a[2][0][1].url )}" title="#{DispRef2String::escapeHTML( a[2][0][1].title )}">#{a[0]}</a> | ]
		end
		result
	end

	def to_long_html
		return '' if not @has_ref
		# we always need a caption
		result = %Q[<div class="caption">#{@setup['labels'][DispRef2URL::Normal]}</div>\n]
		result << others_to_long_html( DispRef2URL::Normal )
		if( @setup['normal.categorize'] and special_categories ) then
			special_categories.each do |cat|
				result << others_to_long_html( cat )
			end
		end
		result << others_to_long_html( DispRef2URL::Antenna )
		result << others_to_long_html( DispRef2URL::Unknown )
		result << search_to_long_html
		result
	end

	private
		def others_to_long_html( cat_key )
			return '' unless @refs[cat_key] and @refs[cat_key].size > 0
			result = ''
			unless DispRef2URL::Normal == cat_key then
				# to_long_html provides the catpion for normal links
				if @setup['labels'].has_key?( cat_key ) then
					result << %Q[<div class="caption">#{@setup['labels'][cat_key]}</div>\n]
				else
					result << %Q[<div class="caption">#{cat_key}</div>\n]
				end
			end
			result << '<ul>'
			@refs[cat_key].each do |a|
				if a[2].size == 1 then
					result << %Q[<li><a href="#{DispRef2String::escapeHTML( a[2][0][1].url )}">#{DispRef2String::escapeHTML( a[2][0][1].title )}</a> &times;#{a[0]}</li>\n]
				elsif not a[2][0][1].title_ignored then
					result << %Q[<li><a href="#{DispRef2String::escapeHTML( a[2][0][1].url )}">#{DispRef2String::escapeHTML( a[1] )}</a> &times;#{a[0]} : #{a[2][0][0]}]
					a[2][1..-1].each do |b|
						title = (b[1].title != a[1]) ? %Q[ title="#{DispRef2String::escapeHTML( b[1].title )}"] : ''
						result << %Q[, <a href="#{DispRef2String::escapeHTML( b[1].url )}"#{title}>#{b[0]}</a>]
					end
					result << "</li>\n"
				else
					result << %Q[<li>#{DispRef2String::escapeHTML( a[1] )} &times;#{a[0]} : ]
					comma = nil
					a[2][0..-1].each do |b|
						title = (b[1].title != a[1]) ? %Q[ title="#{DispRef2String::escapeHTML( b[1].title )}"] : ''
						result << comma if comma
						result << %Q[<a href="#{DispRef2String::escapeHTML( b[1].url )}"#{title}>#{b[0]}</a>]
						comma = ', '
					end
					result << "</li>\n"
				end
			end
			result << "</ul>\n"
		end

		def search_to_long_html
			return '' unless @refs[DispRef2URL::Search] and @refs[DispRef2URL::Search].size > 0
			result = %Q[<div class="caption">#{@setup['labels'][DispRef2URL::Search]}</div>\n]
			result << ( @setup['search.expand'] ? "<ul>\n" : '<ul><li>' )
			sep = nil
			@refs[DispRef2URL::Search].each do |a|
				result << sep if sep
				if @setup['search.expand'] then
					result << '<li>'
					result << DispRef2String::escapeHTML( a[1] )
				else
					result << %Q[<a href="#{DispRef2String::escapeHTML( a[2][0][1].url )}">#{DispRef2String::escapeHTML( a[1] )}</a>]
				end
				result << %Q[ &times;#{a[0]} ]
				if @setup['search.expand'] then
					result << ' : '
					if a[2].size < 2 then
						result << %Q[<a href="#{DispRef2String::escapeHTML( a[2][0][1].url )}">#{DispRef2String::escapeHTML( a[2][0][1].title_ignored )}</a>]
					else
						comma = nil
						a[2].each do |b|
							result << comma if comma
							result << %Q[<a href="#{DispRef2String::escapeHTML( b[1].url )}">#{DispRef2String::escapeHTML( b[1].title_ignored )}</a> &times;#{b[0]}]
							comma = ', ' unless comma
						end
					end
				end
				result << '</li>' if @setup['search.expand']
				sep = ( @setup['search.expand'] ? "\n" : ' / ' ) unless sep
			end
			result << ( @setup['search.expand'] ? "</ul>\n" : "</li></ul>\n" )
		end

	# private
end

=begin
=== Tdiary::Plugin::DispRef2Cache
����å���δ����򤹤륯�饹�Ǥ���

--- DispRef2Cache.new( setup )
      ��󥯸��Υ���å����DispRef2Setup�Υ��󥹥���((|setup|))�ˤ���
      ���äƴ������ޤ���

--- DispRef2Cache#update
      ����å�������Ƥ򸽺ߤ�����˽��äƹ������ޤ����������줿URL�ο�
      ���֤��ޤ���

--- DispRef2Cache#size
      ����å���ե�������礭����Х���ñ�̤��֤��ޤ���

--- DispRef2Cache#entries
      ����å��夵��Ƥ���URL�ο����֤��ޤ���

--- DispRef2Cache#urls( category = nil )
      ����å��夵��Ƥ���URL�ξ���Τ��������ƥ��꡼��((|category|))��
      ���פ����Τ�URL�򥭡���������������ͤȤ����ϥå���Ȥ����֤�
      �ޤ���((|category|))��nil�ξ������Ƥ�URL�ξ�����֤��ޤ���
      * ���ƥ��꡼
      * ���ƥ��꡼�Υ�٥�(���뤤��nil)
      * �ִ����ʸ����
      * ���롼�פ���ݤ�̵�뤵�줿ʸ����
      * ���롼�����Τ�ʸ����
      * ���롼�פ���ݤΥ���

--- DispRef2Cache#unknown_urls
      ����å��夵��Ƥ���URL�Τ������ִ��Ǥ��ʤ��ä���Τ�URL������� 
      �֤��ޤ����ִ��Ǥ��ʤ��ä�URL��̵�����ˤ϶���������֤��ޤ���

=end
# cache management
class DispRef2Cache
	def initialize( setup )
		@setup = setup
	end

	# updates the cache according to the current setup
	def update
		return 0 if @setup.secure or @setup['no_cache'] or not FileTest::exist?( @setup['cache_path'] )

		h = Hash.new
		r = 0
		db = DispRef2PStore.new( @setup['cache_path'] )
		db.transaction do
			begin
				db[Root_DispRef2URL].each_key do |url|
					ref = DispRef2URL::new( url )
					t = ref.restore( db )
					orig = t ? t.dup : nil
					new = ref.parse( @setup )
					if orig != new then
						r += 1
						ref.store( db )
					end
				end
			rescue PStore::Error
			end
		end
		db = nil
		r
	end

	# size of cache in bytes
	def size
		return 0 if @setup.secure or @setup['no_cache'] or not FileTest::exist?( @setup['cache_path'] )

		FileTest.size( @setup['cache_path'] )
	end

	# number of urls in the cache
	def entries
		return 0 if @setup.secure or @setup['no_cache'] or not FileTest::exist?( @setup['cache_path'] )

		r = 0
		db = DispRef2PStore.new( @setup['cache_path'] )
		db.transaction( true ) do
			begin
				r = db[Root_DispRef2URL].size
			rescue PStore::Error
				r = 0
			end
		end
		db = nil
		r
	end

	# cached urls as a hash
	def urls( category = nil )
		return {} if @setup.secure or @setup['no_cache'] or not FileTest::exist?( @setup['cache_path'] )

		h = Hash.new
		db = DispRef2PStore.new( @setup['cache_path'] )
		db.transaction( true ) do
			begin
				db[Root_DispRef2URL].each_pair do |url, data|
					h[url] = data if not category or category == data[0]
				end
			rescue PStore::Error
			end
		end
		db = nil
		h
	end

	# cached unknown urls as an array
	def unknown_urls
		return [] if @setup.secure or @setup['no_cache'] or not FileTest::exist?( @setup['cache_path'] )

		r = Array.new
		db = DispRef2PStore.new( @setup['cache_path'] )
		db.transaction( true ) do
			begin
				db[Root_DispRef2URL].each_pair do |url, data|
					next if DispRef2String::url_match?( url, @setup.no_referer )
					next if DispRef2String::url_match?( url, @setup['reflist.ignore_urls'] )
					r << url if DispRef2URL::Unknown == data[0] or @setup['normal-unknown.title.regexp'] =~ data[2]
				end
			rescue PStore::Error
			end
		end
		db = nil
		r
	end

end

=begin
=== TDiary::Plugin::DispRef2SetupIF
���Υץ饰���������Τ����HTML����������CGI�ꥯ�����Ȥ�������ޤ���

--- DispRef2SetupIF::new( cgi, setup, conf, mode )
      CGI�Υ��󥹥���((|cgi|))��DispRef2Setup�Υ��󥹥���((|setup|))
      ��ꡢ����Τ���Υ��󥹥��󥹤��������ޤ���TDiary::Plugin��ꡢ
      @conf��@mode������˻��ꤷ�Ƥ���������

--- DispRef2SetupIF#show_html
      ����ι�����ɬ�פʤ饭��å���ι����򤷤Ƥ���HTML��ɽ�����ޤ���

--- DispRef2SetupIF#show_description
      ���Υץ饰�����HTML�Ǥ������Ǥ������ꤹ����ܤ����٤ޤ���

--- DispRef2SetupIF#show_options
      ���Υץ饰����Υ��ץ��������ꤹ��HTML���Ҥ��֤��ޤ���

--- DispRef2SetupIF#show_unknown_list
      ��󥯸��ִ��ꥹ�Ȥ��Խ��Τ����HTML���Ҥ��֤��ޤ���

--- DispRef2SetupIF#update_options
      cgi��������Ϥ˱����ơ����Υץ饰����Υ��ץ����򹹿����ޤ���
      @setup�⹹�����ޤ���

--- DispRef2SetupIF#update_tables
      cgi��������Ϥ˱����ơ���󥯸��ִ��ꥹ�Ȥ򹹿����ޤ���
=end
# WWW Setup interface
class DispRef2SetupIF

	# setup mode
	Options = 'options'
	RefList = 'reflist'
	
	def initialize( cgi, setup, conf, mode )
		@cgi = cgi
		@setup = setup
		@conf = conf
		@conf['disp_referrer2.reflist.ignore_urls'] ||= ''
		@mode = mode
		@updated_url = nil
		@need_cache_update = false
		if @cgi.params['dr2.change_mode'] and @cgi.params['dr2.change_mode'][0] then
			case @cgi.params['dr2.new_mode'][0]
			when Options
				@current_mode = Options
			when RefList
				@current_mode = RefList
			else
				@current_mode = Options
			end
		elsif @cgi.params['dr2.current_mode'] then
			case @cgi.params['dr2.current_mode'][0]
			when Options
				@current_mode = Options
			when RefList
				@current_mode = RefList
			else
				@current_mode = Options
			end
		else
			@current_mode = Options
		end
		if not @setup.secure and not @setup['no_cache'] then
			@cache = DispRef2Cache.new( @setup )
		else
			@cache = nil
		end
	end

	# do what to do and make html
	def show_html
		# things to be done
		if @mode == 'saveconf' then
			case @current_mode
			when Options
				update_options
			when RefList
				update_tables
			end
		end

		# update cache
		if not @setup.secure then
			if not @setup['no_cache'] then
				unless @cache then
					@need_cache_update = true
					@cache = DispRef2Cache.new( @setup )
				end
				if not 'never' == @cgi.params['dr2.cache.update'][0] and ('force' == @cgi.params['dr2.cache.update'][0] or @need_cache_update) then
					@updated_url = @cache.update
				end
			else
				if @setup['no_cache'] then
					@cache = nil
				end
			end
		end

		# result
		r = show_description
		case @current_mode
		when Options
			r << show_options
		when RefList
			r << show_unknown_list
		end
		r
	end

	# show description
	def show_description
		case @conf.lang
		when 'en'
			<<-_HTML
				<h3 class="subtitle">A little bit more powerful display of referrers</h3>
			_HTML
		else
			r = <<-_HTML
				<h3 class="subtitle">�����Υ�󥯸��⤦����äȤ��������ץ饰����</h3>
				<p>$Revision: 1.33 $</p>
				<p>����ƥʤ���Υ�󥯡����������󥸥�θ�����̤�
					�̾�Υ�󥯸��β��ˤޤȤ��ɽ�����ޤ���
					���������󥸥�θ�����̤ϡ���������ˤޤȤ���ޤ���
					�ܤ����ϡ�<a href="http://zunda.freeshell.org/d/plugin/disp_referrer2.rb">�ץ饰����Υ�����</a>�Υɥ�����Ȥ�������������
					���ո�������˾�ϡ�<a href="http://tdiary-users.sourceforge.jp/cgi-bin/wiki.cgi?disp_referrer2.rb">�������Wiki</a>�ޤǡ�</p>
			_HTML
			if DispRef2String.nora? then
				r << <<-_HTML
					<p>Nora�饤�֥���ȤäƤ��ޤ��Τǡ�
						ɽ��������®���Ϥ��Ǥ���</p>
				_HTML
			else
				r << <<-_HTML
					<p>ɽ��®�٤����ˤʤ���ϡ�
						<a href="http://raa.ruby-lang.org/list.rhtml?name=Nora">Nora</a>
						�饤�֥��򥤥󥹥ȡ��뤷�ƤߤƤ���������</p>
				_HTML
			end
			if @cache then
				r << <<-_HTML if @updated_url
					<p>����å���Τ�����#{@updated_url}�Ĥ�URL����������ޤ�����</p>
				_HTML
				r << <<-_HTML
					<p>���ߡ�����å�����礭����#{DispRef2String::bytes( @cache.size )}�Х��ȡ�
						#{DispRef2String::comma( @cache.entries )}�Ĥ�URL������å��夵��Ƥ��ޤ���
						��<a href="#{@conf.update}?conf=referer">��󥯸�</a>�פ��ѹ��θ�ˤ�
						<a href="#{@conf.update}?conf=disp_referrer2;dr2.cache.update=force;dr2.current_mode=#{@current_mode}">����å���ι���</a>��ɬ�פ��⤷��ޤ���
					</p>
				_HTML
			end
			case @current_mode
			when Options
				r << <<-_HTML
					<p>����¾�Υ�󥯸����ִ��ꥹ�Ȥ��Խ���<a href="#{@conf.update}?conf=disp_referrer2;dr2.new_mode=#{RefList};dr2.change_mode=true">�ܤ�</a>��
				_HTML
			when RefList
				r << <<-_HTML
					<p>����Ū�������<a href="#{@conf.update}?conf=disp_referrer2;dr2.new_mode=#{Options};dr2.change_mode=true">�ܤ�</a>��
				_HTML
			end
			r << <<-_HTML
				��󥯸��ִ��ꥹ�Ȥϡ�<a href="#{@conf.update}?conf=referer">��󥯸�</a>�פ�����Խ��Ǥ��ޤ���</p>
				<input type="hidden" name="saveconf" value="ok">
				<hr>
			_HTML
			r
		end
	end

	# show options
	def show_options
		case @conf.lang
		when 'en'
			<<-_HTML
				<h4>Options</h4>
				<p>I am sorry. English page is not yet ready.</p>
			_HTML
		else
			r = <<-_HTML
				<h4>��󥯸���ʬ���ɽ��</h4>
				<p>
					<input name="dr2.current_mode" value="#{Options}" type="hidden">
					��󥯸��ִ��ꥹ�Ȥˤʤ���󥯸���
					<input name="dr2.unknown.divide" value="true" type="radio"#{' checked'if @setup['unknown.divide']}>#{@setup['unknown.label']}�Υ�󥯸��Ȥ���ʬ���� /
					<input name="dr2.unknown.divide" value="false" type="radio"#{' checked'if not @setup['unknown.divide']}>�̾�Υ�󥯸��Ⱥ����롣
				</p>
				<p>
					#{@setup['unknown.label']}�Υ�󥯸���
					<input name="dr2.unknown.hide" value="false" type="radio"#{' checked'if not @setup['unknown.hide']}>ɽ������ /
					<input name="dr2.unknown.hide" value="true" type="radio"#{' checked'if @setup['unknown.hide']}>������
				</p>
				<p>
					��󥯸��ִ��ꥹ�Ȥ��ִ����ʸ����κǽ��[]�򥫥ƥ��꡼ʬ����
					<input name="dr2.normal.categorize" value="true" type="radio"#{' checked'if @setup['normal.categorize']}>�Ȥ� /
					<input name="dr2.normal.categorize" value="false" type="radio"#{' checked'if not @setup['normal.categorize']}>�Ȥ�ʤ���
				</p>
				<p>
					����ʬ��ɽ���ǡ��̾�Υ�󥯸��ʳ��Υ�󥯸���
					<input name="dr2.long.only_normal" value="false" type="radio"#{' checked'if not @setup['long.only_normal']}>ɽ������ /
					<input name="dr2.long.only_normal" value="true" type="radio"#{' checked'if @setup['long.only_normal']}>������
				</p>
				<p>
					�ǿ���ɽ���ǡ��̾�Υ�󥯸��ʳ��Υ�󥯸���
					<input name="dr2.short.only_normal" value="false" type="radio"#{' checked'if not @setup['short.only_normal']}>ɽ������ /
					<input name="dr2.short.only_normal" value="true" type="radio"#{' checked'if @setup['short.only_normal']}>������
					(ɽ��������ˤϡ����Υץ饰����̵�����Ȥޤä���Ʊ��ɽ���ˤʤ�ޤ���)
				</p>
				<h4>�̾�Υ�󥯸��Υ��롼�ײ�</h4>
				<p>
					�̾�Υ�󥯸���
					<input name="dr2.normal.group" value="true" type="radio"#{' checked'if @setup['normal.group']}>�ִ����ʸ����ǤޤȤ�� /
					<input name="dr2.normal.group" value="false" type="radio"#{' checked'if not @setup['normal.group']}>URL���ʬ���롣
				</p>
				<p>
					�̾�Υ�󥯸����ִ����ʸ����ǤޤȤ����ˡ��Ǹ��()��
					<input name="dr2.normal.ignore_parenthesis" value="true" type="radio"#{' checked'if @setup['normal.ignore_parenthesis']}>̵�뤹�� /
					<input name="dr2.normal.ignore_parenthesis" value="false" type="radio"#{' checked'if not @setup['normal.ignore_parenthesis']}>̵�뤷�ʤ���
				</p>
				<h4>����ƥʤ���Υ�󥯤Υ��롼�ײ�</h4>
				<p>
					����ƥʤ���Υ�󥯤�
					<input name="dr2.antenna.group" value="true" type="radio"#{' checked'if @setup['antenna.group']}>�ִ����ʸ����ǤޤȤ�� /
					<input name="dr2.antenna.group" value="false" type="radio"#{' checked'if not @setup['antenna.group']}>URL���ʬ���롣
				</p>
				<p>
					����ƥʤ���Υ�󥯤��ִ����ʸ����ǤޤȤ����ˡ��Ǹ��()��
					<input name="dr2.antenna.ignore_parenthesis" value="true" type="radio"#{' checked'if @setup['antenna.ignore_parenthesis']}>̵�뤹�� /
					<input name="dr2.antenna.ignore_parenthesis" value="false" type="radio"#{' checked'if not @setup['antenna.ignore_parenthesis']}>̵�뤷�ʤ���
				</p>
				<h4>����������ɤ�ɽ��</h4>
				<p>
					�������󥸥�̾��
					<input name="dr2.search.expand" value="true" type="radio"#{' checked'if @setup['search.expand']}>ɽ������ /
					<input name="dr2.search.expand" value="false" type="radio"#{' checked'if not @setup['search.expand']}>ɽ�����ʤ���
				</p>
			_HTML
			unless @setup.secure then
			r << <<-_HTML
				<h4>����å���</h4>
				<p>
					����å����
					<input name="dr2.no_cache" value="false" type="radio"#{' checked'if not @setup['no_cache']}>���Ѥ��� /
					<input name="dr2.no_cache" value="true" type="radio"#{' checked'if @setup['no_cache']}>���Ѥ��ʤ���
				</p>
				<p>����������ѹ��ǡ�����å����
					<input name="dr2.cache.update" value="force" type="radio">�������� /
					<input name="dr2.cache.update" value="auto" type="radio" checked>ɬ�פʤ鹹������ /
					<input name="dr2.cache.update" value="never" type="radio">�������ʤ���
				</p>
				<p>
					����å���ι����ˤ�¿���λ��֤��������礬����ޤ���
					OK�ܥ���򲡤����餷�Ф餯���Ԥ�����������
					����������å���򹹿����ʤ���ɽ����̷�⤬�����뤳�Ȥ�����ޤ���
				</p>
			_HTML
			end # unless @setup.secure
			r
		end
	end

	# shows URL list to be added to the referer_table or no_referer
	def show_unknown_list
		if @setup.secure then
			urls = DispRef2Latest_cache.unknown_urls
		elsif @setup['no_cache'] then
			urls = DispRef2Latest.new( @cgi, 'latest.rhtml', @conf, @setup ).unknown_urls
		else
			urls = DispRef2Cache.new( @setup ).unknown_urls
		end
		case @conf.lang
		when 'en'
			<<-_HTML
				<h4>Referrer list</h4>
				<p>I am sorry. English page is not yet ready.</p>
			_HTML
		else
			r = <<-_HTML
				<h4>��󥯸��ִ��ꥹ��</h4>
				<input name="dr2.current_mode" value="#{RefList}" type="hidden">
			_HTML
			if @cache then
				r << "<p>#{@setup['unknown.label']}�Υ�󥯸��ϥ���å�����椫��õ���Ƥ��ޤ���"
			else
				r << "<p>#{@setup['unknown.label']}�Υ�󥯸��Ϻǿ�ɽ������������õ���Ƥ��ޤ���"
			end
			r << <<-_HTML
				��󥯸������ꥹ�Ȥ�̵��ꥹ�Ȥ˰��פ���URL�Ϥ����ˤ�ɽ������ޤ���
			</p>
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
				if ENV['AUTH_TYPE'] and ENV['REMOTE_USER'] and @setup['configure.use_link'] then
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
					if ENV['AUTH_TYPE'] and ENV['REMOTE_USER'] and @setup['configure.use_link'] then
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
				unless @setup.secure or @setup['no_cache'] then
					r << <<-_HTML
						<p>
							����å���ι����ˤ�¿���λ��֤��������礬����ޤ���
							OK�ܥ���򲡤����餷�Ф餯���Ԥ�����������
						</p>
					_HTML
				end
			else
				r << <<-_HTML
					<p>���ߡ�#{@setup['unknown.label']}�Υ�󥯸��Ϥ���ޤ���</p>
				_HTML
			end
			r << <<-_HTML
				<h4>����ƥʤΤ��������ɽ��</h4>
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

	# updates the options
	def update_options
		dirty = false
		# T/F options
		%w( antenna.group antenna.ignore_parenthesis antenna.search.expand
			normal.categorize normal.group normal.ignore_parenthesis
			search.expand long.only_normal short.only_normal no_cache unknown.divide
			unknown.hide
		).each do |key|
			tdiarykey = 'disp_referrer2.' + key
			case @cgi.params['dr2.' + key][0]
			when 'true'
				unless @conf[tdiarykey] == true then
					@conf[tdiarykey] = true
					@need_cache_update = true if DispRef2URL::Cached_options.include?( key )
					dirty = true
				end
			when 'false'
				unless @conf[tdiarykey] == false then
					@conf[tdiarykey] = false
					@need_cache_update = true if DispRef2URL::Cached_options.include?( key )
					dirty = true
				end
			end
		end

		# update @setup
		@setup.update! if dirty
	end

	# referer tables
	def update_tables
		dirty = false

		if @cgi.params['dr2.urls'] and @cgi.params['dr2.urls'][0].to_i > 0
			@cgi.params['dr2.urls'][0].to_i.times do |i|
				if not @cgi.params["dr2.#{i}.reg"][0].empty? and not @cgi.params["dr2.#{i}.title"][0].empty? then
					a = [
						@setup.to_native( @cgi.params["dr2.#{i}.reg"][0] ).sub( /[\r\n]+/, '' ),
						@setup.to_native( @cgi.params["dr2.#{i}.title"][0] ).sub( /[\r\n]+/, '' )
					]
					if not a[0].empty? and not a[1].empty? then
						@conf.referer_table2.unshift( a )
						@conf.referer_table.unshift( a )
							# to reflect the change in this requsest
						@need_cache_update = true
						dirty = true
					end
				end
				if 'true' == @cgi.params["dr2.#{i}.noref"][0] then
					unless @cgi.params["dr2.#{i}.reg"][0].empty? then
						reg = @setup.to_native( @cgi.params["dr2.#{i}.reg"][0] ).strip
						unless reg.empty? then
							@conf.no_referer2.unshift( reg )
							@conf.no_referer.unshift( reg	)
								# to reflect the change in this requsest
						end
					end
				end
				if 'true' == @cgi.params["dr2.#{i}.ignore"][0] then
					unless @cgi.params["dr2.#{i}.reg"][0].empty? then
						reg = @setup.to_native( @cgi.params["dr2.#{i}.reg"][0] ).strip
						unless reg.empty? then
							@conf['disp_referrer2.reflist.ignore_urls'] << reg + "\n"
							dirty = true
						end
					end
				end
			end
		end

		if @cgi.params['dr2.clear_ignore_urls'] and 'true' == @cgi.params['dr2.clear_ignore_urls'][0] then
			@conf['disp_referrer2.reflist.ignore_urls'] = ''
			dirty = true
		end

		%w( url title ).each do |cat|
			if 'true' == @cgi.params["dr2.antenna.#{cat}.default"][0]  then
				@conf["disp_referrer2.antenna.#{cat}"] = DispRef2Setup::Defaults["antenna.#{cat}"]
				dirty = true
				@need_cache_update = true
			elsif @cgi.params["dr2.antenna.#{cat}"] and @cgi.params["dr2.antenna.#{cat}"][0] and @cgi.params["dr2.antenna.#{cat}"][0] != @conf["disp_referrer2.antenna.#{cat}"] then
				newval = @cgi.params["dr2.antenna.#{cat}"][0].strip
				unless newval.empty? then
					@conf["disp_referrer2.antenna.#{cat}"] = newval
					dirty = true
					@need_cache_update = true
				end
			end
		end

		# update @setup
		@setup.update! if dirty
	end

end

=begin
=== TDiary::Plugin::DispRef2Latest
����å��夬̵�����ˡ�����ץ饰����������Υ�󥯸������뤿��Υ��饹
�Ǥ���

--- DispRef2Latest::new( cgi, skeltonfile, conf, setup )
      TDiary::TDiaryLatest�ΰ����˲ä��ơ�DispRef2Setup�Υ��󥹥���
      ((|setup|))������ˤȤ�ޤ���

--- DispRef2Latest::unknown_urls
      �ǿ��������Υ�󥯸��Τ������ִ��Ǥ��ʤ��ä���Τ�URL��������֤�
      �ޤ����ִ��Ǥ��ʤ��ä�URL��̵�����ˤ϶���������֤��ޤ���

=end
class DispRef2Latest < TDiary::TDiaryLatest

	def initialize( cgi, rhtml, conf, setup )
		super( cgi, rhtml, conf )
		@setup = setup
	end

	# correct unknown URLs from the newest diaries
	def unknown_urls
		r = Array.new
		self.latest( @conf.latest_limit ) do |diary|
			refs = DispRef2Refs.new( diary, @setup )
			h = refs.urls( DispRef2URL::Antenna )
			h.each_key do |url|
				next unless @setup['normal-unknown.title.regexp'] =~ h[url][2]
				next if DispRef2String::url_match?( url, @setup.no_referer )
				next if DispRef2String::url_match?( url, @setup['reflist.ignore_urls'] )
				r << url
			end
			h = nil
			refs.urls( DispRef2URL::Unknown ).each_key do |url|
				next if DispRef2String::url_match?( url, @setup.no_referer )
				next if DispRef2String::url_match?( url, @setup['reflist.ignore_urls'] )
				r << url
			end
		end
		r.uniq
	end

end

=begin
=== Tdiary::Plugin
--- Tdiary::Plugin#configure_disp_referrer2
      ���Υץ饰���������Τ���˻Ȥ���᥽�åɤǤ���add_conf_proc��
      ��ޤ���

�ʲ��ϡ����Υץ饰����ǥ����С��饤�ɤ����tDiary�Υ᥽�åɤǤ���
--- Tdiary::Plugin#referer_of_today_long( diary, limit = 100 )
--- Tdiary::Plugin#referer_of_today_short( diary, limit = 10 )
=end

# for configuration interface
add_conf_proc( 'disp_referrer2', '��󥯸��⤦����äȶ���' ) do
	setup = DispRef2Setup.new( @conf, 100, true )
	wwwif = DispRef2SetupIF.new( @cgi, setup, @conf, @mode )
	wwwif.show_html
end

# for one-day diary
def referer_of_today_long( diary, limit = 100 )
	return '' if bot?
	setup = DispRef2Setup.new( @conf, limit, true )
	DispRef2Refs.new( diary, setup ).to_long_html
end

# for newest diary
alias dispref2_original_referer_of_today_short referer_of_today_short
def referer_of_today_short( diary, limit = 10 )
	return '' if bot?
	return dispref2_original_referer_of_today_short( diary, limit ) if @options.has_key?( 'disp_referrer2.short.only_normal' ) and not @options['disp_referrer2.short.only_normal']
	setup = DispRef2Setup.new( @conf, limit, false )
	DispRef2Refs.new( diary, setup ).to_short_html
end

# we have to know the unknown urls at this moment in a secure diary
if @conf.secure and (\
	( @cgi.params['dr2.change_mode'] \
		and DispRef2SetupIF::RefList == @cgi.params['dr2.new_mode'][0] ) \
		or ( @cgi.params['dr2.current_mode'] \
		and DispRef2SetupIF::RefList == @cgi.params['dr2.current_mode'][0] ) )
then
	setup = DispRef2Setup.new( @conf, 100, true )
	DispRef2Latest_cache = DispRef2Latest.new( @cgi, 'latest.rhtml', @conf, setup )
else
	DispRef2Latest_cache = nil
end
