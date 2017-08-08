export modinfo = {
	type: "command"
	desc: "Ping"
	alias: {"ping"}
	func: (Msg,Speaker) ->
		rtn = {}
		fty = {}
		if #Msg == 0
			table.insert(rtn,"Options: plog, log, atmp, ver, sn")
		elseif Msg\sub(1,2) == "a;" 
			table.insert(rtn,tostring(loadstring(string.format("return %s",Msg\sub(3)))()))
		elseif Msg == "plog"
			for i,p in pairs(ConfigSystem("Get", "PlayerLog"))
				Output(p,{Colors.Red})
		elseif Msg == "log"
			for _,v in pairs(ConfigSystem("Get", "Log")) 
				table.insert(rtn,v) 
			Output("Most Recent here",{Colors.Black})
		elseif Msg == "atmp"
			rtn = [v for _,v in pairs(ConfigSystem("Get", "AttemptedJoinList"))]
		elseif Msg == "ver"
			Output(string.format("Version of this script: %s",ConfigSystem("Get", "Version")),{Colors.Orange})
		elseif Msg == "sn"
			Output(string.format("The script's name is: %s",Name),{Colors.Orange})
		else
			table.insert(rtn,Msg)
		for _,m in pairs(rtn)
			Output(m,{Color3.new(1,1,1)})
}