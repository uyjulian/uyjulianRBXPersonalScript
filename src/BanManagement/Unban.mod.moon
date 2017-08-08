export modinfo = {
	type: "command"
	desc: "UnBan"
	alias: {"unban"}
	func: (Msg,Speaker) ->
		for i,s in pairs(ConfigSystem("Get", "BanList")) 
			if string.sub(string.lower(s), 1, #Msg) == string.lower(Msg) 
				table.remove(ConfigSystem("Get", "BanList"), i)
				Output(string.format("Unbanned %s",s),{Colors.Green})
				loggit(string.format("Unbanned %s",s))
}