# makerss.rb Japanese resources
begin
	require 'uconv'
	@makerss_encode = 'UTF-8'
	@makerss_encoder = Proc::new {|s| Uconv.euctou8( s ) }
rescue LoadError
	@makerss_encode = @conf.encoding
	@makerss_encoder = Proc::new {|s| s }
end

def makerss_tsukkomi_label( id )
	"#{id[0,4]}-#{id[4,2]}-#{id[6,2]}�Υĥå���[#{id[9,2].sub( /^0/, '' )}]"
end

add_conf_proc('makerss', 'RSS�κ���') do
	if @mode == 'saveconf'
		item = 'makerss.hidecomment'
		case @cgi.params[item][0]
		when 'f'
			@conf[item] = false
		when 'text'
			@conf[item] = 'text'
		when 'any'
			@conf[item] = 'any'
		end
		%w( makerss.hidecontent makerss.shortdesc ).each do |item|
			@conf[item] = ( 't' == @cgi.params[item][0] )
		end
	end

	<<-_HTML
	<p>�����������RSS����ޤ���</p>
	<p>RSS��¾�Υץ������ɤߤ䤹�����ǡ����������Ƥ�������ޤ���RSS�˴ޤޤ������RSS�꡼�������ɤޤ줿�ꡢ�������Υ����Ȥ�ž�ܤ��줿�ꤷ�����Ѥ���Ƥ��ޤ���</p>
	<ul>
	<li>RSS��<select name="makerss.hidecomment">
		<option value="f"#{@conf['makerss.hidecomment'] ? '' : ' selected'}>�ĥå��ߤ����Τ�ޤ��</option>
		<option value="text"#{@conf['makerss.hidecomment'] == 'text' ? ' selected' : ''}>�ĥå��ߤ����դ���ƼԤ�����ޤ��</option>
		<option value="any"#{@conf['makerss.hidecomment'] == 'any' ? ' selected' : ''}>�ĥå��ߤ�ޤ�ʤ�</option></select>
	<li>RSS����ʸ���Τ�<select name="makerss.hidecontent">
		<option value="f"#{@conf['makerss.hidecontent'] ? '' : ' selected'}>�ޤ��</option>
		<option value="t"#{@conf['makerss.hidecontent'] ? ' selected' : ''}>�ޤ�ʤ�</option></select>
	<li>RSS�˴ޤ��������<select name="makerss.shortdesc">
		<option value="f"#{@conf['makerss.shortdesc'] ? '' : ' selected'}>�Ǥ������Ĺ������</option>
		<option value="t"#{@conf['makerss.shortdesc'] ? ' selected' : ''}>�ǽ�����ˤ���</option></select>
	</ul>
	_HTML
end
