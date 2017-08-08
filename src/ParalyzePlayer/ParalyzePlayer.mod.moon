export modinfo = {
	type: "command"
	desc: "Paralyze a player"
	alias: {"para"}
	func: getDoPlayersFunction (v) ->
		v.Character.Humanoid.PlatformStand = true
		Output(string.format("Paralyzed %s",v.Name),{Colors.Green})
}