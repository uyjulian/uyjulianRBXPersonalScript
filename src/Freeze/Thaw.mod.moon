export modinfo = {
	type: "command"
	desc: "Thaw"
	alias: {"thaw"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			for i,s in pairs(v.Character\GetChildren())
				if s\IsA"BasePart"
					s.Anchored = false
					s.Reflectance = 0
					Output(string.format("Thawed %s",v.Name),{Colors.Green})
}