def label_pingback_exclue; 'PingBack��Ͽ�����ꥹ��'; end
add_conf_proc('PingBack', 'PingBack�ץ饰����') do
	saveconf_pingback
	pingback_init

	<<-HTML
	<h3 class="subtitle">PingBack�����Ф�URL</h3>
	<p><input name="pingback.url" value="#{@conf['pingback.url']}" size="100"></p>
	<h3 class="subtitle">����å����ͭ������</h3>
	<p><input name="pingback.expire" value="#{@conf['pingback.expire']}" size="6">�ô�</p>
	<h3 class="subtitle">PingBack��Ͽ�����ꥹ��</h3>
	<p><textarea name="pingback.exclude" cols="70" rows="10">#{@conf['pingback.exclude']}</textarea></p>
	HTML
end
