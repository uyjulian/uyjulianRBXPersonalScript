
--This is currently broken because of BSON encoding
package.path = "./modules/?.lua;" .. package.path
file_util = require"file_util"

json = require"JSON"

file_util.writefile arg[1], string.format("local strings = game:service'HttpService':JSONDecode(%q)", file_util.readfile(arg[2])) .. file_util.readfile(arg[3])

