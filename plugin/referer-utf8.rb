# referer-utf8.rb $Revision: 1.1 $
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
2003-03-28 TADA Tadashi <sho@spc.gr.jp>
	* modify disp_referer.rb.
=end

require 'uconv'
require 'nkf'

eval( <<TOPLEVEL_CLASS, TOPLEVEL_BINDING )
	def Uconv.unknown_unicode_handler( unicode )
		if unicode == 0xff5e
			"��"
		else
			raise Uconv::Error
		end
	end

	module TDiary
		module DiaryBase
			@reg_char_utf8 = /&#[0-9]+;/
			def referers
				newer_referer
				@referers
			end
	
			def disp_referer( table, ref )
				ret = CGI::unescape( ref )
				if @reg_char_utf8 =~ ref
					ret.gsub!( @reg_char_utf8 ) do |v|
						Uconv.u8toeuc( [$1.to_i].pack( "U" ) )
					end
				else
					begin
						ret = Uconv.u8toeuc( ret )
					rescue Uconv::Error
						ret = NKF::nkf( '-e', ret )
					end
				end
				
				table.each do |url, name|
					regexp = Regexp.new( url, Regexp::IGNORECASE )
					break if ret.gsub!( regexp, name )
				end
				ret
			end
		end
	end
TOPLEVEL_CLASS

