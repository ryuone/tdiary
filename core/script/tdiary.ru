parent_dir = File.expand_path("../", File.dirname(__FILE__))
$:.unshift(parent_dir)
$:.unshift(File.expand_path("misc", parent_dir))

require 'rack/tdiary_app'

use Rack::ShowExceptions
use Rack::CommonLogger
use Rack::Lint

use Rack::Reloader

use Rack::Static, :urls => ["/theme"], :root => parent_dir

map "/" do
	run Rack::TDiaryApp.new(:index)
end

map "/index.rb" do
	run Rack::TDiaryApp.new(:index)
end

map "/update.rb" do
	run Rack::TDiaryApp.new(:update)
end
