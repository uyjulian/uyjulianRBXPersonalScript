package.path = "./modules/?.lua;" .. package.path

strs = {}

file_util = require"file_util"
ast_util = require"ast_util"
ast = ast_util.code_to_ast(file_util.readfile(arg[1]))

strtbl = (str) ->
	pos = nil
	for i, v in pairs(strs)
		if v == str
			pos = i
			break
	if not pos
		pos = #strs + 1
		table.insert(strs, pos, str)
	return pos

findstr = (tbl) ->
	for i, v in pairs(tbl)
		if type(v) == "string"
			return v

checkBad = (i, v, tbl) ->
	if tbl.tag ~= "Invoke"
		return true
	if i == 2
		return false --Invokes need to be modded before the string can be encoded

	return true

modTag = (num) ->
	return ast_util.new_ast_node("Index", ast_util.new_ast_node("Id", "strings"), ast_util.new_ast_node("Number", num))

modInvoke = (tel) ->
	return ast_util.new_ast_node("Call", ast_util.new_ast_node("Id", "Invoke"), unpack(tel))

modAst = (ast) ->
	asts = {}

	search = (tbl) ->
		modding = {}
		for i, v in pairs(tbl)
			if type(v) == "table"
				if (v.tag == "String") and checkBad(i, v, tbl)
					strout = findstr(v)
					modding[i] = modTag(strtbl(strout)) --replace it
				elseif v.tag == "Invoke"
					modding[i] = modInvoke(v)
					table.insert(asts, tbl) --look again
				else
					table.insert(asts, v)
		for i, v in pairs(modding)
			tbl[i] = v

	search(ast)

	while #asts ~= 0
		asts_working = asts
		asts = {}
		for i, v in pairs(asts_working)
			search(v)

modAst ast

bson = require"bson_tiny"

file_util.writefile(arg[2], ast_util.ast_to_code(ast))
file_util.writefile(arg[3], bson.encode(strs))
