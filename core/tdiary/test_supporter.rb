# -*- coding: utf-8 -*-

# Cucumberを使って、cgiとrackで無理矢理テストできるようにするための
# ユーティリティを集めたクラス。
module TDiary
	class TestSupporter
		class << self
			def setup_tdiary_conf_memo
				tdiary_conf_memo_dir = File.dirname(tdiary_conf_memo_path)
				FileUtils.mkdir_p(tdiary_conf_memo_path) unless File.exist? tdiary_conf_memo_dir
				at_exit { TDiary::TestSupporter.delete_tdiary_conf_memo }
			end

			def write_tdiary_conf_memo(tdiary_conf_path)
				File.open(tdiary_conf_memo_path, 'w'){ |f| f.write(tdiary_conf_path) }
			end

			def delete_tdiary_conf_memo
				File.delete(tdiary_conf_memo_path) if File.exist?(tdiary_conf_memo_path)
			end

			def port4cuke
				19293
			end

			def tdiary_conf_memo_path
				File.expand_path("../tmp/tdiary-conf.memo", File.dirname(__FILE__))
			end
		end
	end
end
