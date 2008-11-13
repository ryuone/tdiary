#!/usr/bin/env ruby
BASE_DIR = File.expand_path('..', File.dirname(__FILE__))
gempath = File.join(`gem env gempath`.chomp, "gems")
CTAGS = "ctags -e -a --recurse"
tags_file = File.join(BASE_DIR, "TAGS")
File.delete(tags_file) if File.exist?(tags_file)

target_gem_libs = %w[
  rspec-1.1.9
  rspec_hpricot_matchers-1.0
  rr-0.6.0
  cucumber-0.1.9
  rest-client-0.8
  rack-0.4.0
]

target_gem_libs.each do |gem|
	$stderr.puts "Generate tags for #{gem}"
	system("#{CTAGS} #{File.join(gempath, gem)}") || raise("FAIL!")
end

	$stderr.puts "Generate tags for tdiary-core"
system("#{CTAGS} #{BASE_DIR}") || raise("fail")
