# -*- coding: utf-8 -*-
require 'spec'
$:.unshift(File.expand_path("../../", File.dirname(__FILE__)))
require 'tdiary'

Before do
end

After do
end

Given "最低限のtdiary.conf" do
end

When /(.*) にアクセスした/ do |uri|
	@response = get uri
end

Then /ボディの (.*) タグは (.*) を含む/ do |tag, content|
	@response.should have_tag(tag, /#{content}/)
end

Then /ボディに (.*) へのリンクがある/ do |link|
	@response.should have_tag("a[@href=#{link}]")
end
