export modinfo = {
	type: "command"
	desc: "Sparkles"
	alias: {"sparkles"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			if v.Character\FindFirstChild("Torso")
				CreateInstance"Sparkles"{
					Parent: v.Character.Torso
				}
				Output2(string.format("Gave sparkles to %s",v.Name),{Colors.Green})
}