local M = {}

local parser = require"lua-parser.parser"

local ast_to_src = require"ast_to_src"

--additional args in lua-parser:
--pos: offset in source code
--tag: reference this:
-- block: { stat* }
-- stat:
--   `Do{ stat* }
--   | `Set{ {lhs+} {expr+} }                    -- lhs1, lhs2... = e1, e2...
--   | `While{ expr block }                      -- while e do b end
--   | `Repeat{ block expr }                     -- repeat b until e
--   | `If{ (expr block)+ block? }               -- if e1 then b1 [elseif e2 then b2] ... [else bn] end
--   | `Fornum{ ident expr expr expr? block }    -- for ident = e, e[, e] do b end
--   | `Forin{ {ident+} {expr+} block }          -- for i1, i2... in e1, e2... do b end
--   | `Local{ {ident+} {expr+}? }               -- local i1, i2... = e1, e2...
--   | `Localrec{ {ident} {expr} }               -- only used for 'local function'
--   | `Goto{ <string> }                         -- goto str
--   | `Label{ <string> }                        -- ::str::
--   | `Return{ <expr*> }                        -- return e1, e2...
--   | `Break                                    -- break
--   | apply
-- expr:
--   `Nil
--   | `Dots
--   | `True
--   | `False
--   | `Number{ <number> }
--   | `String{ <string> }
--   | `Function{ { `Id{ <string> }* `Dots? } block }
--   | `Table{ ( `Pair{ expr expr } | expr )* }
--   | `Op{ opid expr expr? }
--   | `Paren{ expr }       -- significant to cut multiple values returns
--   | apply
--   | lhs
-- apply:
--   `Call{ expr expr* }
--   | `Invoke{ expr `String{ <string> } expr* }
-- lhs: `Id{ <string> } | `Index{ expr expr }
-- opid: 'add' | 'sub' | 'mul' | 'div' | 'idiv' | 'mod' | 'pow' | 'concat'
--   | 'band' | 'bor' | 'bxor' | 'shl' | 'shr' | 'eq' | 'lt' | 'le'
--   | 'and' | 'or' | 'not' | 'unm' | 'len' | 'bnot'

M.new_ast_node = function(...)
	local info = {...}
	local ret = {}

	for i = 2, #info do
		table.insert(ret, info[i])
	end
	if info[1] == "Block" then
		--do nothing
	else
		ret.tag = info[1] -- currently no error checking
	end
	ret.pos = -1 --indicating this was modded
	return ret
end

M.code_to_ast = function(code)

	local t, m = parser.parse(code, "string")
	if not t then
		print(code)
		error(m)
	end
	return t
end

M.ast_to_code = function(ast)
	--local lol = fishs.ast_to_code(ast)
	--print(lol)
	return ast_to_src(ast)
end

M.ast_to_obj = function(ast)
	if ast.tag == 'String' or ast.tag == 'Number' then
		return ast[1]
	elseif ast.tag == 'Nil' then 
		return nil
	elseif ast.tag == 'False' then 
		return false
	elseif ast.tag == 'True' then 
		return true
	else --take the lazy way out
		local code = M.ast_to_code(ast)
		local func = assert(loadstring('return ' .. code))
		return func()
	end
end

M.obj_to_ast = function(obj)
	if type(obj) == 'string' then
		return M.new_ast_node("String", obj)
	elseif type(obj) == 'number' then
		return M.new_ast_node("Number", obj)
	elseif obj == nil then
		return M.new_ast_node("Nil")
	elseif obj == false then
		return M.new_ast_node("False")
	elseif obj == true then
		return M.new_ast_node("True")
	elseif type(obj) == 'table' then --no recursive check
		local pair = {}
		for i, v in pairs(obj) do
			table.insert(pair, M.new_ast_node("Pair", M.obj_to_ast(i), M.obj_to_ast(v)))
		end
		return M.new_ast_node("Table", unpack(pair))
	else
		error("unimpl " .. tostring(obj))
	end
end

M.ast_pairs = function(ast)
	if ast.tag ~= "Table" then
		error("not a table!")
	end
	local i = 0
	local nonpair = 0
	local iterator = function()
		i = i + 1
		if not ast[i] then return end
		local tag = ast[i].tag
		local key, value
		if tag == "Pair" then
			key = ast[i][1]
			value = ast[i][2]
		else
			nonpair = nonpair + 1
			key = nonpair
			value = ast[i]
		end
		return key, value
	end
	return iterator
end

M.ast_ipairs = function(ast)
	error("unimpl")
end

M.ast_to_bin = function(ast)
	error("unimpl")
end

M.bin_to_ast = function(bin)
	error("unimpl")
end

M.reread = function(str)
	return M.ast_to_code(M.code_to_ast(str))
end

return M