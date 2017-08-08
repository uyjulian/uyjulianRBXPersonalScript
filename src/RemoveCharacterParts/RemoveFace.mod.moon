export modinfo = {
	type: "command"
	desc: "Remove Face"
	alias: {"noface"}
	func: getDoPlayersFunction (v) ->
		for i,j in pairs(v.Character.Head\GetChildren()) 
			if j\IsA"Decal" 
				j.Parent = nil
}