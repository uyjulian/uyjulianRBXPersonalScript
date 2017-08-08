package.path = "./modules/?.lua;" .. package.path
glue = require"glue"
z85 = require"z85"
zlib = require"zlib"

data = glue.readfile(arg[1])

fl = zlib.compress(data, #data, 9)

rmdr = (#fl) % 4
if rmdr ~= 0
	fl = fl .. string.rep("\0", 4 - rmdr)
assert((#fl) % 4 == 0)
lf = z85.to_z85(fl)

srcstub = glue.readfile(arg[2])
srcmn = glue.readfile(arg[3])

glue.writefile(arg[4], srcstub .. "\n" .. string.format("local strings = inflate64(%q)", lf) .. srcmn)

