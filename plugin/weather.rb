#!/usr/bin/env ruby
=begin
= ��������ŷ���ץ饰����((-$Id: weather.rb,v 1.5 2003-07-21 14:49:24 zunda Exp $-))
��������ŷ���򡢤�������������ǽ�˹���������˼���������¸�������줾��
�����������ξ�����ɽ�����ޤ���

== ������ˡ
���Υե�����κǿ��Ǥϡ�
((<URL:http://zunda.freeshell.org/d/plugin/weather.rb>))
�ˤ���ޤ���

== �Ȥ���
=== ���󥹥ȡ�����������ˡ
���Υե������plugin�ǥ��쥯�ȥ�˥��ԡ����Ƥ������������������ɤ�
EUC-JP�Ǥ���

���ˡ�tdiary.conf���Խ����뤫��WWW�֥饦������tDiary��������̤���֤���
����ŷ���פ�����ǡ�ŷ���ǡ����򤤤������Ƥ���URL�����ꤷ�Ƥ���������
tdiary.conf���Խ�������ˤϡ�@options['weather.url']�����ꤷ�Ƥ����� 
����ξ��������򤷤����ˤϡ�tDiary��������̤Ǥ����꤬ͥ�褵��ޤ���

�㤨�С� NOAA National Weather Service�����Ѥ�����ˤϡ�
((<URL:http://weather.noaa.gov/>))���顢Select a country...�ǹ�̾������
��Go!�ܥ���򲡤������˴�¬����������Ǥ������������λ�ɽ�����줿�ڡ���
��URL���㤨�С�
  @options['weather.url'] = 'http://weather.noaa.gov/weather/current/RJTI.html'
�Ƚ񤤤Ƥ���������������Ǥ�����إ�ݡ���((-�ɤ��ˤ�������-))��ŷ��
����Ͽ����ޤ�������������Ѥ����¤���Ƥ����礬����ޤ��Τǡ����Τ�
����WWW�ڡ�����������������ʤ��褦����դ��Ƥ���������

����ˡ����������Υ����ॾ�����Ѳ������ǽ�����������ϡ����Υ����ॾ��
���@options['weather.tz']�����Ķ��ѿ�TZ�����ꤷ�Ƥ������Ȥ򤪴��ᤷ 
�ޤ�������ˤ�äơ����������ۤ�����⡢ŷ���ǡ����������Υ����ॾ���� 
��ŷ����ɽ����³���뤳�Ȥ��Ǥ��ޤ���tdiary.conf�����ꤹ����ϡ��㤨��
����ɸ����ξ��ϡ�
  @options['weather.tz'] = 'Japan'
�����ꤷ�Ƥ���������

����ǡ�������������������٤ˡ����ꤷ��URL����ŷ���ǡ�����������ơ�
ɽ������褦�ˤʤ�Ϥ��Ǥ���ŷ���ϡ�
  <div class="weather"><span class="weather">hh:mm����<a href="������URL">ŷ��(����)</a></span></div>
�Ȥ��������Ǥ��줾������������ξ��ɽ������ޤ���ɬ�פʤ�С�CSS���Խ�
���Ƥ���������
  div.weather {
    text-align: right;
    font-size: 75%;
  }
�ʤɤȤ��Ƥ����Ф����Ǥ��礦��

�����˻��Ѥ��Ƥ���WWW�����С����饵���С��θ��¤�WWW�ڡ����α������Ǥ���
ɬ�פ�����ޤ����Ķ��ѿ�TZ���ѹ������礬����ޤ��Τǡ�secure�⡼�ɤǤ�
�Ȥ��ޤ���mod_ruby�Ǥ�ư��Ϻ��ΤȤ����ǧ���Ƥ��ޤ���

�ǥե���ȤǤϡ�����ü������������줿���ˤ�ŷ����ɽ�����ʤ��褦�ˤʤ�
�Ƥ��ޤ������Ӥ���Ǥ�ŷ����ɽ�����������ˤϡ�������̤������ꤹ�뤫��
tdiary.conf��
  @options['weather.show_mobile'] = true
����ꤷ�Ƥ���������

=== ��¸�����ŷ���ǡ����ˤĤ���
ŷ���ǡ����ϡ�
* �񤤤Ƥ����������դȸ��ߤ����դ����פ���
* ��������ŷ���ǡ������ޤ���������Ƥ��ʤ���������μ������˥��顼�����ä�
���ˡ���������ޤ���

ŷ���ǡ����ϡ�@options['weather.dir']�����ꤷ���ǥ��쥯�ȥ꤫��
@cache_path/weather/ �ǥ��쥯�ȥ�ʲ��ˡ�ǯ/ǯ��.weather �Ȥ����ե��� ��
̾����¸����ޤ������ֶ��ڤ�Υƥ����ȥե�����Ǥ��Τ�ɬ�פ˱������Խ� 
���뤳�Ȥ��Ǥ��ޤ������֤ο����Ѥ��Ƥ��ޤ�ʤ��褦�˵���Ĥ����Խ����Ƥ�
���������ե����ޥåȤξܺ٤ϡ�Weather.to_s�᥽�åɤ򻲾Ȥ��Ƥ���������

ŷ���ǡ����ˤϡ��ǡ����μ������郎��Ͽ����Ƥ��ޤ����ޤ����ǡ����μ�����
��������줿��ŷ���ι������郎��Ͽ����Ƥ��뤳�Ȥ⤢��ޤ��������λ���
�ϡ�����ɸ���(UNIX����)��ľ����Ƶ�Ͽ����Ƥ��ơ�������ɽ��������˸���
�����ľ���Ƥ��ޤ������Τ��ᡢŷ����Ͽ�������Υ����ॾ����ȡ�ŷ����ɽ
��������Υ����ॾ���󤬰ۤʤäƤ��ޤ��ȡ��㤨��ī��ŷ�����ä���Τ�ͼ��
��ŷ���Ȥ���ɽ������Ƥ��ޤ����Ȥˤʤ�ޤ���������ɤ��ˤϡ��㤨�С�
  @options['weather.tz'] = 'Japan'
�Ȥ������ץ��������ꤷ�ơ��ǡ����˥����ॾ�����Ͽ����褦�ˤ��Ƥ���
������tdiary.conf�ʤɤǡ�
  ENV['TZ'] = 'Japan'
�ʤɤȤ��ƴĶ��ѿ�TZ�����ꤹ�뤳�ȤǤ�Ʊ�ͤθ��̤������ޤ����Ķ��ѿ���
���ꤷ�����ϡ�tDiary���Τ�ư��˱ƶ�������ޤ��Τ�α�դ��Ƥ���������

�ʤ���1.1.2.19����������ΥС�������weather.rb�Ǥϥ����ॾ����ξ���
ŷ���ǡ����˵�Ͽ����Ƥ��ޤ��󡣤�����Ǥ�����ɬ�פʤ�С��ե�������Խ�
���ơ������ॾ���������ɲä��Ƥ�����������Ͽ�ե�����ϡ��ǥե���ȤǤϡ�
  .../cache/weather/2003/200301.weather
�ʤɤˤ���ޤ���������URL�μ��ο�����UNIX����Ǥ��Τǡ������³���ơ���
����Ĥȡ�Japan�ʤɥ����ॾ����򼨤�ʸ��������Ϥ��Ƥ����������ǡ���
�������˥��顼���ʤ���С����θ売�ĤΥ��֤�³���ơ�ŷ���Υǡ�������Ͽ��
��Ƥ���Ϥ��Ǥ���

=== ���ץ����
==== ɬ�����꤬ɬ�פʹ���
: @options['weather.url']
  ŷ���ǡ�����������WWW�ڡ�����URL��
    @options['weather.url'] = 'http://weather.noaa.gov/weather/current/RJTI.html'
  �ʤɡ�����������Ѥ����¤���Ƥ����礬����ޤ��Τǡ����Τ褦��WWW
  �ڡ�����������������ʤ��褦����դ��Ƥ����������֥饦���������ꤷ��
  ���Ϥ����餬ͥ�褵��ޤ���

==== ���ꤷ�ʤ��Ƥ⤤������
: @options['weather.show_mobile'] = false
  true�ξ��ϡ�����ü������Υ��������ξ��ˡ�i_html_string����������
  ��CHTML��ɽ�����ޤ���false�ξ��ϡ�����ü������Υ��������ξ��ˤ�ŷ
  ����ɽ�����ޤ��󡣥֥饦���������ꤷ�����Ϥ����餬ͥ�褵��ޤ���
  
: @options['weather.tz']
  �ǡ���������������Υ����ॾ���󡣥��ޥ�ɥ饤�����㤨�С�
    TZ=Japan date
  ��¹Ԥ������������郎ɽ�������ʸ��������ꤷ�Ƥ���������Linux�Ǥϡ�
  /usr/share/zoneinfo�ʲ��Υե�����̾����ꤹ��Ф����Ϥ��Ǥ����֥饦��
  �������ꤷ�����Ϥ����餬ͥ�褵��ޤ������Υ��ץ���󤬻��ꤵ��Ƥ�
  �ʤ���硢�Ķ��ѿ�TZ�����ꤵ��Ƥ���Ф����ͤ���Ѥ��ޤ��������Ǥʤ�
  ��Х����ॾ����ϵ�Ͽ���ޤ���
   
  ŷ���ǡ����˥����ॾ���󤬵�Ͽ����Ƥ��ʤ����ϡ��⤷���������Υ�����
  �������ѹ����줿���˰㤦�����ɽ�����뤳�Ȥˤʤ�ޤ���
  
  ���դ�Ƚ��ʤɡ�ŷ���ǡ����ε�Ͽ�ʳ��λ���δ����ˤϡ��������ΤΥ�����
  �������Ѥ����ޤ���

: @options['weather.oldest'] = 21600
  ����줿�ǡ����������Υ��ץ����(��)���Ť����ˤϡ�ŷ���μ������顼
  �ˤʤꡢ���������ι����ǺƤӥǡ�����������褦�Ȥ��ޤ����ǥե���Ȥ�6
  ����(21600��)�Ǥ������Υ��ץ����nil�����ꤵ��Ƥ�����ˤϡ��ɤ��
  �˸Ť��ǡ����Ǥ��������ޤ���

: @options['weather.show_error']
  �ǡ����������˥��顼�����ä����ˤ����������ɽ�����������ˤ�true��
  ���ޤ����ǥե���ȤǤ�ɽ�����ޤ���

: @options['weather.dir']
  �ǡ�������¸��ꡣ�ǥե���Ȥϰʲ����̤ꡣ
    "#{@cache_path}/weather/"
  ���β��ˡ�ǯ/ǯ��.weather �Ȥ����ե����뤬����ޤ��������
  @data_path��Ʊ���ˤ���ȡ������Υǡ�����Ʊ���ǥ��쥯�ȥ��ŷ���Υǡ���
  ����¸�Ǥ��뤫�⤷��ޤ���

: @options['weather.items']
  WWW�ڡ����������������ܡ��ǥե���Ȥϡ���������������������
  parse_html�����������̾�򥭡�����Ͽ�������̾���ͤȤ����ϥå���Ǥ���
  www.nws.noaa.gov�Υե����ޥåȤ˹�碌�ơ�¿����ñ�̤���ư�ˤ��Ѥ����
  ��褦�ˤ��Ƥ���ޤ���������ѹ�������ˤϡ�parse_html�᥽�åɤ���
  ������ɬ�פ����뤫�⤷��ޤ���

: @options['weather.header']
  HTTP�ꥯ�����ȥإå����ɲä�����ܤΥϥå���
    @options['weather.header'] = {'Accept-language' => 'ja'}
  �ʤɡ�((-Accept-language�ˤ�äƼ��������������٤륵���Ȥ⤢��ޤ���-))
  �ǥե���ȤǤ��ɲäΥإå����������ޤ���

== ŷ���������ˤĤ���
NWS����Υǡ����ϱѸ�Ǥ��Τǡ�Ŭ�������ܸ��ľ���Ƥ�����Ϥ���褦�ˤ�
�Ƥ���ޤ��������ϡ�WeatherTranslator�⥸�塼��ˤ�äƤ��ơ��Ѵ�ɽ�ϡ�
Weather���饹�ˡ�Words_ja�Ȥ�����������Ȥ���Ϳ���Ƥ���ޤ���

���äϤޤ��ޤ���ʬ�ǤϤʤ��Ȼפ��ޤ����Τ�ʤ�ñ��ϱѸ�Τޤ�ɽ�������
���Τǡ�Words_ja��Ŭ���ɲä��Ƥ���������
((<URL:http://tdiary-users.sourceforge.jp/cgi-bin/wiki.cgi?weather%2Erb>))
�˽񤤤Ƥ����ȡ����Τ������۸����ɲä���뤫�⤷��ޤ���

== �٤�������
ŷ���ǡ����������乥�ߤ˹��ơ��ʲ��Υ᥽�åɤ��ѹ����뤳�Ȥǡ����� 
������꤬�Ǥ��ޤ���

=== ɽ���˴ؤ�����
�ǥե���ȤǤϡ�ŷ���ǡ����ϡ�HTML_START��HTML_END�����ꤵ��Ƥ���ʸ�� 
��ǰϤޤ�ޤ���div��span�Υ��饹���ѹ�������ˤϡ��������ѹ������ 
���ǽ�ʬ�Ǥ�������ʾ���ѹ���ɬ�פʾ��ϰʲ����ѹ����Ƥ���������

: Weather.html_string
  @data[item]�򻲾Ȥ��ơ�ŷ����ɽ������HTML���Ҥ��äƤ���������

: Weather.error_html_string
  �ǡ����������顼�����ä����ˡ�@error�򻲾Ȥ��ƥ��顼��ɽ������HTML��
  �Ҥ��äƤ���������

����ü������α����κݤˤϡ�
  @options['weather.show_mobile'] = true
�ξ��ˤϡ��嵭������ˡ����줾��I_HTML_START��I_HTML_END��
Weather.i_html_string���Ȥ��ޤ������顼��ɽ���ϤǤ��ޤ���

=== ŷ���ǡ����μ����˴ؤ�����
: Weather.parse_html( html, items )
  ((|html|))ʸ�������Ϥ��ơ�((|items|))�ϥå���˽��ä�@data[item]����
  �����Ƥ���������((|items|))�ˤ�@optins['weather.items']�ޤ���
  Weather_default_items����������ޤ����֤��ͤ����Ѥ���ޤ��󡣥ơ��֥� 
  ���Ѥ���ŷ�����󸻤ʤ�С����Υ᥽�åɤ򤢤ޤ��¤���ʤ��ǻȤ��뤫�� 
  ����ޤ���
   
== ���������᥽�åɤΥƥ���
parse_html��html_string�Υƥ��Ȥˤϰʲ��Τ褦����ˡ���Ȥ��뤫�⤷��ޤ� 
��

�ޤ����ǡ�����������������줿HTML��ե��������¸���Ƥ������������줫 
�顢���Υե�����κǸ�Σ��Ԥ򥳥��ȥ����Ȥ���tdiary.rbͳ��Υ᥽�å� 
��Ȥ�ʤ��褦�ˤ��ơ��ʲ��Τ褦�ʥ����ɤ򤳤Υե�����κǸ���ɲä��ƥ�
�ޥ�ɥ饤�󤫤餳�Υե������¹Ԥ��ƤߤƤ���������

* parse_html��ƥ��Ȥ�����
  HTML��ѡ�����������줿�ǡ�����ɽ�����ޤ���
    html = File.open( 'weather_test.html' ) { |f| f.read }
    w = Weather.new
    w.parse_html( html, Weather_default_items )
    w.data.each do |item, value| puts "  #{item} => #{value}" end

* html_string��ƥ��Ȥ�����
  HTML��ѡ�����������줿�ǡ�����HTML�ˤ���ɽ�����ޤ���
    html = File.open( 'weather_test.html' ) { |f| f.read }
    w = Weather.new
    w.parse_html( html, Weather_default_items )
    puts w.html_string

== �ޤ����٤�����
* ŷ���˱��������������ɽ�� -�ɤ��������

== �ռ�
��������ŷ���ץ饰����Υ����ǥ������󶡤��Ƥ������ä�hsbt���󡢼����Υ�
��Ȥ��󶡤��Ƥ������ä�zoe����˴��դ��ޤ����ޤ���NOAA�ξ�����󶡤���
�������ä�kotak����˴��դ��ޤ���

The author appreciates National Weather Service
((<URL:http://weather.noaa.gov/>)) making such valuable data available
in public domain as described in ((<URL:http://www.noaa.gov/wx.html>)).

== Copyright
Copyright 2003 zunda <zunda at freeshell.org>

Permission is granted for use, copying, modification, distribution,
and distribution of modified versions of this work under the terms
of GPL version 2 or later.
=end

=begin ChangeLog
* Mon Jul 21, 2003 zunda <zunda at freeshell.org>
- changed regexp literals from %r|..| to %r[..] for Ruby 1.8.x.
* Fri Jul 17, 2003 zunda <zunda at freeshell.org>
- WWW configuration interface
* Thu Jun  5, 2003 zunda <zunda at freeshell.org>
- checks the age of data
* Tue Jun  3, 2003 zunda <zunda at freeshell.org>
- ignores `... in the vicinity', thank you kosaka-san.
- now tests translations if executed as a stand alone script.
* Mon May 26, 2003 zunda <zunda at freeshell.org>
- fix typo on weaHTer.show_mobile and weHTer.show_error, thank you halchan.
* Thu May  8, 2003 zunda <zunda at freeshell.org>
- A with B, observed,
* Mon May  5, 2003 zunda <zunda at freeshell.org>
- mobile agent
* Fri Mar 28, 2003 zunda <zunda at freeshell.org>
- overcast, Thanks kotak san.
* Fri Mar 21, 2003 zunda <zunda at freeshell.org>
- mist: kiri -> kasumi, Thanks kotak san.
* Sun Mar 16, 2003 zunda <zunda at freeshell.org>
- option weather.tz, appropriate handling of timezone
* Tue Mar 11, 2003 zunda <zunda at freeshell.org>
- records: windchill, winddir with 'direction variable', gusting wind
* Mon Mar 10, 2003 zunda <zunda at freeshell.org>
- WeatherTranslator module
* Sat Mar  8, 2003 zunda <zunda at freeshell.org>
- values with units
* Fri Mar  7, 2003 zunda <zunda at freeshell.org>
- edited to work with NOAA/NWS
* Fri Feb 28, 2003 zunda <zunda at freeshell.org>
- first draft
=end

require 'net/http'
Net::HTTP.version_1_1
require 'nkf'
require 'cgi'
require 'timeout'

=begin
== Classes and methods
=== WeatherTranslator module
We want Japanese displayed in a diary written in Japanese.

--- Weather::Words_ja
    Array of arrays of a Regexp and a Statement to be executed.
    WeatherTranslator::S.tr accepts this kind of hash to translate a
    given string.

--- WeatherTranslator::S < String
    Extension of String class. It translates itself.

--- WeatherTranslator::S.translate( table )
    Translates self according to ((|table|)).
=end

class Weather
	Words_ja = [
		[%r[\A(.*)/(.*)], '"#{S.new( $1 ).translate( table )}/#{S.new( $2 ).translate( table )}"'],
		[%r[\s*\b(greater|more) than (-?[\d.]+\s*\S*)\s*]i, '"#{S.new( $2 ).translate( table )}�ʾ�"'],
		[%r[^(.*?) with (.*)$]i, '"#{S.new( $2 ).translate( table )}�����#{S.new( $1 ).translate( table )}"'],
		[%r[^(.*?) during the past hours?$]i, '"ľ���ޤ�#{S.new( $1 ).translate( table )}"'],
		#[%r[\s*\b([\w\s]+?) in the vicinity]i, '"���դ�#{S.new( $1).translate( table )}"'],
		[%r[\s*\bin the vicinity\b\s*]i, '""'],
		# ... in the vicinity��̵�뤵���褦�ˤʤäƤ��ޤ������줬�ߤ������ϡ�
		# ��Υ����ȥ����Ȥ���Ƥ���ԤΥ����Ȥ򳰤��Ƥ���������
		[%r[\s*\bdirection variable\b\s*]i, '"����"'],
		[%r[\s*(-?[\d.]+)\s*\(?F\)?], '"�ڻ�#{$1}��"'],
		[%r[\s*\bmile(\(?s\)?)?\s*]i, '"�ޥ���"'],
		[%r[\s*\b(mostly |partly )clear\b\s*]i, '"��"'],
		[%r[\s*\bclear\b\s*]i, '"����"'],
		[%r[\s*\b(mostly |partly )?cloudy\b\s*]i, '"��"'],
		[%r[\s*\bovercast\b\s*]i, '"��"'],
		[%r[\s*\blight snow showers?\b\s*]i, '"�ˤ狼��"'],
		[%r[\s*\blight snow\b\s*]i, '"����"'],
		[%r[\s*\blight drizzle\b\s*]i, '"����"'],
		[%r[\s*\blight rain showers?\b\s*]i, '"�夤�ˤ狼��"'],
		[%r[\s*\bshowers?\b\s*]i, '"�ˤ狼��"'],
		[%r[\s*\bdrizzle\b\s*]i, '���̤���"'],
		[%r[\s*\blight rain\b\s*]i, '"̸��"'],
		[%r[\s*\brain\b\s*]i, '"��"'],
		[%r[\s*\bmist\b\s*]i, '"��"'],
		[%r[\s*\bhaze\b\s*]i, '"��"'],
		[%r[\s*\bfog\b\s*]i, '"̸"'],
		[%r[\s*\bsnow\b\s*]i, '"��"'],
		[%r[\s*\bthunder( storm)?\b\s*]i, '"��"'],
		[%r[\s*\bsand\b\s*]i, '"����"'],
		[%r[\s*\bcumulonimbus clouds\b\s*]i, '"�����"'],
		[%r[\s*\bcumulus clouds\b\s*]i, '"�ѱ�"'],
		[%r[\s*\btowering\b\s*]i, '""'],
		[%r[\s*\bobserved\b\s*]i, '""'],
		[%r[\s*\bC\b\s*], '"��"'],
	].freeze
end

module WeatherTranslator
	class S < String
		def translate( table )
			return '' if not self or self.empty?
			table.each do |x|
				if x[0] =~ self then
					return S.new( $` ).translate( table ) + eval( x[1] ) + S.new( $' ).translate( table )
				end
			end
			self
		end
	end
end

=begin
=== Weather class
Weather of a date.

--- Weather( date )
      A Weather is a weather datum for a ((|date|)) (a Time object).

--- Weather.get( url, header, items )
      Gets a WWW page from the ((|url|)) providing HTTP header in the
      ((|header|)) hash. The page is parsed calling Weahter.parse_html.
      Returns self.

--- Weather.parse_html( html, items )
      Parses an HTML page ((|html|)) and stores the data into @data
      according to ((|items|)).

--- Weather.to_s
      Creates a line to be stored into the cache file which will be
      parsed with Weather.parse method. Data are stored with the
      following sequence and separated with a tab:
        date(string), url, acquisition time(UNIX time) timezone, error (or empty string), item, value, ...
      Each record is terminated with a new line.

--- Weather.parse( string )
--- Weather::parse( string )
      Parses the ((|string|)) made by Weather.to_s and returns the
      resulting Weather.

--- Weather::date_to_s( date )
      Returns ((|date|)) formatted as a String used in to_s method. Used
      to find a record for the date from a file.

--- Weather.to_html( show_error = false )
      Returns an HTML fragment for the weather. When show_error is true,
      returns an error message as an HTML fragment in case an error
      occured when getting the weather.

--- Weather.to_i_html
      Returns a CHTML fragment for the weather.

--- Weather.html_string
--- Weather.error_html_string
      Returns an HTML fragment showing data or error, called from
      Weather.to_html.

--- Weather.i_html_string
      Returns a CHTML fragment to be shown on a mobile browser.
=end
class Weather
	attr_reader :date, :time, :url, :error, :data, :tz

	# magic numbers
	HTML_START = '<div class="weather"><span class="weather">'
	HTML_END = '</span></div>'
	I_HTML_START = '<P>'
	I_HTML_END = '</P>'
	WAITTIME = 10
	MAXREDIRECT = 10

	def error_html_string
		%Q|#{HTML_START}��ŷ�����顼:<a href="#{@url}">#{CGI::escapeHTML( @error )}</a>#{HTML_END}|
	end

	# edit this method to define how you show the weather
	def html_string
		r = "#{HTML_START}"

		# time stamp
		if @tz then
			tzbak = ENV['TZ']
			ENV['TZ'] = @tz	# this is not thread safe...
		end
		if @data['timestamp'] then
			r << Time::at( @data['timestamp'].to_i ).strftime( '%H:%M' ).sub( /^0/, '' )
		else
			r << Time::at( @time.to_i ).strftime( '%H:%M' ).sub( /^0/, '' )
		end
		r << '����'
		if @tz then
			ENV['TZ'] = tzbak
		end

		# weather
		r << %Q|<a href="#{@url}">|
		if @data['weather'] then
			r << CGI::escapeHTML( WeatherTranslator::S.new( @data['weather']).translate( Words_ja ))
		elsif @data['condition'] then
			r << CGI::escapeHTML( WeatherTranslator::S.new( @data['condition']).translate( Words_ja ))
		end

		# temperature
		if @data['temperature(C)'] and t = @data['temperature(C)'].scan(/-?[\d.]+/)[-1] then
			r << %Q| #{sprintf( '%.0f', t )}��|
		end

		r << "</a>#{HTML_END}\n"
	end


	# edit this method to define how you show the weather for a mobile agent
	def i_html_string
		r = ''

		# weather
		if @data['weather'] then
			r << "#{I_HTML_START}"
			r << %Q|<A HREF="#{@url}">|
			r << CGI::escapeHTML( WeatherTranslator::S.new( @data['weather']).translate( Words_ja ))
			r << "</A>#{I_HTML_END}\n"
		elsif @data['condition'] then
			r << "#{I_HTML_START}"
			r << %Q|<A HREF="#{@url}">|
			r << CGI::escapeHTML( WeatherTranslator::S.new( @data['condition']).translate( Words_ja ))
			r << "</A>#{I_HTML_END}\n"
		end

	end

	# edit this method according to the HTML we will get
	def parse_html( html, items )
		htmlitems = Hash.new

		# weather data is in the 4th table in the HTML from weather.noaa.gov
		table = html.scan( %r[<table.*?>(.*?)</table>]mi )[3][0]
		table.scan( %r[<tr.*?>(.*?)</tr>]mi ).collect {|a| a[0]}.each do |row|
			# <tr><td> *item* -> downcased </td><td> *value* </td></tr>
			if %r[<td.*?>(.*?)</td>\s*<td.*?>(.*?)</td>]mi =~ row then
				item = $1
				value = $2
				item = item.gsub( /<br>/i, '/' ).gsub( /<.*?>/m , '').strip.downcase
				value = value.gsub( /<br>/i, '/' ).gsub( /<.*?>/m , '').strip

				# unit conversion settings
				units = []
				case item
				when 'conditions at'
					# we have to convert the UTC time into UNIX time
					if /(\d{4}).(\d\d).(\d\d)\s*(\d\d)(\d\d)\s*UTC$/ =~ value then
						value = Time::utc( $1, $2, $3, $4, $5 ).to_i.to_s
					else
						raise StandardError, 'Parse error in "Conditions at"'
					end
				when 'visibility' # we want to preserve adjective phrase if possible
					if /(.*)([\d.]+)\s*mile(\(s\))?/i =~ value then
						htmlitems["#{item}(km)"] = sprintf( '%s %.3f', $1.strip, $2.to_f * 1.610 )
						htmlitems["#{item}(mile)"] = sprintf( '%s %s', $1.strip, $2 )
					end
				when 'wind' # we want to preserve adjective phrase if possible
					speed = value.scan( /([\d.]+)\s*MPH/i ).collect { |x| x[0] }
					htmlitems["#{item}(MPH)"] = speed.join(',')
					htmlitems["#{item}(m/s)"] = speed.collect {|s| sprintf( '%.4f', s.to_f * 0.4472222 ) }.join(',')
					if /([\d.]+)\s*degrees?/i =~ value then
						htmlitems["#{item}(deg)"] = $1
					end
					if /from\s+(the\s+)?(\w+)/i =~ value then
						htmlitems["#{item}dir"] = $2 + ($3 ? " #{$3}" : '')
					end
					if /(\(direction variable\))/i =~ value then
						htmlitems["#{item}dir"] << " #{$1}"
					end
				# just have to parse the value with the units
				when 'temperature'
					units = ['C', 'F']
				when 'windchill'
					units = ['C', 'F']
				when 'dew point'
					units = ['C', 'F']
				when 'relative humidity'
					units = ['%']
				when 'pressure (altimeter)'
					units = ['hPa']
				end

				# parse the value with the units if preferred and possible
				units.each do |unit|
					if /(-?[\d.]+)\s*\(?#{unit}\b/i =~ value then
						htmlitems["#{item}(#{unit})"] = $1
					end
				end

				# record the value as read from the HTML
				htmlitems[item] = value

			end	# if %r[<td.*?>(.*?)</td>\s*<td.*?>(.*?)</td>]mi =~ row
		end	# table.scan( %r[<tr.*?>(.*?)</tr>]mi ) ... do |row|

		# translate the parsed HTML into the Weather hash with more generic key
		items.each do |from, to|
			if htmlitems[from] then
				# as specified in items
				@data[to] = htmlitems[from]
			elsif f = from.dup.sub!( /\([^)]+\)$/, '' ) \
					and htmlitems[f] \
					and t = to.dup.sub!( /\([^)]+\)$/, '' ) then
				# remove the units and try again if not found
				@data[t] = htmlitems[f]
			end
		end
		@time = Time::now
	end

	# check age of data
	def check_age( oldest_sec = nil )
		if oldest_sec and @time and @data['timestamp'] and @data['timestamp'].to_i + oldest_sec < @time.to_i then
			@error = 'data too old'
		end
	end

	def initialize( date = nil, tz = nil )
		@date = date or Time.now
		@data = Hash.new
		@error = nil
		@url = nil
		if tz and not tz.empty? then
			@tz = tz
		elsif ENV['TZ']
			@tz = ENV['TZ']
		else
			@tz = nil
		end
	end

	def get( url, header = nil, items = {} )
		@url = url.gsub(/[\t\n]/, '')
		@error = nil
		@url =~ %r<http://([^/]+)(.*)>
		host = $1
		path = $2
		redirect = 0
		begin
			timeout( WAITTIME ) do
				begin
					d = ''
					Net::HTTP.start( host, 80 ) do |http|
						response , = http.get( path, header)
						d = NKF::nkf( '-e', response.body )
					end
					parse_html( d, items )
				rescue Net::ProtoRetriableError => err
					if m = %r<http://([^/]+)>.match( err.response['location'] ) then
						host = m[1].strip
						path = m.post_match
						redirect += 1
						retry if redirect < MAXREDIRECT
						raise StandardError, 'Too many redirections'
					end
					raise StandardError, 'Error in redirection'
				end
			end
		rescue TimeoutError
			@error = 'Timeout'
		rescue
			@error = NKF::nkf( '-e', $!.message.gsub( /[\t\n]/, ' ' ) )
		end
		self
	end

	def to_s
		tzstr = @tz ? " #{tz}" : ''
		r = "#{Weather::date_to_s( @date )}\t#{@url}\t#{@time.to_i}#{tzstr}\t#{@error}"
		@data.each do |item, value|
			r << "\t#{item}\t#{value}" if value and not value.empty?
		end
		r << "\n"
	end

	def parse( string )
		i = string.chomp.split( /\t/ )
		y, m, d = i.shift.scan( /^(\d{4})(\d\d)(\d\d)$/ )[0]
		@date = Time::local( y, m, d )
		@url = i.shift
		itime, @tz = i.shift.split( / +/, 2 )
		@time = Time::at( itime.to_i )
		error = i.shift
		if error and not error.empty? then
			@error = error
		else
			@error = nil
		end
		@data.clear
		while not i.empty? do
			@data[i.shift] = i.shift
		end
		self
	end

	def to_html( show_error = false )
		@error ? (show_error ? error_html_string : '') : html_string
	end

	def to_i_html
		@error ? '' : i_html_string
	end

	def store( path, date )
		ddir = File.dirname( Weather::file_path( path, date ) )
		# mkdir_p logic copied from fileutils.rb
		# Copyright (c) 2000,2001 Minero Aoki <aamine@loveruby.net>
		# and edited (zunda.freeshell.org does not have fileutils.rb T_T
		dirstack = []
		until FileTest.directory?( ddir ) do
			dirstack.push( ddir )
			ddir = File.dirname( ddir )
		end
		dirstack.reverse_each do |dir|
			Dir.mkdir dir
		end
		# finally we can write a file
		File::open( Weather::file_path( path, date ), 'a' ) do |fh|
			fh.puts( to_s )
		end
	end

	class << self
		def parse( string )
			new.parse( string )
		end

		def date_to_s( date )
			date.strftime( '%Y%m%d' )
		end

		def file_path( path, date )
			date.strftime( "#{path}/%Y/%Y%m.weather" ).gsub( /\/\/+/, '/' )
		end

		def restore( path, date )
			r = nil
			datestring = Weather::date_to_s( date )
			begin
				File::open( file_path( path, date ), 'r' ) do |fh|
					fh.each( "\n" ) do |l|
						if /^#{datestring}\t/ =~ l then
							r = l # will use the last/newest data found in the file
						end
					end
				end
			rescue Errno::ENOENT
			end
			r ? Weather::parse( r ) : nil
		end

	end
end

=begin
=== Methods as a plugin
weather method also can be used as a usual plug-in in your diary body.
Please note that the argument is not a String but a Time object.

--- weather( date = nil )
      Returns an HTML flagment of the weather for the date. This will be
      provoked as a body_enter_proc. @date is used when ((|date|)) is
      nil.

--- get_weather
      Access the URL to get the current weather information when:
      * @mode is append or replace,
      * @date is today, and
      * There is no cached data without an error for today
      This will be provoked as an update_proc.
=end

Weather_default_path = "#{@cache_path}/weather"
Weather_default_items = {
	# UNIX time
	'conditions at'             => 'timestamp',
	# English phrases
	'sky conditions'            => 'condition',
	'weather'                   => 'weather',
	# Direction (e.g. SE)
	'winddir'                   => 'winddir',
	# English phrases when unit conversion failed, otherwise, key with (unit)
	'wind(m/s)'                 => 'wind(m/s)',
	'wind(deg)'                 => 'wind(deg)',
	'visibility(km)'            => 'visibility(km)',
	'temperature(C)'            => 'temperature(C)',
	'windchill(C)'              => 'windchill(C)',
	'dew point(C)'              => 'dewpoint(C)',
	'relative humidity(%)'      => 'humidity(%)',
	'pressure (altimeter)(hPa)' => 'pressure(hPa)',
}

# shows weather
def weather( date = nil )
	path = @options['weather.dir'] || Weather_default_path
	w = Weather::restore( path, date || @date )
	if w then
		unless @cgi.mobile_agent? then
			w.to_html( @options['weather.show_error'] )
		else
			w.to_i_html if @options['weather.show_mobile']
		end
	else
		''
	end
end

# gets weather when the diary is updated
def get_weather
	return unless @options['weather.url']
	return unless @mode == 'append' or @mode == 'replace'
	return unless @date.strftime( '%Y%m%d' ) == Time::now.strftime( '%Y%m%d' )
	path = @options['weather.dir'] || Weather_default_path
	w = Weather::restore( path, @date )
	if not w or w.error then
		items = @options['weather.items'] || Weather_default_items
		w = Weather.new( @date, @options['weather.tz'] )
		w.get( @options['weather.url'], @options['weather.header'], items )
		if @options.has_key?( 'weather.oldest' ) then
			oldest = @options['weather.oldest']
		else
			oldest = 21600
		end
		w.check_age( oldest )
		w.store( path, @date )
	end
end

# www configuration interface
def configure_weather
	if( @mode == 'saveconf' ) then
		# weather.url
		@conf['weather.url'] = @cgi.params['weather.url'][0]
		# weather.tz
		tz = @cgi.params['weather.tz'][0]
		unless tz.empty? then	# need more checks
			@conf['weather.tz'] = tz
		else
			@conf['weather.tz'] = ''
		end
		# weather.show_mobile
STDERR.puts @cgi.params['weather.show_mobile'][0]
		case @cgi.params['weather.show_mobile'][0]
		when 'true'
			@conf['weather.show_mobile'] = true
		when 'false'
			@conf['weather.show_mobile'] = false
		end
	end
	case @conf.lang
	when 'en'
		<<-HTML
		<h3 class="subtitle">Today's weather plugin</h3>
		<p>I am sorry. English page is not yet ready.</p>
		HTML
	else
		<<-HTML
		<h3 class="subtitle">��������ŷ���ץ饰����</h3>
		<p>��������ŷ���򡢤�������������ǽ�˹���������˼���������¸����
			���줾������������ξ�����ɽ�����ޤ���</p>
		<h4>ŷ���ǡ���</h4>
		<p>��������ŷ�����㤨��NOAA National Weather Service�����Ѥ�����ˤϡ�
			<a href="http://weather.noaa.gov/">NOAA National Weather Service</a>
			���顢Select a country...�ǹ�̾�������Go!�ܥ���򲡤���
			���˴�¬����������Ǥ���������
			�����ơ����λ�ɽ�����줿�ڡ�����URL�򡢰ʲ��˵������Ƥ���������</p>
		<p><input name="weather.url" value="#{@conf['weather.url']}" size="60"></p>
		<p>���������Υ����ॾ�����Ѳ������ǽ�����������ϡ�
			���Υ����ॾ�����Ͽ���Ƥ������Ȥ򤪴��ᤷ�ޤ���
			����ˤ�äơ����������ۤ�����⡢
			ŷ���ǡ����������Υ����ॾ�����ŷ����ɽ����³���뤳�Ȥ��Ǥ��ޤ���</p>
		<p>�����ॾ�����Ͽ����ˤϡ��㤨������ɸ����ξ��ˤϡ�
			tdiary.rb��Ʊ���ǥ��쥯�ȥ�ˤ���tdiary.conf�ˡ�
			ENV['TZ'] = 'Japan'�ʤɤȽ�­������
			�ʲ��ˡ�Japan�ȵ������Ƥ���������</p>
		<p><input name="weather.tz" value="#{@conf['weather.tz']}"></p>
		<h4>�������äؤ�ɽ��</h4>
		<p>������������Ǥ���������</p>
		<p><select name="weather.show_mobile">
			<option value="true"#{' selected'if @conf['weather.show_mobile']}>
			�������äˤ⺣����ŷ����ɽ������
			<option value="false"#{' selected'unless @conf['weather.show_mobile']}>
			�������äˤϺ�����ŷ����ɽ�����ʤ�
		</select></p>
		<h4>����¾������</h4>
		<p>����¾�ˤ⤤���Ĥ�tdiary.conf��������Ǥ�����ܤ�����ޤ���
			�ܤ����ϡ��ץ饰����Υե�����(weather.rb)��������������</p>
		HTML
	end
end
unless __FILE__ == $0 then
# register to tDiary if executed as a plugin
	add_body_enter_proc do |date| weather( date ) end
	add_update_proc do get_weather end
	add_conf_proc( 'weather', '��������ŷ��' ) do configure_weather end
else
# translation test cases
	[
		'Thunder, Showers in the vicinity',
		'Thunder and Showers in the vicinity',
	].each do |orig|
		puts "#{orig} -> #{WeatherTranslator::S.new( orig ).translate( Weather::Words_ja )}"
	end
end
