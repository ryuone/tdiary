$:.unshift(File.expand_path("../../", File.dirname(__FILE__)))
require 'cgi'
require 'rack/request'
require 'rack/response'
require 'tdiary/tdiary_driver'

# FIXME too dirty hack :-<
class CGI
	def env_table_rack
		$RACK_ENV
	end

	alias :env_table_orig :env_table
	alias :env_table :env_table_rack
end

module Rack
	class TDiaryApp
		def initialize( target )
			@driver = TDiaryDriver.new( target )
		end

		def call(env)
			req = Request.new(env)
			$RACK_ENV = req.env
			env["rack.input"].rewind
			tdiary_conf = ::File.expand_path("../../tdiary-rack.conf",
				::File.dirname(__FILE__))
			driver = @driver.configure {
				data_path tdiary_conf
			}
			driver.invoke
		end
	end
end
