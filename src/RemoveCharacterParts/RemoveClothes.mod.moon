export modinfo = {
	type: "command"
	desc: "Remove Clothes"
	alias: {"noclothes"}
	func: getDoPlayersFunction (v) ->
		for i,j in pairs(v.Character\GetChildren()) 
			if j\IsA"Shirt" or j\IsA"Pants" or j\IsA"ShirtGraphic" 
				j.Parent = nil
}