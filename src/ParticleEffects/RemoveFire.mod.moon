export modinfo = {
	type: "command"
	desc: "UnFire"
	alias: {"unfire", "nofire"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			if v.Character\FindFirstChild("Torso")
				if v.Character.Torso\IsA"Part"
					for i,f in pairs(v.Character.Torso\GetChildren())
						if f\IsA"Fire"
							f.Parent = nil
							Output2(string.format("Removed fire from %s",v.Name),{Colors.Green})
							loggit(string.format("Removed fire from %s",v.Name))
}