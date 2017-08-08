export modinfo = {
	type: "command"
	desc: "Sit"
	alias: {"sit"}
	func: getDoPlayersFunction (v) ->
		for i,j in pairs(v.Character\GetChildren()) 
			if j\IsA"Humanoid" 
				j.Sit = true 
				Output2(string.format("Made %s sit.",j.Name),{Colors.Green})
}