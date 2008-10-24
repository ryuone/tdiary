$KCODE = 'u'
require 'stringio'

require 'spec'
require 'rr'
include RR::Adapters::RRMethods

require 'hpricot'
require 'rspec_hpricot_matchers'
include RspecHpricotMatchers

$:.unshift(File.expand_path("../../", File.dirname(__FILE__)))
require 'tdiary'

$:.unshift(File.dirname(__FILE__))
require 'response_helper'
require 'tdiary_driver'

def cleanup_feature_data_dir
	work_data_entries = File.expand_path("../data", File.dirname(__FILE__))
	FileUtils.rm_r(Dir.glob("#{work_data_entries}/*"), :verbose => true, :force => true)
end

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
