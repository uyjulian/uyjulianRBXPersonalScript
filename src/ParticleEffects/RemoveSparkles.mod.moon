export modinfo = {
	type: "command"
	desc: "UnSparkles"
	alias: {"unsparkles", "nosparkles", "unsp", "nosp"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			if v.Character\FindFirstChild("Torso")
				if v.Character.Torso\IsA"Part"
					for i,f in pairs(v.Character.Torso\GetChildren()) 
						if f\IsA"Sparkles"
							f.Parent = nil
							Output2(string.format("Removed sparkles from %s",v.Name),{Colors.Green})
							loggit(string.format("Removed sparkles from %s",v.Name))
}