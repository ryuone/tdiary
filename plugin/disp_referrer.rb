# disp_referrer.rb
# -pv-
#
# ̾�Ρ�
# �����Υ�󥯸������ץ饰����
#
# ���ס�
# ʸ���������Ƥ��ޤäƤ��������Υ�󥯸���ľ���ޤ���
# Google�ϸ������󥸥�AOL��alltheweb�����UTF-8ʸ����
# UTF-8���λ��Ȥ��Ѵ����б����Ƥ��ޤ���
#
# �Ȥ�����
# Uconv�⥸�塼���index.rb��Ʊ���ǥ��쥯�ȥ�˥��󥹥ȡ���
# ����ɬ�פ�����ޤ���
# http://www.ruby-lang.org/en/raa-list.rhtml?name=Uconv
#
# �ܤ����ϡ�
# http://home2.highway.ne.jp/mutoh/tools/ruby/ja/disp_referrer.html
# �򻲾Ȥ��Ƥ���������
# 
#
# ���¡�
# EUC-JP��ɽ���Ǥ��ʤ�ʸ����ɽ���Ǥ��ޤ���
#
# ����ˤĤ��ơ�
# Copyright (C) 2002 MUTOH Masao <mutoh@highway.ne.jp>
# You can redistribute it and/or modify it under GPL2.
#
=begin ChangeLog
2002-07-30 MUTOH Masao  <mutoh@highway.ne.jp>
	* �������ɲ�

2002-07-24 MUTOH Masao  <mutoh@highway.ne.jp>
   * alltheweb�б�
   * jp.aol.com, aol.com�б�
   * ʸ�����Ѵ��ν�����ѹ�
   * version 1.1.0

2002-07-20 MUTOH Masao  <mutoh@highway.ne.jp>
   * version 1.0.0
=end

require 'uconv'

eval(<<TOPLEVEL_CLASS, TOPLEVEL_BINDING)
def Uconv.unknown_unicode_handler(unicode)
   if unicode == 0xff5e
      "��"
   else
      "?"
   end
end

class Diary
   def disp_referer( table, ref )
      ref = CGI::unescape( ref )
      if /((e|cs)=utf-?8|jp.aol.com)/i =~ ref
         begin
            ref = Uconv.u8toeuc(ref)
         rescue Uconv::Error
         end
      elsif /&#[0-9]+/ =~ ref
         ref.gsub!(/&#([0-9]+);/){|v|
            Uconv.u8toeuc([$1.to_i].pack("U"))
         }
      elsif NKF.guess(ref) == NKF::SJIS
         ref = ref.to_euc
      end
      str = nil
      table.each do |url, name|
         regexp = Regexp.new(url, Regexp::IGNORECASE)
         if regexp =~ ref then
            str = ref.gsub(regexp, name)
            break
         end
      end
      str ? str : ref
   end   
end
TOPLEVEL_CLASS
