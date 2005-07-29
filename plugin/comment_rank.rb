# comment_rank.rb $Revision: 1.5 $
#
# comment_rank: �ĥå��ߤο��ǥ�󥭥�
#   �ѥ�᥿:
#     max:  ����ɽ����(̤�����:5)
#     sep:  ���ѥ졼��(̤�����:����)
#     except:        ̵�뤹��̾��(�����Ĥ⤢�����,�Ƕ��ڤä��¤٤�)
#
# Copyright (c) 2002 TADA Tadashi <sho@spc.gr.jp>
# You can distribute this file under the GPL2.
#
#
def comment_rank( max = 5, sep = '&nbsp;', *except )
	name = Hash::new(0)
	@diaries.each_value do |diary|
		diary.each_comment( 100 ) do |comment|
			next if except.include?(comment.name)
			name[comment.name] += 1
		end
	end
	result = []
	name.sort{|a,b| (a[1])<=>(b[1])}.reverse.each_with_index do |ary,idx|
		break if idx >= max
		result << "<strong>#{idx+1}.</strong>#{CGI::escapeHTML( ary[0].to_s )}(#{ary[1].to_s})"
	end
	result.join( sep )
end

