export modinfo = {
	type: "command"
	desc: "Fire"
	alias: {"fire"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			if v.Character\FindFirstChild("Torso")
				if v.Character.Torso\IsA"Part"
					CreateInstance"Fire"{
						Parent: v.Character.Torso
					}
					Output4(string.format("Caught %s on fire",v.Name),{Colors.Green})
					loggit(string.format("Caught %s on fire",v.Name))
}