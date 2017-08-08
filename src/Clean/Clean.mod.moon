export modinfo = {
	type: "command"
	desc: "Clean"
	alias: {"clean"}
	func: (Msg,Speaker) ->
		for i,s in pairs(workspace\GetChildren())
			if PlayersService\GetPlayerFromCharacter(s) == nil
				if not s\IsA"Terrain" 
					if not s\IsA"Camera"
						pcall -> s.Parent = nil
	
		b = CreateInstance"Part"
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
			Parent: workspace
		sl = CreateInstance"SpawnLocation"
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
			Parent: workspace
		Output("Cleaned workspace",{Colors.Green})
		loggit("Cleaned Workspace")
}