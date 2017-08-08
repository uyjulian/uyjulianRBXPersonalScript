export modinfo = {
	type: "command"
	desc: "ForceField"
	alias: {"ff"}
	func: getDoPlayersFunction (v) ->
		if v.Character
			CreateInstance"ForceField"{
				Parent: v.Character
			}
			Output4(string.format("Gave forcefield to %s",v.Name),{Colors.Green})
			loggit(string.format("Gave forcefield to %s",v.Name))
}