=begin
= etDiaryスタイル

== etDiaryスタイルとは
((<tDiary|URL:http://www.tdiary.org/>)) の変種である((<etDiary|URL:http://www.enbug.org/etdiary.html>)) の書式をtDiary本体で利用するためのスタイルです.

基本的にはtDiaryスタイルと同じくHTMLをベースとした書式ですが, HTMLタグを意識せずとも
だいたい見た目の通りになる
という違いがあります.

== 使用準備
このスタイルを使うには, 

(1) etdiary_style.rb ファイルを、tdiary/ ディレクトリにコピーしてくだ
    さい。tdiary/ ディレクトリは、tdiary.rb ファイルのあるトップディレク
    トリの下にあります。
(2) tdiary.confに以下の行を書いてください。
      @style = 'etdiary'

正しく設定されると, 更新フォームに
	本文(etdiaryスタイル):
と表示されます.

== etDiaryスタイルの使い方
etDiaryスタイルは, 行という単位はあまり意味がありません. つまり, 任意の個所に改行が入れられます. 空行(連続した改行)が段落の境界になります. たとえば

	ほげほげ
	ふがふが
	
	ふがほげ
	ほげら

は,

	<p>
	ほげほげ
	ふがふが
	</p>
	
	<p>
	ふがほげ
	ほげら
	</p>

と変換されます.

サブタイトルは明示的に「<<」と「>>」で囲みます. たとえば

	<<サブタイトル>>	
	本文

は,

	<h3>サブタイトル</h3>
	<p>
	本文
	</p>

と変換されます.

== 書式のルール

* サブタイトルは「<<」と「>>」で囲む.
* <h3>ではなく<h4>で囲みたいときは「<<<>」と「>>」で囲む.
* サブタイトルの中身がない場合, つまり, 「<<>>」と書かれた場合, サブタイトルなしで新しいセクションを開始する.
* 「<<<>>>」と書かれた場合もサブタイトルなしで新しいセクションを開始する. ただし, アンカーリンクは生成しない.
* 二つ以上の改行は段落の区切りとなる.
* 段落の初めが「<」の場合, その段落は整形対象外となる. 終了タグがその段落内に含まれない場合, 終了タグが存在する段落まで, 空行を残したまま処理される. これが嫌なら, スペースを先頭に入れると良い.
* 一般的なHTML同様, "<", ">", "&" はそれぞれ "&lt;", "&gt;", "&amp;" と書く必要がある. ただし, 「<pre>」ではじめた段落に関してはこの限りではない.

== 謝辞
ただただしさんをはじめとする, tDiaryおよびスタイル変更機能を実装いただきました皆様に感謝致します.

Yoshinori K. Okuji さんが tDiary-1.4.3 をベースに etDiary を実装され, etDiary フォーマットを考案されることがなかったならば, このスタイルが実装されることはありませんでした. また, 当文書も, Okuji さんのページをほぼそのまま写させていただきました. この文書を書けるのも, ひとえに Okuji さんのおかげです. ここに感謝の意を表します.

その他, etDiary スタイルを利用してくださっている皆様, ご意見頂戴しました皆様に, 御礼申し上げます.

== 著作権
Copyright 2003 simm <simm at fan.jp>

Permission is granted for use, copying, modification, distribution, and distribution of modified versions of this work under the terms of GPL version 2 or later.

=end
