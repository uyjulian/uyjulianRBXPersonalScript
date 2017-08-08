package.path = "./modules/?.lua;" .. package.path
file_util = require"file_util"
json = require"JSON"
hdr = arg[1]
cfg = arg[2]
cmds = file_util.find(arg[3], "*.cmd.lua")
ftr = arg[4]
out = arg[5]

str = ""
str = str .. file_util.readfile(hdr) .. "\n"
str = str .. file_util.readfile(cfg) .. "\n"
for i, v in pairs(cmds)
	str = str .. file_util.readfile(v) .. "\n"
str = str .. file_util.readfile(ftr) .. "\n"

file_util.writefile(out, str)
