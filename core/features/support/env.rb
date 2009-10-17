# -*- coding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < "1.9"

require 'spec'
require 'rr'
include RR::Adapters::RRMethods

require 'hpricot'
require 'rspec_hpricot_matchers'
include RspecHpricotMatchers

$:.unshift(File.expand_path("../../", File.dirname(__FILE__)))
require 'tdiary'
require 'tdiary/tdiary_driver'

$:.unshift(File.expand_path("../../misc", File.dirname(__FILE__)))
require 'server'

def cleanup_feature_data_dir
	work_data_entries = File.expand_path("../data", File.dirname(__FILE__))
	FileUtils.rm_r(Dir.glob("#{work_data_entries}/*"), :verbose => false, :force => true)
end

def boot_cgi_daemon_with(tdiary_config_path)
	pid = fork do
		TDiary::Server.run(
			:port => 19293, :daemonize => true,
			:tdiary_config_path => tdiary_config_path
			)
	end
	Process.wait2
end

def shutdown_cgi_daemon
	pid_path = File.expand_path("../../tmp/tdiary-server.pid", File.dirname(__FILE__))
	if File.exist? pid_path
		kill_pid = File.read(pid_path).to_i
		Process.kill(:TERM.to_s, kill_pid)
	end
end

require 'webrat'
Webrat.configure do |config|
	config.mode = :mechanize
end

class TDiaryWorld
	include Webrat::Methods
	include Webrat::Matchers

	Webrat::Methods.delegate_to_session :response_code, :response_body
	URL_BASE = 'http://localhost:19293'
end

World { TDiaryWorld.new }

Before do
	# Scenario setup
	cleanup_feature_data_dir
end

After do
	# Scenario teardown
end

at_exit do
	# Global teardown
	shutdown_cgi_daemon
end

boot_cgi_daemon_with(File.expand_path("../fixtures/just_installed/tdiary.conf", File.dirname(__FILE__)))
sleep 5
