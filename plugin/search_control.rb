=begin
= �������������ץ饰����((-$Id: search_control.rb,v 1.1 2003-08-26 06:46:22 zunda Exp $-))
Please see below for an English description.

== ����
����ɽ�����ǿ�ɽ���ʤɤ��줾��ˤĤ���Google�ʤɤθ������󥸥�˥���ǥ�
�������Ƥ�餦���ɤ��������椷�ޤ���

== �Ȥ���
���Υץ饰�����plugin/�ǥ��쥯�ȥ�����֤��Ƥ���������

������̤���֤������������פ򥯥�å����뤳�Ȥǡ��ɤ�ɽ���⡼�ɤǤɤΤ�
����ư�����Ԥ��뤫���ꤹ�뤳�Ȥ��Ǥ��ޤ����ǥե���ȤǤϡ�����ʬ��ɽ��
�Τߡ��������󥸥����Ͽ�����褦�ˤʤäƤ��ޤ���

�ºݤ˸��̤����뤫�ɤ����ϡ��������󥸥�Υ�ܥåȤ��᥿�������ᤷ�� 
����뤫�ɤ����ˤ����äƤ��ޤ���

secure==true�������Ǥ�Ȥ��ޤ���

= Search control plugin
== Abstract
Control whether or not to be indexed by external search engines, such as
Google, depending upon one-day view, latest view, etc.

== Usage
Put this file into the plugin/ directory. 

To set up, click `Search control' in the configuration view. You can
choose if you want crawlers from external search engines to index your
one-day view, latest view, etc. The default is to ask the crawlers to
only index one-day view.

To this plugin to take effect, we have to wish that the crawlers regards
the meta-tag.

This plugin also works in a diary with @secure = true.

== ����ˤĤ��� (Copyright notice)
Copyright (C) 2003 zunda <zunda at freeshell.org>

Permission is granted for use, copying, modification, distribution, and
distribution of modified versions of this work under the terms of GPL
version 2 or later.

You should be able to download the latest version from
((<URL:http://zunda.freeshell.org/d/plugin/search_control.rb>)).
=end

=begin ChangeLog
* Aug 26, 2003 zunda <zunda at freeshell.org>
- no nofollow
- English translation
=end ChangeLog

# index or follow
Search_control_categories = [ 'index' ]

# [0]:index
Search_control_defaults = {
	'latest' => ['f'],
	'day' => ['t'],
	'month' => ['f'],
	'nyear' => ['f'],
	'category' => ['f'],
}

# to be used for @options and in the HTML form
Search_control_prefix = 'search_control'

# defaults
Search_control_categories.each_index do |c|
	Search_control_defaults.each_key do |view|
		cat = Search_control_categories[c]
		key = "#{Search_control_prefix}.#{view}.#{cat}"
		unless @conf[key] then
			@conf[key] = Search_control_defaults[view][c]
		end
	end
end

# configuration
add_conf_proc( Search_control_prefix,
	case @conf.lang
	when 'en'
		'Search control'
	else
		'������������'
	end
) do

	# receive the configurations from the form
	if 'saveconf' == @mode then
		Search_control_categories.each do |cat|
			Search_control_defaults.each_key do |view|
				key = "#{Search_control_prefix}.#{view}.#{cat}"
				if 't' == @cgi.params[key][0] then
					@conf[key] = 't'
				else
					@conf[key] = 'f'
				end
			end
		end
	end

	# show the HTML
	case @conf.lang
	when 'en'
		r = <<-_HTML
		<h3 class="subtitle">Search control plugin</h3>
		<p>Ask the crawlers from external search engines not to index
			unwanted pages.</p>
		<p>$Revision: 1.1 $</p>
		<table>
		<tr>
			<th>View
			<th>Check to be indexed
		</tr>
		_HTML
		[
			[ 'Latest', 'latest' ], [ 'One-day', 'day' ], [ 'One-month', 'month' ],
			[ 'Same-day', 'nyear' ], [ 'Category', 'category' ]
		].each do |a|
			label = a[0]
			key = "#{Search_control_prefix}.#{a[1]}"
			r << <<-_HTML
				<tr>
					<th>#{label}
					<td><input name="#{key}.index" value="t" type="checkbox"#{'t' == @conf["#{key}.index"] ? ' checked' : ''}>
				</tr>
			_HTML
		end
		r << "\t\t</table>\n"
	else
		r = <<-_HTML
		<h3 class="subtitle">�������������ץ饰����</h3>
		<p>�������󥸥�Υ�ܥåȤˡ�
			;ʬ�ʥڡ����Υ���ǥå�������ʤ��褦�ˤ��ꤤ���Ƥߤޤ���</p>
		<p>$Revision: 1.1 $</p>
		<table>
		<tr>
			<th>������ɽ��
			<th>����ǥå������äƤ�餦
		</tr>
		_HTML
		[
			[ '�ǿ�', 'latest' ], [ '����ʬ', 'day' ], [ '���ʬ', 'month' ],
			[ 'Ĺǯ', 'nyear' ], [ '���ƥ��꡼', 'category' ]
		].each do |a|
			label = a[0]
			key = "#{Search_control_prefix}.#{a[1]}"
			r << <<-_HTML
				<tr>
					<th>#{label}
					<td><input name="#{key}.index" value="t" type="checkbox"#{'t' == @conf["#{key}.index"] ? ' checked' : ''}>
				</tr>
			_HTML
		end
		r << "\t\t</table>\n"
	end
	r

end

add_header_proc do
	# modes
	if /^(latest|day|month|nyear)$/ =~ @mode then
		key = "#{Search_control_prefix}.#{@mode}"
	elsif /^category/ =~ @mode then
		key = "#{Search_control_prefix}.category"
	else
		key = nil
	end

	# output
	if key then
		%Q|\t<meta name="robots" content="#{'f' == @conf["#{key}.index"] ? 'noindex' : 'index' },follow">\n|
	else
		''
	end
end
