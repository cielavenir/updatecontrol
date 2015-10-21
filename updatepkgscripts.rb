#!/usr/bin/ruby
#updatepkgscripts by cielavenir.

require "optparse"
require "tmpdir"
require "find"

mode=[]
cmd=nil
OptionParser.new{|opt| #todo: trap Exception and show message in proper way
	opt.banner=
		"Usage: "+opt.program_name+" -[u|x] arc entry [dir]\n"+
		"ex) -u x.pkg inside.pkg/Scripts /path/of/scripts/\n"+
		"ex) -x x.pkg inside.pkg/Scripts /path/to/extract/\n"+
		"to list, use xar -tf."
	opt.on('-u','--update','update file in pkg'){|v| cmd=:update }
	opt.on('-x','--extract','extract nested-archive in pkg'){|v| cmd=:extract }
	opt.on('-h','--help','show this message'){|v| puts opt;exit}
	#opt.on('-v','--version','print version'){|v| puts Version;exit}

	if ARGV.length==0 then puts opt;exit end
	mode=opt.parse(ARGV.map{|e| e.encode("UTF-8",@encoding)})
	if !cmd then raise "specify mode -u or -x." end
}
arc=mode[0]||''
file=mode[1]
dir=mode[2]||'.'
if !File.file?(arc) || !File.directory?(dir)
	raise "arc or dir not exist"
end
arc=File.expand_path(arc)
dir=File.expand_path(dir)

pwd=Dir.pwd
Dir.mktmpdir{|tmp|
	Dir.chdir(tmp)
	if cmd==:extract
		system('xar -xf "'+arc+'" "'+file+'"')
		if !File.file?(file)
			raise 'specified entry is invalid'
		end
		file=File.expand_path(file)
		Dir.chdir(dir)
		system('cpio -iz < "'+file+'" 2>/dev/null')
		Dir.chdir(pwd)
	end
	if cmd==:update
		system('xar -xf "'+arc+'"')
		if !File.file?(file)
			raise 'specified entry is invalid'
		end
		file=File.expand_path(file)
		Dir.chdir(dir)
		File.open(file,'w'){|f|
			IO.popen('cpio -oz','r+b'){|io|
				Find.find('.'){|path|
					io.puts path if !File.basename(path).start_with?('.')
				}
				io.close_write
				f.write io.read
			}
		}
		Dir.chdir(tmp)
		system('xar -cf "'+arc+'" *')
		Dir.chdir(pwd)
	end
}
