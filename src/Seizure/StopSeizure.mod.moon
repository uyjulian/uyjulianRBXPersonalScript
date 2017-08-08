export modinfo = {
	type: "command"
	desc: "Stop players having a seizure"
	alias: {"sseizure"}
	func: getDoPlayersFunction (v) ->
		Spawn ->
			ConfigSystem("Set", "DisSei"..v.Name, true)
			g = v.Character
			g.Humanoid.PlatformStand = false
			g.Torso.Velocity = Vector3.new(0,0,0)
			g.Torso.RotVelocity = Vector3.new(0,0,0)
}