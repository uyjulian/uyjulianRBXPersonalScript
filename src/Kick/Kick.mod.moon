export modinfo = {
	type: "command"
	desc: "Kick"
	alias: {"kick"}
	func: getDoPlayersFunction (v) ->
		v\Destroy()
		Output(string.format("Kicked %s",v.Name),{Colors.Yellow})
		loggit(string.format("You kicked %s",v.Name))
}