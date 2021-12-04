#!/bin/sh
#updatecontrol by cielavenir.

arc="$1"
dir="$2"
if [ "x$dir" = "x" ];then
  dir="."
fi
arc=`realpath "$arc" 2>/dev/null`
dir=`realpath "$dir" 2>/dev/null`
if [ "x$arc" = "x" ] || [ "x$dir" = "x" ];then
  echo updatecontrol arc [dir]
  exit 1
fi
cd "$dir"
tar czf control.tar.gz *
ar r "$arc" control.tar.gz
rm control.tar.gz
