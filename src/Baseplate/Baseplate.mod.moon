export modinfo = {
	type: "command"
	desc: "Baseplate"
	alias: {"base"}
	func: (Msg,Speaker) ->
		CreateInstance"Part"
			Parent: workspace
			Name: "Base"
			Anchored: true
			Locked: true
			BrickColor: BrickColor.new("Bright green")
			Size: Vector3.new(2048,2,2048)
			CFrame: CFrame.new(0,0,0)
		loggit("You Made A New Base")
}