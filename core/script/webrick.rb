#!/usr/bin/env ruby
require 'webrick'
require 'webrick/httpservlet/cgihandler'
require 'webrick/httputils'

TDIARY_CORE_DIR = File.expand_path("..", File.dirname(__FILE__))

tdiary_mime_types = WEBrick::HTTPUtils::DefaultMimeTypes.merge({
	"rdf" => "application/xml",
	})

s = WEBrick::HTTPServer.new(
	:Port => 10080, :BindAddress => '127.0.0.1',
	:DocumentRoot => TDIARY_CORE_DIR,
	:MimeTypes => tdiary_mime_types,
	:Logger => WEBrick::Log::new($stderr, WEBrick::Log::DEBUG)
)
s.logger.level = WEBrick::Log::DEBUG
trap("INT") { s.shutdown }
trap("TERM") { s.shutdown }

s.mount("/index.cgi", WEBrick::HTTPServlet::CGIHandler,
	File.expand_path("index.rb", TDIARY_CORE_DIR))
s.mount("/update.cgi", WEBrick::HTTPServlet::CGIHandler,
	File.expand_path("update.rb", TDIARY_CORE_DIR))

s.start
