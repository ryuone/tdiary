# makelirs.rb $Revision: 1.3 $
#
# ���������LIRS�ե����ޥåȤΥե�������Ǥ��Ф�
#
#   plugin�ǥ��쥯�ȥ���֤�������ư��ޤ���
#
#   �����ФΥݡ��Ȥ�80�ְʳ��Ǥ��ä��ꡤSSL���Ѥ��ƥ��������������
#   tdiary.conf �� @options['makelirs.url'] �����ꤷ�Ƥ���������
#   ���
#   @options['makelirs.url'] = 'https://example.net:8080/diary/'
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
2002-10-28 zoe <zoe@kasumi.sakura.ne.jp>
	* merge 1.4. Thanks koyasu san.

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

	host = ENV['HTTP_HOST']
	path = ENV['REQUEST_URI']
	path = path[0..path.rindex("/")]
	url =  @options['makelirs.url'] || "http://#{host}#{path}"

	lirs = "LIRS,#{t.last_modified.tv_sec},#{Time.now.tv_sec},0,#{body.size},#{e[url]},#{e[@html_title]},#{e[@author_name]},,\n"
	File::open( file, 'w' ) do |o|
		o.puts lirs
	end
end
