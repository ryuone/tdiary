=begin
= Meta-scheme plugin((-$Id: referer_scheme.rb,v 1.1 2003-12-16 17:26:58 zunda Exp $-))
Makes it easier to edit the referer table.

Currently, doesn't work with at least ruby 1.6.7 (2002-03-01).

== Usage
Enable this plug-in by coping into the plugin directory or selecting
from the plug-in selection plug-in.

Then, edit the `Rule of conversion URL to words' in `Today's Link' of
`Preference'. Add prefixes (meta-scheme) like `tdiary:'.

This adds the date of the diaries or blogs according to their URLs.

For example, set the `Rule' as
* tdiary:http://tdiary.tdiary.net/ tDiary.net management journal.
For this example, date is added with a (YYYY-MM-DD) format if the
information is contained in the URL.

== Notes
For URLs with tdiary:,
* Do not use parenthesis `(' and `)'
* End the URL with a '/'

== How to make a meta-scheme
Meta-schems are extracted from the user's Rule with a Regexp: /^(\w+):/.
Define singleton methods of @conf.referer_table as iterators:
  def scheme_<scheme>( url, name, block )
    :
    block.call( url_variants, name_variants )
    :
  end
The singleton methods are called according to the user's Rule with the
`<scheme>:' part omitted in the url.

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

	def scheme_tdiary( url, name, block )
		TdiaryDates.each do |a|
			block.call( url + a[0], name + a[1] )
		end
		block.call( url, name )
	end

end
