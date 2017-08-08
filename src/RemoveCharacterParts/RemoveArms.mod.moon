export modinfo = {
	type: "command"
	desc: "RemoveArms"
	alias: {"noarms"}
	func: getDoPlayersFunction (v) ->
		for i,j in pairs(v.Character\GetChildren())
			if j.Name == "Left Arm" or j.Name == "Right Arm"
				j.Parent = nil
}