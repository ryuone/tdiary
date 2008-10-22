require 'stringio'
require 'hpricot'


class ResponseSpy
	class HTTPStatus
		attr_reader :code, :message
		def initialize(code, message)
			@code, @message = code.to_i, message
		end
	end

	attr_reader :body, :body_raw
	def initialize(cgi_stub)
		@cgi_stub = cgi_stub
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
