# search_form.rb japanese resource. $Revision: 1.1 $

def googlej_form( button_name = "Google ����", size = 20, default_text = "" )
	first = %Q[<a href="http://www.google.com/">
		<img src="http://www.google.com/logos/Logo_40wht.gif" 
			style="border-width: 0px; vertical-align: middle;" alt="Google"></a>]
	last = %Q[<input type="hidden" name="hl" value="ja"><input type="hidden" name="ie" value="euc-jp">]
	search_form( "http://www.google.com/search", "q", button_name, size, default_text, first, last )
end

def google_form( button_name = "Google ����", size = 20, default_text = "" )
	googlej_form( button_name, size, default_text )
end

def yahooj_form( button_name = "Yahoo! ����", size = 20, default_text = "" )
	first = %Q[<a href="http://www.yahoo.co.jp/">
		<img src="http://img.yahoo.co.jp/images/yahoojp_sm.gif" 
			style="border-width: 0px; vertical-align: middle;" alt="Yahoo! JAPAN"></a>]
	search_form( "http://search.yahoo.co.jp/bin/search", "p", button_name, size, default_text, first, "" )
end

def yahoo_form( button_name = "Yahoo! ����", size = 20, default_text = "" )
	yahooj_form( button_name, size, default_text )
end
