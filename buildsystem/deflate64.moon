package.path = "./modules/?.lua;" .. package.path
file_util = require"file_util"
z85 = require"z85"
zlib = require"zlib"

data = file_util.readfile(arg[1])

fl = zlib.compress(data, 9)

rmdr = (#fl) % 4
if rmdr ~= 0
	fl = fl .. string.rep("\0", 4 - rmdr)
assert((#fl) % 4 == 0)
lf = z85.to_z85(fl)

srcstub = file_util.readfile(arg[2])
srcmn = file_util.readfile(arg[3])

file_util.writefile(arg[4], srcstub .. "\n" .. string.format("local strings = inflate64(%q)", lf) .. srcmn)

