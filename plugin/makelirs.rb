# makelirs.rb $Revision: 1.2 $
#
# ���������LIRS�ե����ޥåȤΥե�������Ǥ��Ф�
#
#   plugin�ǥ��쥯�ȥ���֤�������ư��ޤ���
#
#   tdiary.conf�ˤ����ơ�@options['makelirs.file']��
#   �ե�����̾����ꤹ��ȡ����Υե������������
#   LIRS�ե�����Ȥ��ޤ���̵������ˤ�index.rb��Ʊ��
#   �ѥ���antenna.lirs�Ȥ����ե�����ˤʤ�ޤ���
#   ������⡢Web�����Ф���񤭹���븢�¤�ɬ�פǤ���
#
# Copyright (C) 2002 by Kazuhiro NISHIYAMA
#
=begin ChangeLog
2002-10-06 TADA Tadashi <http://sho.tdiary.net/>
	* for tDiary 1.5.0.20021003.

2002-05-05 TADA Tadashi <http://sho.tdiary.net/>
	* support @options.

2002-05-04 Kazuhiro NISHIYAMA <zn@mbf.nifty.com>
	* create.
=end

add_update_proc do
	file = @options['makelirs.file'] || 'antenna.lirs'

	# create_lirs
	t = TDiaryLatest::new( @cgi, "latest.rhtml", @conf )
	body = t.eval_rhtml
	# escape comma
	e = proc{|str| str.gsub(/[,\\]/) { "\\#{$&}" } }
	lirs = "LIRS,#{t.last_modified.tv_sec},#{Time.now.tv_sec},0,#{body.size},#{e[@index_page]},#{e[@html_title]},#{e[@author_name]},,\n"
	File::open( file, 'w' ) do |o|
		o.puts lirs
	end
end

