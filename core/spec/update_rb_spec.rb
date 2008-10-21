# -*- coding: utf-8 -*-
$:.unshift(File.dirname(__FILE__))
require 'spec_helper'
require 'fileutils'

describe "update.rb" do
	describe "@初回の設定画面表示" do
		before(:all) do
			# duplicates?
			first_config_dir = File.expand_path("data/first_config", __DIR__)
			FileUtils.mkdir_p first_config_dir unless File.exist?(first_config_dir)

			cgi_stub = CGIStub.new(:get, "/update.rb", :conf => 'default')
			stub(CGI).new{cgi_stub}
			# newよりもsetupとかconfigのほうがいい?
			config_stub = ConfigStub.new(cgi_stub) do
				@data_path = first_config_dir
			end
			# FIXME: why 2 times needed to make green???
			mock(TDiary::Config).new(cgi_stub).times(2){config_stub}
			@driver = TDiaryDriver.update(cgi_stub)
			@driver.invoke
			@response = @driver.response
			@headers = @response.headers
			@body = @response.body
		end

		it { @response.status_code.should == 200 }
		it("Status") { @headers["Status"].should == "200 OK" }

		it("Content-Type") { @headers["Content-Type"].should == "text/html; charset=UTF-8"}
		it("Last-Modified") { @headers.should_not have_key("Last-Modified")}

		it("Vary") { @headers["Vary"].should == "User-Agent" }
		it("ETag") { @headers.should_not have_key("ETag")}
		it("Pragma") { @headers.should_not have_key("Pragma")}
		it("Cache-Control") { @headers.should_not have_key("Cache-Control")}
		it("Content-Length") { @headers["Content-Length"].should == @response.body_raw.size.to_s }

		it{ @body.should have_tag("h1", /(設定)/) }

		# タイトルに何か入ってる
		# 日記のURLにも何か入ってる
	end
=begin
	desc "default設定の更新" do
		before(:all) do
			# duplicates?
			saveconf_default_dir = File.expand_path("data/saveconf_default", __DIR__)
			FileUtils.mkdir_p first_config_dir unless File.exist?(first_config_dir)

			cgi_stub = CGIStub.new(:get, "/update.rb", :conf => 'default')
			stub(CGI).new{cgi_stub}
			# newよりもsetupとかconfigのほうがいい?
			config_stub = ConfigStub.new(cgi_stub) do
				@data_path = saveconf_default_dir
			end
			# FIXME: why 2 times needed to make green???
			mock(TDiary::Config).new(cgi_stub).times(2){config_stub}
			@driver = TDiaryDriver.update(cgi_stub)
			@driver.invoke
			@response = @driver.response
			@headers = @response.headers
			@body = @response.body
		end

		# saveした直後は h1 は変わらない
		# tdiary.confに保存されてる
		# もう一回読みにいくと、h1は 変わってる
		# 設定した内容がフィールドに設定されてる

# <form class="conf" action="update.rb" method="post"><div>
# 	<input name="conf" type="hidden" value="default" />
# 	<!-- no CSRF protection key used -->
# 	<div class="help-icon"><a href="http://docs.tdiary.org/ja/?default.rb" target="_blank"><img src="theme/help.png" height="19" alt="Help" width="19" /></a></div>
# 	<div class="saveconf"><input name="saveconf" class="saveconf" type="submit" value="OK" /></div>
# 		<h3 class="subtitle">タイトル</h3>
# 	<p>HTMLの&lt;title&gt;タグ中および、モバイル端末からの参照時に使われるタイトルです。HTMLタグは使えません。</p>
# 	<p><input name="html_title" size="50" value="" /></p>

# 	<h3 class="subtitle">著者名</h3>
# 	<p>あなたの名前を指定します。HTMLヘッダ中に展開されます。</p>
# 	<p><input name="author_name" size="40" value="" /></p>

# 	<h3 class="subtitle">メールアドレス</h3>
# 	<p>あなたのメールアドレスを指定します。HTMLヘッダ中に展開されます。</p>
# 	<p><input name="author_mail" size="40" value="" /></p>

# 	<h3 class="subtitle">トップページURL</h3>
# 	<p>日記よりも上位のコンテンツがあれば指定します。存在しない場合は何も入力しなくてかまいません。</p>
# 	<p><input name="index_page" size="70" value="" /></p>

# 	<h3 class="subtitle">日記のURL</h3>
# 	<p>日記のURLを指定します。このURLは、さまざまなプラグインで日記の指し示すために利用されるので、正しく一意なものを指定しましょう。</p>

# 	<p><input name="base_url" size="70" value="http://localhost:10080/" /></p>

# 	<h3 class="subtitle">日記の説明</h3>
# 	<p>この日記の簡単な説明を指定します。HTMLヘッダ中に展開されます。何も入力しなくてもかまいません。</p>
# 	<p><input name="description" size="70" value="" /></p>

# 	<h3 class="subtitle">サイトアイコン(favicon)</h3>
# 	<p>この日記を表す小さなアイコン画像(favicon)があればそのURLを指定します。HTMLヘッダ中に展開されます。何も入力しなくてもかまいません。</p>
# 	<p><input name="icon" size="70" value="" /></p>

# 	<h3 class="subtitle">バナー画像</h3>
# 	<p>この日記を表す画像(バナー)があればそのURLを指定します。makerssプラグインなどでRSSを出力する場合などに使われます。何も入力しなくてもかまいません。</p>
# 	<p><input name="banner" size="70" value="" /></p>

# 	<div class="saveconf"><input name="saveconf" class="saveconf" type="submit" value="OK" /></div>
# </div></form>
	end
=end
end
