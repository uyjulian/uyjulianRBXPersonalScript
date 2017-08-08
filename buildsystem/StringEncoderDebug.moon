
--This is currently broken because of BSON encoding
package.path = "./modules/?.lua;" .. package.path
glue = require"glue"

json = require"JSON"

glue.writefile arg[1], string.format("local strings = game:service'HttpService':JSONDecode(%q)", glue.readfile(arg[2])) .. glue.readfile(arg[3])

