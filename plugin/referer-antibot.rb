# referer-antibot.rb $Revision: 1.1 $
#
# �������󥸥�ν��BOT�ˤϡ������Υ�󥯸��פ򸫤��ʤ��褦�ˤ���
# ����ˤ�ꡢ̵�ط��ʸ�����ǥ�����������뤳�Ȥ�����(��ͽ�ۤ����)
# plugin�ǥ��쥯�ȥ������������ư���
#
# ���ץ����:
#   @options['disp_referrer.deny_user_agents']
#      �������åȤˤ�����BOT��user agent���ɲä�������
#      ���Υ��ץ�����disp_referrer�ץ饰����ȶ��̡�
#      ̵�������["googlebot", "Hatena Antenna", "moget@goo.ne.jp"]�Τߡ�
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

# deny user agents
deny_user_agents = ["googlebot", "Hatena Antenna", "moget@goo.ne.jp"]
deny_user_agents += @options['disp_referrer.deny_user_agents'] || []
@referer_antibots = Regexp::new( "(#{deny_user_agents.join( '|' )})" )

def referer_antibot?
	@referer_antibots =~ @cgi.user_agent
end

# short referer
alias referer_of_today_short_antibot_backup referer_of_today_short
def referer_of_today_short( diary, limit )
	return '' if referer_antibot?
	referer_of_today_short_antibot_backup( diary, limit )
end

# long referer
alias referer_of_today_long_antibot_backup referer_of_today_long
def referer_of_today_long( diary, limit )
	return '' if referer_antibot?
	referer_of_today_long_antibot_backup( diary, limit )
end
