# -*- coding: utf-8 -*-
require 'stringio'
require 'response_spy'

class TDiaryDriver
	class << self
		def index(cgi_stub)
			new(cgi_stub, "index.rb").invoke
		end

		def update(cgi_stub)
			new(cgi_stub, "update.rb").invoke
		end

		private :new
	end

	def initialize( cgi_stub, load_file )
		@response = ResponseSpy.new(cgi_stub)
		@load_file = load_file
	end

	# XXX: statuscode, headers, body_string を返すようにする?
	def invoke
		begin
			tdiary_cgi_path = File.expand_path(@load_file, tdiary_base_dir)
			raw_result = StringIO.new
			$stdout = raw_result
			load tdiary_cgi_path
		ensure
			$stdout = STDOUT
			raw_result.rewind
			@response.parse_raw_result(raw_result.read)
		end
		self
	end

	def response
		@response
	end

	private
	def tdiary_base_dir
		File.expand_path("../../", __DIR__)
	end
end
