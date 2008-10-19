require 'rubygems'
gem 'rspec'
require 'spec'
require 'rest_client'
require 'hpricot'
require 'rspec_hpricot_matchers'

FEATURE_RUNNING_PORT = 10081

#Spec::Runner.configure do |config|
#	config.include(RspecHpricotMatchers)
#end
include RspecHpricotMatchers

# RestClient.log = "stdout"
def get(path)
	res = RestClient.get "http://localhost:#{FEATURE_RUNNING_PORT}#{path}"
	Hpricot(res)
end

$:.unshift(File.expand_path("../../misc", File.dirname(__FILE__)))
require 'server'

# Global setup
@@server = TDiary::Server.new({:port => FEATURE_RUNNING_PORT,
		:logger => nil,
		:access_log => nil})
Thread.start {
	@@server.start
}

Before do
# Scenario setup
end

After do
# Scenario teardown

end

at_exit do
	# Global teardown
	TDiary::Server.stop
end
