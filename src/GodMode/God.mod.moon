export modinfo = {
	type: "command"
	desc: "God"
	alias: {"god"}
	func: getDoPlayersFunction (v) ->
		if v.Character ~= nil
			for i,s in pairs(v.Character\GetChildren())
				if s\IsA"Humanoid"
					s.Health = math.huge
					s.MaxHealth = math.huge
					Output(string.format("Godded %s",v.Name),{Colors.Green})
					loggit(string.format("Godded %s",v.Name))
}