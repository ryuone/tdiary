# list.rb $Revision: 1.4 $
#
# <ol> �����դ��ꥹ������
#   <%= ol l %>
#   �ѥ�᥿:
#     l: �ꥹ��ʸ����(\n������)
#
# <ul> ����̵���ꥹ��
#   <%= ul l , t %>
#   �ѥ�᥿:
#     l: �ꥹ��ʸ����(\n������)
#
# Copyright (c) 2002 abbey <inlet@cello.no-ip.org>
# Distributed under the GPL.
#

def ol( l, t = nil, s = nil )
	apply_plugin( %Q[<ol>#{li l}</ol>] )
end

def ul( l, t = nil)
	apply_plugin( %Q[<ul>#{li l}</ul>] )
end

def li( text )
	list = ""
	text.each do |line|
		list << ("<li>" + line.chomp + "</li>")
	end
	result = list
end

