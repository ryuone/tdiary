=begin
= RDスタイル
== RDスタイルとは
Ruby 関連のドキュメントを書くために考案された汎用のドキュメントフォーマット
RD風の書式で日記を記述できます。

* ((<What is RD? What is RDtool?|URL:http://www2.pos.to/~tosh/ruby/rdtool/ja/whats.html>))

== RDスタイルを使うために
RDスタイルを使うには RDtool がインストールされている必要があります。 RDtool
は RAA((-Ruby Application Archive-)) から入手できます。

((<RDtool|URL:http://raa.ruby-lang.org/list.rhtml?name=rdtool>))

rd_style.rb をインストールディレクトリにあるtdiary ディレクトリ (tdiary_style.rbのあるディレクトリ) にコピーし、tdiary.confに以下の設定をします。

 @style = 'RD'

必須ではありませんが、プラグイン集に含まれる a.rb をインストールすると RD のリファレンス風にリンクを記述できます。便利なプラグインなのでインストールすることを勧めます。記述例は後述の URL を参照してください。

== RD との違い
=== Headline element
'=' 1つが <h3> になりセクションの開始になります。'==' が <h4>、'===' が <h5>、
'====' が <h6> となります。'+'、'++' は使用しません。

=== MethodList
(('---')) に HTML のタグを与えると、HTML のブロック要素に変換されます。(('---'))に何も与えない場合は <hr> へ変換されます。

 --- <hr>
 ---
 --- <blockquote>
     この部分は引用です。

=== Inline element
==== プラグイン
本来はキーボード入力を表す (('((% %))')) が tDiary のプラグインになります。

 ((%amazon '4906470068'%))

==== 生HTML
(('((: :))')) で囲むと生の HTML を記述できます。

 ((:<del>この部分は取り消し</de>:))

==== URL
URL 以外に画像、RAA、Ruby関連のメーリングリストへのリンクが RWiki
((-書式にRDを使用するWikiクローン-)) 同様、簡単に記述できるようになっていま
す。

 ((<テスト画像|IMG:test.jpg>))
 ((<RAA:tdiary>))
 ((<ruby-list:0001>))

上記以外の形式は myプラグイン((-tDiary 標準なので何もせずに使えます-))と aプラグイン((-インストールしなくてもRDスタイルは使えますが、便利ですのでインストールすることをお勧めします-))へ展開されます。それにより自分の日記へのリンクや aプラグインの辞書へ登録されている URL へのリンクが RD の reference風に記述できます。
aプラグインの使い方はプラグイン附属のドキュメントを参照してください。

myプラグインに展開されるリンク

 ((<そのツッコミ|20030308#c01>))

aプラグインに展開されるリンク

 ((<key>))
 ((<key:20020329.html>))
 ((<こちら|key:20020329.html>))

=== その他
'=begin', '=end' は必要ありません。

=end

