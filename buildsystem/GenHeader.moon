
--This code could be better by multithreading

package.path = "./modules/?.lua;" .. package.path

glue = require"glue"
file_util = require"file_util"
moonscript = require"moonscript"
ast_util = require"ast_util"

findDependentFunction = (ast) ->
	namez = {}

	asts = {}

	search = (tbl) ->
		for i, v in pairs(tbl)
			if type(v) == "table"
				if (v.tag == "Call")
					if (v[1].tag == "String") or (v[1].tag == "Id")
						table.insert(namez, v[1][1])
				table.insert(asts, v)

	search(ast)

	while #asts ~= 0
		asts_working = asts
		asts = {}
		for i, v in pairs(asts_working) 
			search(v)
	return namez

sort_tbl = (tbl) -> --kind of ugly sort function
	sorted = {}
	for i, v in pairs(tbl)
		breakme = false
		for ii, vv in ipairs(sorted)
			for iii, vvv in pairs(vv[3])
				if v[1] == vvv
					table.insert(sorted, ii - 1, v)
					tbl[i] = nil
					breakme = true
					break
			if breakme
				break
		if not breakme
			table.insert(sorted, v)
			tbl[i] = nil
	return sorted

genLocalFunction = (Id, Function) ->
	return ast_util.new_ast_node("Localrec", ast_util.new_ast_node("Block", ast_util.new_ast_node("Id", Id)), ast_util.new_ast_node("Block", Function))

genGlobalFunction = (Id, Function) ->
	return ast_util.new_ast_node("Set", ast_util.new_ast_node("Block", ast_util.new_ast_node("Id", Id)), ast_util.new_ast_node("Block", Function))

ast_get_modinfo = (ast) ->
	local function_name, function_function
	for i, v in ipairs(ast)
		if v.tag == "Set"
			if v[1][1].tag == "Id"
				if v[2][1].tag == "Table"
					if v[1][1][1] == "modinfo"
						return v[2][1]

finstr = {}
finftr = {}

Preinit = file_util.find("HeaderSrc/PreInit", "*.lua")
Init_mod = file_util.find("src", "*.mod.moon")
PostInit = file_util.find("HeaderSrc/PostInit", "*.lua")

funcs = {}

funct = {}
funcu = {}

for i, v in pairs(Preinit)
	table.insert(finstr, ast_util.reread(glue.readfile(v)))

for i, v in pairs(Init_mod)
	moon_lua, err = moonscript.to_lua(glue.readfile(v)) --currently linemapping not support
	if not moon_lua
		print v .. ": " .. err
		os.exit(1)
	ast = ast_util.code_to_ast(moon_lua)
	modtype = nil
	modid = nil
	modfunc = nil
	for i, v in ast_util.ast_pairs(ast_get_modinfo(ast))
		if i[1] == "type"
			modtype = v[1]
		elseif i[1] == "id"
			modid = v[1]
		elseif i[1] == "func"
			modfunc = v
	if modtype ~= "function"
		continue
	table.insert(funct, {modid, modfunc, findDependentFunction(ast), genLocalFunction(modid, modfunc)})

for i, v in pairs(PostInit)
	table.insert(finftr, ast_util.reread(glue.readfile(v)))

for i, v in pairs(sort_tbl(funct))
	table.insert(finstr, ast_util.ast_to_code(v[4]))

glue.writefile(arg[1], table.concat(finstr, "\n"))
glue.writefile(arg[2], table.concat(finftr, "\n"))
