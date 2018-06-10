export modinfo = {
	type: "command"
	desc: "Heals player"
	alias: {"heal"}
	func: getDoPlayersFunction (v) ->
		v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
}