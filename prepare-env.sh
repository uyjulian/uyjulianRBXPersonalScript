#!/bin/bash
# Root check
if [[ $EUID -ne 0 ]]; then
   echo "Please run with sudo:"
   echo "sudo prepare-env.sh" 
   exit 1
fi

# Install required packages
apt-get update
apt-get install luajit luarocks zlib1g-dev
luarocks install lzlib lua-parser serpent moonscript

# Fix moonscript to use luajit
sed -i 's!/usr/bin/lua5.1!/usr/bin/luajit!' `which moon`

echo "The environment has been prepared."
echo "You may now run 'make' to build the program."
