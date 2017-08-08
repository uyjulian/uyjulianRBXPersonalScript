export modinfo = {
	type: "command"
	desc: "Remove ForceField"
	alias: {"unff"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			for i,f in pairs(v.Character\GetChildren())
				if f\IsA"ForceField"
					f.Parent = nil
					Output4(string.format("Removed forcefield from %s",v.Name),{Colors.Green})
					loggit(string.format("Removed forcefield from %s",v.Name))
}