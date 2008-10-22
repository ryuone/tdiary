$KCODE = 'u'
require 'stringio'

require 'spec'

require 'spec'
require 'rr'
include RR::Adapters::RRMethods

require 'hpricot'
require 'rspec_hpricot_matchers'
include RspecHpricotMatchers


$:.unshift(File.expand_path("../../", File.dirname(__FILE__)))
require 'tdiary'

class ResponseSpy
	class HTTPStatus
		attr_reader :code, :message
		def initialize(code, message)
			@code, @message = code.to_i, message
		end
	end

	attr_reader :body, :body_raw
	def initialize
		@raw = StringIO.new
		@body_raw = ""
	end

	def body
		@body
	end

	def headers
		@headers
	end
	alias :header :headers

	def status
		@status
	end

	def status_code
		@status.code
	end

	def parse_raw_result(raw)
		raw_header, *body = raw.split(CGI::EOL * 2)
		@raw = raw
		@headers ||= parse_headers(raw_header)
		@body_raw = body.join("")
		@body = Hpricot(@body_raw)
		@status = if status = @headers["Status"]
						 m = status.match(/(\d+)\s(.+)\Z/)
						 HTTPStatus.new(*m[1..2])
					 else
						 HTTPStatus.new(200, "OK")
					 end
	end

	private
	def parse_headers(raw_header)
		raw_header.split(CGI::EOL).inject({}) do |headers, entry|
			if (pair = /(.+?):\s(.+?)\Z/.match(entry))
				key, val = pair[1..-1]
				headers[key] = val
			end
			headers
		end
	end

end

class TDiaryDriver
	class << self
		def configure(&block)
			driver = new
			yield driver
			driver
		end

		private :new
	end

	def initialize
		@param_str = []
	end

	def data_path(path)
		stub(TDiary::Config).tdiary_config_file_path { path }
	end

	def append_param(param)
		@param_str << param
	end

	def invoke(path)
		raw_result = StringIO.new
		begin
			require 'stringio'
			stdin_spy = StringIO.new("")
			unless @param_str.empty?
				stdin_spy.print(@param_str.join("\n"))
				stdin_spy.rewind
			end
			$stdin = stdin_spy

			dummy_stderr = StringIO.new
			$stderr = dummy_stderr
			$stdout = raw_result
			tdiary_cgi_path = File.expand_path(path, tdiary_base_dir)

			load tdiary_cgi_path
		ensure
			$stdout = STDOUT
			$stderr = STDERR
			raw_result.rewind
			@res = ResponseSpy.new
			@res.parse_raw_result(raw_result.read)
		end
		puts @res.body if $DEBUG
		return [@res.status_code, @res.headers, @res.body]
	end

	private
	def tdiary_base_dir
		File.expand_path("../../../", File.expand_path(__FILE__))
	end

end

Before do
	# Scenario setup
	work_data_entries = File.expand_path("../data", File.dirname(__FILE__))
	FileUtils.rm_r(Dir.glob("#{work_data_entries}/*"), :verbose => true, :force => true)
end

After do
	# Scenario teardown
end

at_exit do
	# Global teardown
end
