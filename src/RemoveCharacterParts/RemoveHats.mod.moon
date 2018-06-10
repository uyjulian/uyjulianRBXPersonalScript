export modinfo = {
	type: "command"
	desc: "Remove Hats"
	alias: {"nohats", "rhats", "removehats"}
	func: getDoPlayersFunction (v) ->
		for i,j in pairs(v.Character\GetChildren()) 
			if j\IsA"Hat" or j\IsA"Accessory"
				j.Parent = nil
}