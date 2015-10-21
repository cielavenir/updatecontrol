## updatecontrol

Package control script modifier

### updatecontrol.rb
- dpkg control.tar.gz replacer

### updatecontrol.sh
- dpkg control.tar.gz replacer
  - realpath is required, but ruby is not required. Originally for Cydia.

#### Usage
- updatecontrol arc [dir]

### updatepkgscripts.rb
- OSX pkg inside.pkg/Scripts replacer/extracter
  - You can also use it as unpkg.

#### Usage
- updatepkgscripts -u arc entry [dir]
  - arc's "entry" is replaced with inside dir.
- updatepkgscripts -x arc entry [dir]
  - arc's "entry" is extracted to dir.
- To investigate about entry, use `tar -tf`.
