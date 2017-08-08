export modinfo = {
	type: "command"
	desc: "Remove Legs"
	alias: {"nolegs"}
	func: getDoPlayersFunction (v) ->
		for i,j in pairs(v.Character\GetChildren())
			if j.Name == "Left Leg" or j.Name == "Right Leg"
				j.Parent = nil
}