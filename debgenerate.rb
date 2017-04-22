#!/usr/bin/ruby
if ARGV.size<2
	STDERR.puts 'debgenerate PACKAGE VERSION'
	exit
end

require 'fileutils'
PACKAGE,VERSION=ARGV
EMPTY_TAR_GZ="\x1f\x8b\x08\x00\xe4\x55\xf9\x58\x02\x03\xed\xc1\x01\x0d\x00\x00\x00\xc2\xa0\xf7\x4f\x6d\x0e\x37\xa0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x37\x03\x9a\xde\x1d\x27\x00\x28\x00\x00"
DIR_NAME='__tmp__debgenerate__'+PACKAGE
Dir.mkdir(DIR_NAME)
Dir.chdir(DIR_NAME)
File.write('control',DATA.read.gsub('__PACKAGE__',PACKAGE).gsub('__VERSION__',VERSION))
system('tar -czf control.tar.gz control')
File.unlink('control')
File.open('data.tar.gz','wb'){|f|f.write(EMPTY_TAR_GZ)}
File.open('debian-binary','wb'){|f|f.write("2.0\n")}
system("ar crus ../#{PACKAGE}_#{VERSION}_all.deb debian-binary control.tar.gz data.tar.gz")
Dir.chdir('..')
FileUtils.rm_rf(DIR_NAME)

__END__
Package: __PACKAGE__
Version: __VERSION__
Architecture: all
Maintainer: debgenerate
Description: Fake Package __PACKAGE__
 Fake Package __PACKAGE__
