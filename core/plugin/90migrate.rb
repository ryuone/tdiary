#
# migrate.rb: tDiary plugin for migration 2.2 to 2.3.
#

unless @conf.tdiary_version
	def convert_pstore( file )
		require "pstore"
	
		db = PStore.new( file )
		begin
			roots = db.transaction{ db.roots }
		rescue ArgumentError
			if /\Aundefined class\/module (.+?)(::)?\z/ =~ $!.message
				klass = $1
				if /EmptdiaryString\z/ =~ klass
					eval( "class #{klass} < String; end" )
				else
					eval( "class #{klass}; end" )
				end
				retry
			end
		end
		db.transaction do
			roots.each do |root|
				convert_element( db[root] )
			end
		end
	end
	
	def convert_element( data )
		case data
		when Hash, Array
			data.each_with_index do |e, i|
				if String === e
					data[i] = @conf.migrate_to_utf8( e )
				else
					convert_element( e )
				end
			end
		else
			data.instance_variables.each do |e|
				var = data.instance_variable_get( e )
				if String === var
					data.instance_variable_set( e, @conf.migrate_to_utf8( var ) )
				else
					convert_element( var )
				end
			end
		end
	end

	require "fileutils"

	# convert tdiary.conf in @data_path
	begin
		conf_path = "#{@conf.data_path}tdiary.conf"
		conf = File::open( conf_path ){|f| @conf.migrate_to_utf8( f.read ) }
		conf.gsub!(/(\\[0-9]{3})+/) do |str|
			@conf.migrate_to_utf8( eval( %Q["#{$&}"] ) ).dump[1...-1]
		end
	rescue
	end
	File::open( conf_path, 'w' ) do |o|
		o.puts %Q!tdiary_version = "#{TDIARY_VERSION}"!
		o.print( conf ) if conf
	end

	# convert pstore cache files of plugins
	dir = @conf.cache_path || "#{@data_path}cache"
	%w(makerss.cache recent_comments recent_trackbacks tlink/tlink.dat).each do |e|
		convert_pstore( "#{dir}/#{e}" ) if File.exist?( "#{dir}/#{e}" )
	end
	Dir["#{dir}/disp_referrer2.d/*"].each do |file|
		convert_pstore( file )
	end
	Dir["#{@data_path}category/*"].each do |file|
		convert_pstore( file )
	end

	# rename category cache files
	Dir["#{@data_path}category/*"].each do |file|
		dirname, basename = File.split( file )
		new_basename = u( @conf.migrate_to_utf8( CGI::unescape( basename ) ) )
		FileUtils.mv( file, File.join( dirname, new_basename ) ) unless basename == new_basename
	end

	# remove ruby/erb cache files
	Dir["#{dir}/*.rb"].each{|f| FileUtils.rm_f( f )}
	Dir["#{dir}/*.parser"].each{|f| FileUtils.rm_f( f )}

end
