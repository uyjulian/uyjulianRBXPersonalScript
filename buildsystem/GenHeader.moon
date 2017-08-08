
--This code could be better by multithreading

package.path = "./modules/?.lua;" .. package.path

file_util = require"file_util"
moonscript = require"moonscript"
ast_util = require"ast_util"
json = require"JSON"
bson = require"bson"
serpent = require"serpent"

findDependentFunction = (ast) ->
	namez = {}
	
	recursive_search = (tbl) ->
		table_dump = {}
		for i = 1, #tbl
			v = tbl[i]
			if type(v) == "table"
				if (v.tag == "Call")
					--strout = findstr(v)
					if (v[1].tag == "String") or (v[1].tag == "Id")
						table.insert(namez, v[1][1])
				table.insert(table_dump, v)
		for i, v in pairs(table_dump) 
			recursive_search(v)

	recursive_search(ast)
	return namez

sort_tbl = (tbl) -> --real ugly sort function
	needs_resort = false
	bgn = {}
	edn = {}
	for i1, v1 in pairs(tbl)
		zzz = false
		for i2, v2 in pairs(tbl)
			if v1[1] ~= v2[1]
				if i1 < i2
					for i, v in pairs(v1[3])
						if v == v2[1]
							zzz = true
							needs_resort = true
		if zzz
			table.insert(edn, v1)
		else
			table.insert(bgn, v1)
	sss = {}
	for i, v in pairs(bgn)
		table.insert(sss, v)
	for i, v in pairs(edn)
		table.insert(sss, v)
	if needs_resort
		return sort_tbl(sss)
	else
		return sss

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
	table.insert(finstr, ast_util.reread(file_util.readfile(v)))

for i, v in pairs(Init_mod)
	moon_lua, err = moonscript.to_lua(file_util.readfile(v)) --currently linemapping not support
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
		-- else
		-- 	error("unknown key: " .. i[1])
	if modtype ~= "function"
		continue
		--error("invalid modtype: " .. modtype)
	table.insert(funct, {modid, modfunc, findDependentFunction(ast), genLocalFunction(modid, modfunc)})

for i, v in pairs(PostInit)
	table.insert(finftr, ast_util.reread(file_util.readfile(v)))

for i, v in pairs(sort_tbl(funct))
	table.insert(finstr, ast_util.ast_to_code(v[4]))

file_util.writefile(arg[1], table.concat(finstr, "\n"))
file_util.writefile(arg[2], table.concat(finftr, "\n"))
