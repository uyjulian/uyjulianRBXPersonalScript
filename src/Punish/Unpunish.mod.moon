export modinfo = {
	type: "command"
	desc: "UnPunish"
	alias: {"unpunish"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			v.Character.Parent = workspace
			v.Character\MakeJoints()
			Output2(string.format("Unpunished %s",v.Name),{Colors.Green})
}