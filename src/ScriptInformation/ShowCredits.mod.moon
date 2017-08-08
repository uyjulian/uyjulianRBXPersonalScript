export modinfo = {
	type: "command"
	desc: "Show credits"
	alias: {"cred"}
	func: (Msg,Speaker) ->
		for _,Cred in pairs(ConfigSystem("Get", "Credits"))
			Output(string.format("%s for %s.",Cred.Name, Cred.Why),{Color3.new(math.random(),math.random(),math.random())})
}