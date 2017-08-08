export modinfo = {
	type: "command"
	desc: "Un Jail"
	alias: {"unjail"}
	func: getDoPlayersFunction (v) ->
		for Num,Jail in pairs(ConfigSystem("Get", "Jails"))
			if Jail.Player ~= nil and Jail.Player == v
				pcall ->
					Jail.Jail.Parent = nil
				table.remove(ConfigSystem("Get", "Jails"),Num)
}