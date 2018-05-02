#!/bin/bash
# Root check
if [[ $EUID -ne 0 ]]; then
   echo "Please run with sudo:"
   echo "sudo ./prepare-env.sh" 
   exit 1
fi

# Install required packages
apt-get -y update
apt-get -y install luajit luarocks zlib1g zlib1g-dev
luarocks install lua-zlib
luarocks install lua-parser
luarocks install serpent
luarocks install moonscript
luarocks install luasrcdiet

# Fix moonscript and LuaSrcDiet to use LuaJIT
sed -i 's!/usr/bin/lua5.1!/usr/bin/luajit!' `which moon` `which luasrcdiet`
# Fix moonscript to use LPegLabel, otherwise segmentation faults occur
sed -i 's!require("lpeg")!require("lpeglabel")!g' /usr/local/share/lua/5.1/moonscript/errors.lua /usr/local/share/lua/5.1/moonscript/parse.lua /usr/local/share/lua/5.1/moonscript/parse/env.lua /usr/local/share/lua/5.1/moonscript/parse/literals.lua /usr/local/share/lua/5.1/moonscript/parse/util.lua
# Fix lua-parser being broken with latest LPegLabel
sed -i 's!local errpos = #subject-#sfail!local errpos = sfail!' /usr/local/share/lua/5.1/lua-parser/parser.lua

echo "The environment has been prepared."
echo "You may now run 'make' to build the program."
