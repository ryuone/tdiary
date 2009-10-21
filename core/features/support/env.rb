# -*- coding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < "1.9"

require 'spec'
require 'rr'
include RR::Adapters::RRMethods

require 'hpricot'
require 'rspec_hpricot_matchers'
include RspecHpricotMatchers

$:.unshift(File.expand_path("../../", File.dirname(__FILE__)))
require 'tdiary'
require 'tdiary/tdiary_driver'
require 'tdiary/test_supporter'

$:.unshift(File.expand_path("../../misc", File.dirname(__FILE__)))
require 'server'

def cleanup_feature_data_dir
	work_data_entries = File.expand_path("../data", File.dirname(__FILE__))
	FileUtils.rm_r(Dir.glob("#{work_data_entries}/*"), :verbose => false, :force => true)
end

require 'webrat'
Webrat.configure do |config|
	config.mode = :mechanize
end

class TDiaryWorld
	include Webrat::Methods
	include Webrat::Matchers

	Webrat::Methods.delegate_to_session :response_code, :response_body
	URL_BASE = "http://localhost:#{TDiary::TestSupporter.port4cuke}"
end

World { TDiaryWorld.new }

Before do
	# Scenario setup
	cleanup_feature_data_dir
end

After do
	# Scenario teardown
end

at_exit do
	# Global teardown
end

begin
	require 'open-uri'
	cgidaemon_heatbeart = open(TDiaryWorld::URL_BASE)
rescue
	$stderr.puts(<<-ERROR_MESSAGE)
#{'(::)  ' * 10}

Can't access to a tDiary server via #{TDiaryWorld::URL_BASE}.
#{$!.class} raised.

Now, use 'script/server --cuke' command to
boot tDiary server for testing or check your tDiary server status.

#{'(::)  ' * 10}
   ERROR_MESSAGE
	exit!
ensure
	cgidaemon_heatbeart.close
end
