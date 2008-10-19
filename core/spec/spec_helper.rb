$KCODE = 'u'
$:.unshift(File.expand_path("lib", File.dirname(__FILE__)))
require 'rubygems'
require 'spec'
require 'rr'
require 'rspec_hpricot_matchers'

require 'tdiary'

require 'core_ext'
require 'cgi_stub'
require 'response_spy'
require 'config_stub'
require 'tdiary_driver'

Spec::Runner.configure do |config|
	config.mock_with :rr
	config.include(RspecHpricotMatchers)
end

class IndexRbDriver
	def initialize(cgi_stub)
		@response = ResponseSpy.new(cgi_stub)
	end

	def invoke
		begin
			raw_result = StringIO.new
			$stdout = raw_result
			load "index.rb"
		ensure
			$stdout = STDOUT
			raw_result.rewind
			@response.parse_raw_result(raw_result.read)
		end
	end

	def response
		@response
	end

end
