export modinfo = {
	type: "command"
	desc: "Freeze"
	alias: {"freeze"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			for i,s in pairs(v.Character\GetChildren())
				if s\IsA"BasePart"
					s.Anchored = true
					s.Reflectance = 1
					Output(string.format("Froze %s",v.Name),{Colors.Green})
}