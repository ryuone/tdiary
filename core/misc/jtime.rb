#
# ��%J�פ����ܸ������̾��Ф�Time���饹��¤��
# tdiary.conf���require���ƻȤ�
#
class Time
   alias strftime_ strftime
   JWDAY = %w(�� �� �� �� �� �� ��)
   def strftime( format )
      strftime_( format.gsub( '%J', JWDAY[self.wday] ) )
   end
end

