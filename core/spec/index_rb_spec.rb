# -*- coding: utf-8 -*-
$:.unshift(File.dirname(__FILE__))
require 'spec_helper'
require 'fileutils'

describe "index.rb" do
	describe "@インストール直後" do
		before(:all) do
			empty_data_dir = File.expand_path("data/empty", __DIR__)
			FileUtils.mkdir_p empty_data_dir unless File.exist?(empty_data_dir)
			cgi_stub = CGIStub.new(:get, "/inex.rb")
			stub(CGI).new {cgi_stub }
			config_stub = ConfigStub.new(cgi_stub) do
				@data_path = empty_data_dir
				@update = 'update.cgi' # .cgiがデフォルトでよいのか? .rb でなく?
				@html_title = %Q[【日記のタイトル】(→<a href="#{@update}?conf=default">サイトの情報</a>で変更しましょう)]
				@header = <<-HEADER
<%= navi %>
<h1><%= @html_title %></h1>
<div class="main">
         HEADER
			end
			mock(TDiary::Config).new(cgi_stub){config_stub}
			@index_rb = TDiaryDriver.index(cgi_stub)
			@response = @index_rb.response
			@headers = @response.headers
			@body = @response.body
		end

		it { @response.status_code.should == 200}
		# FIXME 正常表示の場合も、ステータスコードをつけたほうがよいのでは？(対称性のため;update.rbには付いてる)
		it("Status") { @headers.should_not have_key("Status")}

		it("Content-Type") { @headers["Content-Type"].should == "text/html; charset=UTF-8"}
		it("Last-Modified") { @headers.should have_key("Last-Modified")}

		it("Vary") { @headers["Vary"].should == "User-Agent"}
		it("ETag") { @headers.should have_key("ETag")}
		it("Pragma") { @headers["Pragma"].should == "no-cache"}
		it("Cache-Control") { @headers["Cache-Control"].should == "no-cache"}
		it("Content-Length") { @headers["Content-Length"].should == @response.body_raw.size.to_s }

		it { @body.should_not be_nil }
		it { @should have_tag("h1", /【日記のタイトル】/)}
	end
end
