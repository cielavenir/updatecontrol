#!/usr/bin/ruby
#updatecontrol by cielavenir.

arc=ARGV[0]||''
dir=ARGV[1]||'.'
if !File.file?(arc) || !File.directory?(dir)
	STDERR.puts 'updatecontrol arc [dir]'
	exit(1)
end
Dir.chdir(dir)
system('tar czf control.tar.gz *')
system('ar r "'+arc+'" control.tar.gz')
File.unlink('control.tar.gz')
