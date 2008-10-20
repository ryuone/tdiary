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
			mock(TDiary::Config).new(cgi_stub).times(2){config_stub} # why 2 times needed to make green???
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
		it{ puts @body }
	end
end
