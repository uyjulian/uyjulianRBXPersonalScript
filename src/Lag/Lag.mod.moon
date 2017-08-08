export modinfo = {
	type: "command"
	desc: "Lag a player"
	alias: {"lag"}
	func: getDoPlayersFunction (v) ->
		localScript(Ext5,GetBackpack(v))
		Output(string.format("You have lagged %s",v.Name),{Colors.Green})
		loggit(string.format("Lagged player: %s",v.Name))
}