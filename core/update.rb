#!/usr/bin/env ruby
#
# update.rb $Revision: 1.22 $
#
# Copyright (C) 2001-2003, TADA Tadashi <sho@spc.gr.jp>
# You can redistribute it and/or modify it under GPL2.
#
BEGIN { $defout.binmode }
$KCODE = 'n'

begin
	if FileTest::symlink?( __FILE__ ) then
		org_path = File::dirname( File::readlink( __FILE__ ) )
	else
		org_path = File::dirname( __FILE__ )
	end
	$:.unshift( org_path.untaint )
	require 'tdiary/dispatcher'

	@cgi = CGI.new
	TDiary::Dispatcher.update.dispatch_cgi( @cgi )

rescue Exception
	if @cgi then
		print @cgi.header( 'status' => '500 Internal Server Error', 'type' => 'text/html' )
	else
		print "Status: 500 Internal Server Error\n"
		print "Content-Type: text/html\n\n"
	end
	puts "<h1>500 Internal Server Error</h1>"
	puts "<pre>"
	puts CGI::escapeHTML( "#{$!} (#{$!.class})" )
	puts ""
	puts CGI::escapeHTML( $@.join( "\n" ) )
	puts "</pre>"
	puts "<div>#{' ' * 500}</div>"
end
