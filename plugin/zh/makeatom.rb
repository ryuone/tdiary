# makeatom.rb Chinese resources
def makeatom_tsukkomi_label( id )
	"TSUKKOMI to #{id[0,4]}-#{id[4,2]}-#{id[6,2]}[#{id[/[1-9]\d*$/]}]"
end

@makeatom_conf_label = 'Atom feeds'

def makeatom_conf_html
	<<-HTML
	<h3>Atom feeds settings</h3>
	<p>Atom feeds provides contents of your diary in a machine-readable format.
		Information in Atom is read with Atom readers and posted on other web sites.</p>
	#{%Q[<p class="message">Cannot write to file '#{@makeatom_full.file}'.<br>This file have to writable by your web server.</p>] unless @makeatom_full.writable?}
	<ul>
	<li><select name="makeatom.hidecontent">
		<option value="f"#{' selected' unless @conf['makeatom.hidecontent']}>Include</option>
		<option value="t"#{' selected' if @conf['makeatom.hidecontent']}>Hide</option></select>
		encoded contents of your diary in the feed.
	<li>Include summary of your contents<select name="makeatom.shortdesc">
		<option value="f"#{' selected' unless @conf['makeatom.shortdesc']}>as long as possible</option>
		<option value="t"#{' selected' if @conf['makeatom.shortdesc']}>only some portion</option></select>
		in the feed.
	<li><select name="makeatom.comment_link">
		<option value="f"#{' selected' unless @conf['makeatom.comment_link']}>Insert</option>
		<option value="t"#{' selected' if @conf['makeatom.comment_link']}>Don't Insert </option></select>
		a link to TSUKKOMI form into encoded text.
	</ul>

	<h3>Feed without TSUKKOMI</h3>
	<p>Standard feed contains your diary and also TSUKKOMIs by your diary readers. If you want to make a feed without TSUKKOMIs, set this preference below. So, when standard feed has encoded contens, this feed contain encoded text of TSUKKOMI also.</p>
	#{%Q[<p class="message">Cannot write to file '#{@makeatom_no_comments.file}'.<br>This file have to writable by your web server.</p>]  if @conf['makeatom.no_comments'] and !@makeatom_no_comments.writable?}
	<ul>
	<li><select name="makeatom.no_comments">
		<option value="t"#{' selected' if @conf['makeatom.no_comments']}>Feed</option>
		<option value="f"#{' selected' unless @conf['makeatom.no_comments']}>Don't feed</option></select> Atom without TSUKKOMI.</li>
	</ul>
	HTML
end

@makeatom_edit_label = "A little modify (don't update feeds)"

# Local Variables:
# mode: ruby
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# End:
