# number_anchor.rb $Revision: 1.5 $
#
# number_anchor: アンカーにid属性を付加する
#          アンカー画像を異なるものにするためのもの
# 	   使用するさいは、設定画面のヘッダに
#	   <%= use_number_anchor( アンカーの種数 ) %>
#	   と書いてください。
#
# Copyright (C) 2002 by zoe <http://www.kasumi.sakura.ne.jp/~zoe/tdiary/>
# Distributed under the GPL
#

def use_number_anchor( n = 1 )
	@use_number_anchor = true
	@total_anchor = n
	""
end

alias :_orig_anchor :anchor

def anchor( s )
	if @use_number_anchor == true then
	if /^(\d+)#?([pct])?(\d*)?$/ =~ s then
		if $2 then
			n = $3.to_i
			if n && n > @total_anchor then
				n = (n % @total_anchor)
			end
			"#{_orig_anchor(s)}\" class=\"#$2#{'%02d' % n}"
		else
			_orig_anchor(s)
		end
	else
		""
	end
	else
		_orig_anchor(s)
	end
end
