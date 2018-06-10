export modinfo = {
	type: "command"
	desc: "Paralyze a player"
	alias: {"para", "cripple", "stun"}
	func: getDoPlayersFunction (v) ->
		v.Character.Humanoid.PlatformStand = true
		Output(string.format("Paralyzed %s",v.Name),{Colors.Green})
}