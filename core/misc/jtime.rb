#
# ��%J�פ����ܸ������̾��Ф�Time���饹��¤��
# tdiary.conf���require���ƻȤ�
#
# ��: require 'jtime'
#
# �Ķ��ˤ�äƤ�jtime.rb���֤��������־�礢�ꡣ
# /usr/local/lib/ruby/site_ruby(�ʤ�)�������ȵȡ�
#
class Time
   alias strftime_ strftime
   JWDAY = %w(�� �� �� �� �� �� ��)
   def strftime( format )
      strftime_( format.gsub( /%J/, JWDAY[self.wday] ) )
   end
end

