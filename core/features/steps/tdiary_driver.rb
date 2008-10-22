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
