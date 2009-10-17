# -*- coding: utf-8 -*-

Given "CGIが最低限動く設定" do
	fixture_dir = File.expand_path("../fixtures", File.dirname(__FILE__))
	work_data_dir = File.expand_path("../data", File.dirname(__FILE__))
	sources = Dir.glob("#{fixture_dir}/just_installed/data/*")
	FileUtils.cp_r sources, work_data_dir, :verbose => false unless sources.empty?
end

Then /^日付フォームは"([^\"]*)"になっている$/ do |date|
	year = month = day = 0
	if date == "今日"
		today = Date.today
		year, month, day = [today.year, "%02d" % today.month, "%02d" % today.day]
	end
	field_named("year").value.should =~ /#{year}/
	field_named("month").value.should =~ /#{month}/
	field_named("day").value.should =~ /#{day}/
end

Then /ステータスコードは (.*) である/ do |status|
	response_code.should == status.to_i
end

Then /"([^\"]*)"へのリンクがあること/ do |link|
	response_body.should have_tag("a[@href='#{link}']")
end

Then /"([^\"]*)"タグがある/ do |selector|
	response_body.should have_tag(selector)
end
