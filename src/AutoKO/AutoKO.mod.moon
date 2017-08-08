export modinfo = {
	type: "command"
	desc: "Knock Out"
	alias: {"ko"}
	func: getDoPlayersFunction (Target) ->
		JD = 1000
		Output2(string.format("KOing %s 1000 times",Target.Name),{Colors.Black})
		for i=1, JD
			c = CreateInstance"ObjectValue"
				Parent: Target.Character.Humanoid
				Value: LocalPlayer
				Name: "creator"
			wait(.1)
			Target.Character.Humanoid.Health = 0
			wait(.01)
			Target.Character.Parent = Service"Lighting"
			wait(.01)
			c.Parent = nil
			wait(.01)
			Target.Character.Parent = workspace

}