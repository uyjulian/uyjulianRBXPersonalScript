uyjulianRBXPersonalScript
=========================

[![Build Status](https://travis-ci.org/uyjulian/uyjulianRBXPersonalScript.svg?branch=master)](https://travis-ci.org/uyjulian/uyjulianRBXPersonalScript)  

This is the obfuscation modules isolated from the main script.  
Place your script in 00Your_Input.lua.  
Your obfuscated script will be in bin/00Your_Output.lua after running `make`.  
Before compiling this script, be sure to have luajit, moonscript, lua-zlib, zlib1g-dev, lua-parser, and serpent installed. You can run `sudo bash prepare-env.sh` to install these tools for you.  
Run `make` in this directory to compile the script. If you want to use multiple cores of your CPU, use `make -j2` where `2` is the number of cores that you want to use. The script will be located at `bin/uyjulianRBXPersonScript.lua` once it is finished compiling.  
All source files are licensed under the MIT license, unless otherwise specified in the source file.  
Please read the LICENSE file for more information about the MIT license.  
