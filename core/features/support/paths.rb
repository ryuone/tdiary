module NavigationHelpers
	# Maps a name to a path. Used by the
	#
	# When /^I go to (.+)$/ do |page_name|
	#
	# step definition in webrat_steps.rb
	#
	def path_to(page_name)
		path = case page_name
				when "日記トップ"
					"index.rb"
				 when /^(\d{4})年(\d{1,2})月(\d{1,2})日の日記$/
					 year = $1
					 month = "%02d" % $2
					 day = "%02d" % $3
					 "index.rb?date=#{year}#{month}#{day}"
				when "日記の更新"
					"update.rb"
				when "基本設定"
					"update.rb?conf=default"
				# 必要があればここに追加する
				else
					raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
						"Now, go and add a mapping in #{__FILE__}"
				end
		"#{TDiaryWorld::URL_BASE}/#{path}"
	end
end

World(NavigationHelpers)
