# nazo.rb $Revision: 1.3 $
#
# nazo: ��������Υ�����Ȥ�ϥ��饤�Ȥ��롣
#       �̾Ρ���JavaScript���ǽ����֡�
#   �ѥ�᥿:
#     color:      �ϥ��饤�Ȥ�ʸ����(��ά��:��)
#     background: �ϥ��饤�Ȥ��طʿ�(��ά��:��)
#
# See: http://kitaj.no-ip.com/tDiary-FAQ/rw-cgi.rb?cmd=view;name=tDiary-FAQ-Tips-nazo
#

def nazo( color = '#fff', background = '#f00' )
	<<-SCRIPT
		<script type="text/javascript"><!--
		var hiliteStyle = new Object();
		hiliteStyle.color = "#{color}";
		hiliteStyle.backgroundColor = "#{background}";
		
		var hiliteElem = null;
		var saveStyle = null;
		
		function hiliteElement(name)
		{
		  if( hiliteElem ){
		    for (var key in saveStyle){
		      hiliteElem.style[key] = saveStyle[key];
		    }
		    hiliteElem = null;
		  }
		
		  hiliteElem = getHiliteElement(name);
		  if ( !hiliteElem ) return;
		
		  saveStyle = new Object();
		  for (var key in hiliteStyle){
		    saveStyle[key] = hiliteElem.style[key];
		    hiliteElem.style[key] = hiliteStyle[key];
		  }
		}
		
		function getHiliteElement(name)
		{
		  for (i=0; i<document.anchors.length; ++i) {
		    var anchor = document.anchors[i];
		    if ( anchor.name == name ) {
		      var elem;
		      if ( anchor.parentElement ) {
		        elem = anchor.parentElement;
		      } else if ( anchor.parentNode ) {
		        elem = anchor.parentNode;
		      }
		      return elem;
		    }
		  }
		  return null;
		}
		
		if( document.location.hash ){
		  hiliteElement(document.location.hash.substr(1));
		}
		
		hereURL = document.location.href.split("#")[0];
		for( var i = 0; i < document.links.length; i++ ){
		  if( hereURL == document.links[i].href.split("#")[0] ){
		    document.links[i].onclick = handleLinkClick;
		  }
		}
		
		function handleLinkClick()
		{
		  hiliteElement(this.hash.substr(1));
		}
		// --></script>
	SCRIPT
end	
