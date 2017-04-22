#!/usr/bin/ruby
#updatecontrol by cielavenir.

arc=File.expand_path(ARGV[0]||'')
dir=File.expand_path(ARGV[1]||'.')
if !File.file?(arc) || !File.directory?(dir)
	STDERR.puts 'updatecontrol arc [dir]'
	exit(1)
end
Dir.chdir(dir)
system('tar czf control.tar.gz *')
system('ar r "'+arc+'" control.tar.gz')
File.unlink('control.tar.gz')
