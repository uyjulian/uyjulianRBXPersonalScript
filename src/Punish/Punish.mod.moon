export modinfo = {
	type: "command"
	desc: "Punish"
	alias: {"punish"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			v.Character.Parent = Service"Lighting"
			Output2(string.format("Punished %s",v.Name),{Colors.Green})
}