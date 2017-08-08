export modinfo = {
	type: "command"
	desc: "PrettyBaseplate"
	alias: {"prbase"}
	func: (Msg,Speaker) ->
		CreateInstance"Part"
			Parent: workspace
			Size: Vector3.new(3000, 1, 3000)
			CFrame: CFrame.new(0, 0, 0)
			Name: "Base"
			BrickColor: BrickColor.new("Earth green")
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			LeftSurface: "Smooth"
			RightSurface: "Smooth"
			FrontSurface: "Smooth"
			BackSurface: "Smooth"
			Anchored: true
			Locked: true
		CreateInstance"SpawnLocation"
			Parent: workspace
			Anchored: true
			Locked: true
			FormFactor: "Plate"
			Size: Vector3.new(6, .4, 6)
			CFrame: CFrame.new(0, .6, 0)
			BrickColor: BrickColor.new("Really black")
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			LeftSurface: "Smooth"
			RightSurface: "Smooth"
			FrontSurface: "Smooth"
			BackSurface: "Smooth"
		Output2("Created base",{Colors.Green})
		loggit("Made Base")
}