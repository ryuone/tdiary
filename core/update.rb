#!/usr/bin/env ruby
# update.rb $Revision: 1.4 $
$KCODE= 'e'
BEGIN { $defout.binmode }

begin
	if FileTest::symlink?( __FILE__ ) then
		org_path = File::dirname( File::readlink( __FILE__ ) )
	else
		org_path = File::dirname( __FILE__ )
	end
	$:.unshift org_path
	require 'tdiary'

	@cgi = CGI::new
	conf = TDiary::Config::new
	tdiary = nil

	begin
		if @cgi.valid?( 'append' )
			tdiary = TDiary::TDiaryAppend::new( @cgi, 'show.rhtml', conf )
		elsif @cgi.valid?( 'edit' )
			tdiary = TDiary::TDiaryEdit::new( @cgi, 'update.rhtml', conf )
		elsif @cgi.valid?( 'replace' )
			tdiary = TDiary::TDiaryReplace::new( @cgi, 'show.rhtml', conf )
		elsif @cgi.valid?( 'comment' )
			tdiary = TDiary::TDiaryShowComment::new( @cgi, 'update.rhtml', conf )
		elsif @cgi.valid?( 'conf' )
			tdiary = TDiary::TDiaryConf::new( @cgi, 'conf.rhtml', conf )
		elsif @cgi.valid?( 'referer' )
			tdiary = TDiary::TDiaryConf::new( @cgi, 'referer.rhtml', conf )
		elsif @cgi.valid?( 'saveconf' )
			tdiary = TDiary::TDiarySaveConf::new( @cgi, 'conf.rhtml', conf )
		else
			tdiary = TDiary::TDiaryForm::new( @cgi, 'update.rhtml', conf )
		end
	rescue TDiary::TDiaryError
		tdiary = TDiary::TDiaryForm::new( @cgi, 'update.rhtml', conf )
	end

	head = body = ''
	if @cgi.mobile_agent? then
		body = tdiary.eval_rhtml( 'i.' ).to_sjis
		head = @cgi.header(
			'status' => '200 OK',
			'type' => 'text/html',
			'charset' => 'Shift_JIS',
			'Content-Length' => body.size.to_s,
			'Vary' => 'User-Agent'
		)
	else
		body = tdiary.eval_rhtml
		head = @cgi.header(
			'status' => '200 OK',
			'type' => 'text/html',
			'charset' => 'EUC-JP',
			'Content-Length' => body.size.to_s,
			'Vary' => 'User-Agent'
		)
	end
	print head
	print body if /HEAD/i !~ @cgi.request_method
rescue Exception
	puts "Content-Type: text/plain\n\n"
	puts "#$! (#{$!.type})"
	puts ""
	puts $@.join( "\n" )
end

