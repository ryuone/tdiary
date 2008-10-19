# inspired from ramaze(lib/ramaze/snippets/kernel/__dir__.rb)
module Kernel
	unless defined? __DIR__
		def __DIR__
			filename = caller.first[/^(.+?):.+/, 1]
			File.expand_path(File.dirname(filename))
		end
	end
end
