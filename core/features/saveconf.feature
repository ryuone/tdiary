フィーチャ:設定画面の利用
  日記の管理者として
  日記の設定を行いたいので
  設定画面にある項目を更新したい

  シナリオ: インストール直後の初期画面
    前提 CGIが最低限動く設定
    もし "基本設定"ページを表示する
    ならば ステータスコードは 200 である
    かつ HTMLの title タグの内容は 【日記のタイトル】 を含む
    かつ HTMLの h1 タグの内容は 【日記のタイトル】 を含む
    かつ HTMLに form.conf タグがある

   シナリオ: 「サイトの情報」の設定
     前提 CGIが最低限動く設定
     もし "基本設定"ページを表示する
     かつ "author_name"に"ただただし"と入力する
     かつ "html_title"に"ただの日記"と入力する
     かつ "author_mail"に"t@tdtds.jp"と入力する
     かつ "index_page"に"http://localhost:19293/"と入力する
     かつ "description"に"ただただしによる日々の記録"と入力する
     かつ "icon"に"http://tdtds.jp/favicon.png"と入力する
     かつ "banner"に"http://sho.tdiary.net/images/banner.png"と入力する
     もし "OK"ボタンをクリックする
     ならば ステータスコードは 200 である
     かつ HTMLの title タグの内容は (設定完了) を含む
     かつ HTMLの h1 タグの内容は (設定) を含む
     かつ HTMLに form.conf タグがある
