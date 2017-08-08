package.path = "./modules/?.lua;" .. package.path
glue = require"glue"
ast_util = require"ast_util"

JSON = require"JSON"
bson = require"bson"
configtable = JSON\decode(glue.readfile(arg[1]))
outtable = {}

for i1, v1 in pairs(configtable)
	curVariable = ""
	if v1["type"] == "number"
		curVariable = ast_util.obj_to_ast(v1.value)
	elseif v1["type"] == "string"
		curVariable = ast_util.obj_to_ast(v1.value)
	elseif v1["type"] == "BrickColor"
		curVariable = ast_util.new_ast_node("Call", ast_util.new_ast_node("Index", ast_util.new_ast_node("Id", "BrickColor"), ast_util.new_ast_node("String", "new")), ast_util.new_ast_node("String", v1.value))
	elseif v1["type"] == "Color3"
		curVariable = ast_util.new_ast_node("Call", ast_util.new_ast_node("Index", ast_util.new_ast_node("Id", "Color3"), ast_util.new_ast_node("String", "new")), ast_util.new_ast_node("Number", v1.value[1]), ast_util.new_ast_node("Number", v1.value[2]), ast_util.new_ast_node("Number", v1.value[3]))
	elseif v1["type"] == "boolean"
		curVariable = ast_util.obj_to_ast(v1.value)
	elseif v1["type"] == "table"
		curVariable = ast_util.obj_to_ast(v1.value)
	elseif v1["type"] == "instance"
		curVariable = ast_util.new_ast_node("Nil")
	else
		error("unknown type")
	table.insert(outtable, ast_util.new_ast_node("Call", ast_util.new_ast_node("Id", "ConfigSystem"), ast_util.new_ast_node("String", "Set"), ast_util.new_ast_node("String", i1), curVariable))

glue.writefile(arg[2], ast_util.ast_to_code(outtable))

