local M = {}

M.escapesh = function(str)
	local special = {"\"", '%$', '`', '\\', '!', '%*', '@'}
	
	for i, v in pairs(special) do
		local zz, zzz = str:gsub(v, "\"'" .. v .. "'\"")
		str = zz
	end
	local lel = "\"" .. str .. "\""
	return lel
end

M.shellargs = function(...)
	local a = {...}
	for i = 1, #a do
		a[i] = M.escapesh(a[i])
	end
	return table.concat(a, " ")
end

M.find = function(path, filename)
	local lol = io.popen(M.shellargs("find", path, "-name", filename))
	local stbl = {}
	for line in lol:lines() do
		table.insert(stbl, line)
	end
	return stbl
end

M.realpath = function(filename)
	local lol = io.popen(M.shellargs("realpath", filename))
	local lolo = lol:read("*l")
	lol:close()
	return lolo
end


M.readfile = function(filename)
	local lol = io.open(filename, "rb")
	if not lol then
		return
	end
	local lols = lol:read("*a")
	lol:close()
	return lols
end

M.writefile = function(filename, contents)
	local lol = io.open(filename, "wb")
	lol:write(contents)
	lol:close()
	return lols
end


return M
