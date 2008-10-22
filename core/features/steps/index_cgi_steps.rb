# -*- coding: utf-8 -*-

Before do
end

After do
end

Given "最低限のtdiary.conf" do
	@driver = TDiaryDriver.configure do |conf|
# some conf
	end
end

Given /クエリパラメータは (.*)/ do |param|
	@driver.append_param(param)
end

When /(.*) にアクセスした/ do |uri|
#	method = !http_method.empty? ? http_method : "get"
#	@status, @header, @response = @driver.__send__(method.to_sym, uri)
	@status, @header, @response = @driver.__send__(:get,  uri)
end

Then /ステータスコードは (.*) である/ do |status|
	@status.to_s.should == status
end

Then /ボディの (.*) タグは (.*) を含む/ do |hpricot_path, content|
	@response.should have_tag(hpricot_path, /#{content}/)
end

Then /ボディに (.*) へのリンクがある/ do |link|
	@response.should have_tag("a[@href=#{link}]")
end

Then /ボディに (.*) タグがある/ do |hpricot_path|
	@response.should have_tag(hpricot_path)
end
