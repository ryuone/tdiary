# speed_comment.rb $Revision: 1.1 $
#
# spped_comment: �ǿ�������ɽ�����˴ʰפʥĥå��ߥե������ɽ������
#                plugin�ǥ��쥯�ȥ������������ư���ޤ���
#
# Copyright (c) 2002 TADA Tadashi <sho@spc.gr.jp>
# Distributed under the GPL
#
add_body_leave_proc( Proc::new do |date|
	if /latest|month/ =~ @mode then
		<<-FORM
			<div class="form"><form method="post" action="#{@index}"><p>
			<input type="hidden" name="date" value="#{date.strftime( '%Y%m%d' )}">
			<input type="hidden" name="mail" value="">
			#{comment_name_label}: <input class="field" name="name" value="">
			#{comment_body_label}: <input class="field" name="body" size="40">
			<input type="submit" name="comment" value="#{comment_submit_label}">
			</p></form></div>
		FORM
	else
		''
	end
end )

