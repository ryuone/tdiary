require 'webrick'
require 'webrick/httpservlet/cgihandler'
require 'webrick/httputils'
require 'webrick/accesslog'
require 'tempfile'

module TDiary
	class Server
		attr_reader :daemonize, :pid_path
		TDIARY_CORE_DIR = File.expand_path("..", File.dirname(__FILE__))
		DEFAULT_OPTIONS = {
			:logger => $stderr,
			:access_log => $stderr,
			:daemonize => false,
			:pid_path => File.expand_path("../tmp/tdiary-server.pid", File.dirname(__FILE__))
		}
		class << self
			def run(option)
				@@server = TDiary::Server.new(option)
				trap("INT") { @@server.shutdown }
				trap("TERM") { @@server.shutdown }
				@@server.start
			end

			def stop
				@@server.shutdown
			end
		end

		def initialize(options)
			opts = DEFAULT_OPTIONS.merge(options)
			@daemonize = opts[:daemonize]
			@pid_path = opts[:pid_path]
			@server = WEBrick::HTTPServer.new(
				:Port => opts[:port], :BindAddress => '127.0.0.1',
				:DocumentRoot => TDIARY_CORE_DIR,
				:MimeTypes => tdiary_mime_types,
				:Logger => webrick_logger_to(opts[:logger]),
				:AccessLog => webrick_access_log_to(opts[:access_log])
				)
			@server.logger.level = WEBrick::Log::DEBUG
			['/', '/index.rb'].each do |path|
				@server.mount(path, WEBrick::HTTPServlet::CGIHandler,
					File.expand_path("index.rb", TDIARY_CORE_DIR))
			end
			@server.mount("/update.rb", WEBrick::HTTPServlet::CGIHandler,
				File.expand_path("update.rb", TDIARY_CORE_DIR))
			@server.mount("/theme", WEBrick::HTTPServlet::FileHandler,
				File.expand_path("theme", TDIARY_CORE_DIR), :FancyIndexing => true)
		end

		def start
			if daemonize
				@server.logger.info("server will be daemon...")
				if RUBY_VERSION < "1.9"
					exit if fork
					Process.setsid
					exit if fork
					Dir.chdir "/"
					File.umask 0000
					STDIN.reopen "/dev/null"
					STDOUT.reopen "/dev/null", "a"
					STDERR.reopen "/dev/null", "a"
				else
					Process.daemon
				end
				if @pid_path
					pid_dir = File.dirname( @pid_path )
					require 'fileutils'
					FileUtils.mkdir_p(pid_dir) unless File.exist? pid_dir
					File.open(@pid_path, 'w'){ |f| f.write("#{Process.pid}") }
					at_exit { File.delete(@pid_path) if File.exist?(@pid_path) }
				end
			end
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

		def webrick_logger_to(io)
			io ||= Tempfile.new("webrick_logger")
			WEBrick::Log::new(io, WEBrick::Log::DEBUG)
		end

		def webrick_access_log_to(io)
			io ||= Tempfile.new("webrick_access_log")
			[
				[ io, WEBrick::AccessLog::COMMON_LOG_FORMAT ],
				[ io, WEBrick::AccessLog::REFERER_LOG_FORMAT ]
			]
		end
	end
end
