# output_rdf: RDF�ե���������plugin ���ܸ�꥽����
#
# ����
#
# 1. output_rdf.rb
# 2. uconv <http://www.yoshidam.net/Ruby.html#uconv>
#    uconv�����Ĥ���ʤ�����EUC-JP��RDF���Ǥ��Ф��ޤ�
#
# Ĵ��ˡ
#
# 1.
#  index.rb �Τ���ǥ��쥯�ȥ��web�����С�����񤭹��ߤǤ���褦�ˤ��뤫
#  index.rb �Τ���ǥ��쥯�ȥ�� index.rdf �Ȥ����ե������web�����С�����
#  �񤭹��ߤ��Ǥ���ѡ��ߥå����Ǻ������Ƥ�������
#
#  �ʤ���index.rdf�ϡ�@options['output_rdf.file']�ˤ�äƥե�����̾����
#  ����ǽ�Ǥ����ޤ���@options['output_rdf.image']�ˤ�äƥ��᡼����URL��
#  ����Ǥ��ޤ���
#
# 2.
#  �ץ饰�������򤫤�out_put.rb�����򤹤뤫��plugin�ǥ��쥯�ȥ�˥��ԡ����Ƥ�������
#
# 3.
#  ������񤤤Ƥ�������
#
# 4.
#  rdf�������֥饦�������� http://������URL/index.rdf �˥����������Ƥ�������
#  
# 5.
#  �ʤ󤫤ǤƤ�����OK�Ǥ��������餯��
#
begin
	require 'uconv'
	@output_rdf_encode = 'UTF-8'
	@output_rdf_encoder = Proc::new {|s| Uconv.euctou8( s ) }
rescue LoadError
	@output_rdf_encode = @conf.encoding
	@output_rdf_encoder = Proc::new {|s| s }
end

