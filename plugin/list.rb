# list.rb $Revision: 1.1 $
#
# <ol> �����դ��ꥹ������
#   <%= ol l, t, s %>
#   �ѥ�᥿:
#     l: �ꥹ��ʸ����(\n������)
#     t: �����ֹ�Υ����ס�
#        1,a,A,i,I
#        �ǥե���Ȥ� 1
#     s: �����ֹ�
#        �ǥե���Ȥ� 1
#     (t,s�Ͼ�ά��ǽ)
#
# <ul> ����̵���ꥹ��
#   <%= ul l , t %>
#   �ѥ�᥿:
#     l: �ꥹ��ʸ����(\n������)
#     t: ���ܥޡ����Υ����ס�
#          d:����
#          c:���
#          s:�ͳ�
#        �ǥե���Ȥ�d
#     t�Ͼ�ά��ǽ
#
# Copyright (c) 2002 abbey <inlet@cello.no-ip.org>
# Distributed under the GPL.
# 

def ol( l, t = "1", s = "1" )
	%Q[<ol type="#{t}" start="#{s}">#{li l}</ol>]
end

def ul( l, t = "")
	t2 = "disc"
	if t == "c"
		t2 = "circle"
	elsif t == "s"
		t2 = "square"
	end       
	%Q[<ul type="#{t2}">#{li l}</ul>]
end

def li( text )
	list = ""
	text.each do |line|
		list << ("<li>" + line.chomp + "</li>")
	end
	result = list
end

