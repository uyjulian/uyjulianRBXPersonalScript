export modinfo = {
	type: "command"
	desc: "Use lasso to track"
	alias: {"track"}
	func: getDoPlayersFunction (v) ->
		as = CreateInstance"SelectionPartLasso"{
			Parent: LocalPlayer.Character.Torso
			Part: LocalPlayer.Character.Torso
			Humanoid: v.Character and v.Character\FindFirstChild("Humanoid")
			Color: BrickColor.new("Really red")
			Transparency: 0
		}
		Output(string.format("Tracking %s",v.Name),{Colors.Yellow})
}