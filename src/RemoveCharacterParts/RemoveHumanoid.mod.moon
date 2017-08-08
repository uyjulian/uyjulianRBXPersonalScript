export modinfo = {
	type: "command"
	desc: "Remove Humanoid"
	alias: {"rhum"}
	func: getDoPlayersFunction (v) ->
		if v.Character.Humanoid 
			v.Character.Humanoid.Parent = nil
			Output(string.format("Removed humanoid of %s",v.Name),{Colors.Green})
			loggit(string.format("Removed humanoid of %s",v.Name))
}