#!/usr/bin/env ruby
require 'webrick'
require 'webrick/httpservlet/cgihandler'
require 'webrick/httputils'

class TDiaryDevelopmentServer
	TDIARY_CORE_DIR = File.expand_path("..", File.dirname(__FILE__))

	class << self
		def run
			@@server = TDiaryDevelopmentServer.new
			@@server.start
		end

		def stop
			@@server.shutdown
		end
	end

	def initialize
		@server = WEBrick::HTTPServer.new(
			:Port => 10080, :BindAddress => '127.0.0.1',
			:DocumentRoot => TDIARY_CORE_DIR,
			:MimeTypes => tdiary_mime_types,
			:Logger => WEBrick::Log::new($stderr, WEBrick::Log::DEBUG)
		)
		@server.logger.level = WEBrick::Log::DEBUG
		trap("INT") { @server.shutdown }
		trap("TERM") { @server.shutdown }
		@server.mount("/index.cgi", WEBrick::HTTPServlet::CGIHandler,
			File.expand_path("index.rb", TDIARY_CORE_DIR))
		@server.mount("/update.cgi", WEBrick::HTTPServlet::CGIHandler,
			File.expand_path("update.rb", TDIARY_CORE_DIR))
	end

	def start
		@server.start
	end

	def shutdown
		@server.shutdown
	end

	private
	def tdiary_mime_types
		WEBrick::HTTPUtils::DefaultMimeTypes.merge({
				"rdf" => "application/xml",
			})
	end
end

if $0 == __FILE__
	TDiaryDevelopmentServer.run
end
