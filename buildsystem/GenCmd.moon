package.path = "./modules/?.lua;" .. package.path
glue = require"glue"
file_util = require"file_util"
ast_util = require"ast_util"

ms = require "moonscript.base"
CmdsMod = file_util.find("src", "*.mod.moon")

appendFS = (...) ->
	dirs = {...}
	return table.concat(dirs, "/")

ast_get_modinfo = (ast) ->
	local function_name, function_function
	for i, v in ipairs(ast)
		if v.tag == "Set"
			if v[1][1].tag == "Id"
				if v[2][1].tag == "Table"
					if v[1][1][1] == "modinfo"
						return v[2][1]

for i, v in pairs(CmdsMod)
	moon_lua, err = ms.to_lua(glue.readfile(v)) --currently linemapping not support
	if not moon_lua
		print v .. ": " .. err
		os.exit(1)
	ast = ast_util.code_to_ast(moon_lua)
	modtype = nil
	moddesc = nil
	modalias = nil
	modfunc = nil
	for i, v in ast_util.ast_pairs(ast_get_modinfo(ast))
		if i[1] == "type"
			modtype = ast_util.ast_to_obj(v)
		elseif i[1] == "desc"
			moddesc = ast_util.ast_to_obj(v)
		elseif i[1] == "alias"
			modalias = ast_util.ast_to_obj(v)
		elseif i[1] == "func"
			modfunc = v
	if modtype ~= "command"
		continue
	OutAddCommandAst = ast_util.new_ast_node("Call", ast_util.new_ast_node("Id", "AddCommand"), ast_util.new_ast_node("String", moddesc), ast_util.new_ast_node("String", modalias[1]), modfunc)
	glue.writefile(string.format("%s/%s.cmd.lua", arg[1], i .. "_ncmd"), ast_util.ast_to_code(OutAddCommandAst))


