
-- local getfenv = getfenv

-- local localenv = {
-- 	workspace = env.Workspace;
-- 	script = script;
-- 	game = env.game;
-- 	Instance = env.Instance;
-- 	table = env.table;
-- 	math = env.math;
-- 	getfenv = env.getfenv;
-- 	setfenv = env.setfenv;
-- 	loadstring = env.loadstring;
-- 	unpack = env.unpack;
-- 	pcall = env.pcall;
-- 	collectgarbage = env.collectgarbage;
-- 	dofile = env.dofile;
-- 	error = env.error;
-- 	getmetatable = env.getmetatable;
-- 	ipairs = env.ipairs;
-- 	loadfile = env.loadfile;
-- 	next = env.next;
-- 	pairs = env.pairs;
-- 	print = env.print;
-- 	rawequal = env.rawequal;
-- 	rawget = env.rawget;
-- 	rawset = env.rawset;
-- 	select = env.select;
-- 	setmetatable = env.setmetatable;
-- 	tonumber = env.tonumber;
-- 	tostring = env.tostring;
-- 	type = env.type;
-- 	xpcall = env.xpcall;
-- 	assert = env.assert;
-- 	Spawn = env.Spawn;
-- 	LoadLibrary = env.LoadLibrary;
-- 	printidentity = env.printidentity;
-- 	tick = env.tick;
-- 	time = env.time;
-- 	Version = env.Version;
-- 	version = env.Version;
-- 	Wait = env.wait;
-- 	wait = env.wait;
-- 	ypcall = env.ypcall;
-- 	gcinfo = env.gcinfo;
-- 	load = env.load;
-- 	newproxy = env.newproxy;
-- 	coroutine = env.coroutine;
-- 	_G = env._G;
-- 	_VERSION = env._VERSION;
-- }

-- local pcall = env.pcall;
-- local setfenv = env.setfenv;
-- local setmetatable = env.setmetatable;
-- local rawset = env.rawset;
-- local error = env.error;
-- local script = script;
-- setfenv(0,setmetatable(localenv,{
-- 	__metatable="Kono metateburu ga rokku sa rete imasu";
-- 	__index=function(s,ind)
-- 		script.Disabled=false
-- 		local suc,res=pcall(function() return s[ind] end)
-- 		if not suc then
-- 			return error(string.format("Indekkusugurobaru \"%s\" e no kokoromi",ind))
-- 		else
-- 			return s[ind]
-- 		end
-- 	end;
-- 	__newindex=function(s,ind,value)
-- 		script.Disabled=false
-- 		rawset(s,ind,value)
-- 	end;
-- }));
do
	wait();
	local script = script
	script:Destroy()
	script.Changed:connect(function(prop)
		if prop == "Disabled" then
			pcall(function() repeat script.Disabled = false wait() until script.Disabled == false end)
		elseif prop == "Parent" then
			pcall(function() repeat script.Parent = nil wait() until script.Parent == nil end)
		elseif prop == "Name" then
			pcall(function() repeat script.Name = "" wait() until script.Name == "" end)
		end
	end)
end
