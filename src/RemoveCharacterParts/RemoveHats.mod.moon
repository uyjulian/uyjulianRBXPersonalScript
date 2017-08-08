export modinfo = {
	type: "command"
	desc: "Remove Hats"
	alias: {"nohats"}
	func: getDoPlayersFunction (v) ->
		for i,j in pairs(v.Character\GetChildren()) 
			if j\IsA"Hat" 
				j.Parent = nil
}