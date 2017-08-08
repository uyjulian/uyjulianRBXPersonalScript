export modinfo = {
	type: "command"
	desc: "Kill"
	alias: {"kill"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			v.Character\BreakJoints()
			Output(string.format("Killed %s",v.Name),{Colors.Green})
			loggit(string.format("You killed %s",v.Name))
		else
			Output(string.format("Could not kill %s",v.Name),{Colors.Red})
}