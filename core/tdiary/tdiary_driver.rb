require 'stringio'
require 'tdiary/response_helper'

class TDiaryDriver
	class << self
		def configure(&block)
			driver = new
			driver.instance_eval(&block) if block_given?
			driver
		end

		private :new
	end

	def initialize
		@param_str = []
	end

	def data_path(path)
		TDiary::Config.tdiary_config_file_path = path
	end

	def append_param(param)
		@param_str << param
	end

	def invoke(path)
		raw_result = StringIO.new
		begin
			stdin_spy = StringIO.new("")
			unless @param_str.empty?
				stdin_spy.print(@param_str.join("\n"))
				stdin_spy.rewind
			end
			$stdin = stdin_spy

			dummy_stderr = StringIO.new
			$stderr = dummy_stderr
			$stdout = raw_result
			File.open(tdiary_cgi_path(path)) {|f| f.read}
			load tdiary_cgi_path(path)

			raw_result.rewind
			@res = ResponseHelper.parse(raw_result.read)
		ensure
			$stdout = STDOUT
			$stderr = STDERR
		end
		puts @res.body if $DEBUG
		[@res.status_code, @res.headers, @res.body]
	end

	private

	def tdiary_cgi_path(path)
		cgi_path = File.expand_path(path, tdiary_base_dir)
		if File.exist?(cgi_path)
			return cgi_path
		else
			raise Errno::ENOENT.new(cgi_path)
		end
	end

	def tdiary_base_dir
		File.expand_path("../", File.dirname(__FILE__))
	end

end
