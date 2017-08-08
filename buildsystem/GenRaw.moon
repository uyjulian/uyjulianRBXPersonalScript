package.path = "./modules/?.lua;" .. package.path
glue = require"glue"
file_util = require"file_util"
hdr = arg[1]
cfg = arg[2]
cmds = file_util.find(arg[3], "*.cmd.lua")
ftr = arg[4]
out = arg[5]

str = ""
str = str .. glue.readfile(hdr) .. "\n"
str = str .. glue.readfile(cfg) .. "\n"
for i, v in pairs(cmds)
	str = str .. glue.readfile(v) .. "\n"
str = str .. glue.readfile(ftr) .. "\n"

glue.writefile(out, str)
