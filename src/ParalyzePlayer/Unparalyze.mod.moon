export modinfo = {
	type: "command"
	desc: "Unparalyze player"
	alias: {"Unpara"}
	func: getDoPlayersFunction (v) ->
		v.Character.Humanoid.Jump = false
		v.Character.Humanoid.PlatformStand = false
		v.Character.Humanoid.Sit = false
		if v.Character\FindFirstChild("Torso")
			v.Character.Torso.CFrame = CFrame.new(v.Character.Torso.Position) + Vector3.new(0,5,0)
			v.Character.Torso.Velocity = Vector3.new()
		Output(string.format("Unparalyzed %s",v.Name),{Colors.Green})
}