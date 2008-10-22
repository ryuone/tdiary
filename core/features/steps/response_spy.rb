class ResponseSpy
	class HTTPStatus
		attr_reader :code, :message
		def initialize(code, message)
			@code, @message = code.to_i, message
		end
	end

	class << self
		def parse(raw_result)
			response_spy = new(raw_result)
			response_spy.parse_raw_result
			response_spy
		end
		private :new
	end

	attr_reader :body, :body_raw


	def initialize(raw = StringIO.new)
		@raw = raw
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

	def parse_raw_result
		raw_header, *body = @raw.split(CGI::EOL * 2)
		@headers ||= parse_headers(raw_header)
		@body_raw = body.join("")
		@body = Hpricot(@body_raw)
		@status = extract_status
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

	def extract_status
		if status = @headers["Status"]
			m = status.match(/(\d+)\s(.+)\Z/)
			HTTPStatus.new(*m[1..2])
		else
			HTTPStatus.new(200, "OK")
		end
	end
end
