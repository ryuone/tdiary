$KCODE = 'u'
$:.unshift(File.expand_path("lib", File.dirname(__FILE__)))
require 'rubygems'
require 'spec'
require 'rr'
require 'rspec_hpricot_matchers'

require 'tdiary'

Spec::Runner.configure do |config|
	config.mock_with :rr
	config.include(RspecHpricotMatchers)
end
