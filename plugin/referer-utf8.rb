# referer-utf8.rb $Revision: 1.2 $
#
# FOR JAPANESE MODE ONLY
#
# ��󥯸��˴ޤޤ��UTF-8��ʸ�������ܸ�Ȥߤʤ���Ŭ�����Ѵ�����
# plugin�ǥ��쥯�ȥ������������ư���
#
# �ʤ���disp_referrer.rb�ץ饰����ˤ�Ʊ���ε�ǽ���ޤޤ�Ƥ���Τǡ�
# disp_referrer��Ƴ���Ѥߤξ��ˤ������ɬ�פϤʤ�
#
# Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# Modified by TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#
=begin ChangeLog
2003-09-24 TADA Tadashi <sho@spc.gr.jp>
	* support tDiary i18n framework.

2003-03-28 TADA Tadashi <sho@spc.gr.jp>
	* modify disp_referer.rb.
=end

if @conf.lang == 'ja'
	require 'uconv'
	require 'nkf'

	eval( <<-TOPLEVEL_CLASS, TOPLEVEL_BINDING )
		def Uconv.unknown_unicode_handler( unicode )
			if unicode == 0xff5e
				"��"
			else
				raise Uconv::Error
			end
		end
	TOPLEVEL_CLASS

	def @conf.to_native( str )
		reg_char_utf8 = /&#[0-9]+;/
		if reg_char_utf8 =~ str then
			str.gsub!( reg_char_utf8 ) do |v|
				Uconv.u8toeuc( [$1.to_i].pack( "U" ) )
			end
		else
			begin
				str = Uconv.u8toeuc( str )
			rescue Uconv::Error
				str = NKF::nkf( '-m0 -e', str )
			end
		end
		str
	end
end

