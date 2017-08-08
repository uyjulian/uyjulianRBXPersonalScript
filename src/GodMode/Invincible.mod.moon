export modinfo = {
	type: "command"
	desc: "Invincible"
	alias: {"epic", "invincible"}
	func: getDoPlayersFunction (v) ->
		if v.Character ~= nil
			for i,s in pairs(v.Character\GetChildren())
				if s\IsA"Part"
					s.Reflectance = 1
				elseif s\IsA"Humanoid"
					s.Health = math.huge
					s.MaxHealth = math.huge
					Output(string.format("Epicized %s",v.Name),{Colors.Green})
					loggit(string.format("Epicized %s",v.Name))
}