require 'stringio'
require 'tdiary'
require 'tdiary/dispatcher'
require 'tdiary/response_helper'

class TDiaryDriver
	class << self
		def configure(&block)
			driver = new
			driver.instance_eval(&block) if block_given?
			driver
		end
	end

	def initialize( target = nil )
		@target = target
		@param_str = []
	end

	def configure( &block )
		instance_eval( &block )
		self
	end

	def data_path(path)
		::TDiary::Config.tdiary_config_file_path = path
	end

	def append_param(param)
		@param_str << param
	end

	def invoke( target = nil )
		@target = target if target

		fake_stdin_as_params
		raw_result = StringIO.new
		dummy_stderr = StringIO.new

		dispatcher = TDiary::Dispatcher.__send__(@target)
		dispatcher.dispatch_cgi(CGI.new, raw_result, dummy_stderr)

		raw_result.rewind
		@res = ResponseHelper.parse(raw_result.read)

		STDOUT.puts @res.body if $DEBUG

		@res.headers.delete("Status") # for rack lint
		return [@res.status_code, @res.headers, @res.body]
	end

	def fake_stdin_as_params
		stdin_spy = StringIO.new("")
		unless @param_str.empty?
			stdin_spy.print(@param_str.join("\n"))
			stdin_spy.rewind
		end
		$stdin = stdin_spy
	end
end
