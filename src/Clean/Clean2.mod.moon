export modinfo = {
	type: "command"
	desc: "Clean2"
	alias: {"clean2"}
	func: (Msg,Speaker) ->
		k = Service"Lighting"
		k.ColorShift_Bottom = Color3.new(100, 100, 100) 
		k.ColorShift_Top = Color3.new(0, 0, 0) 
		k.Ambient = Color3.new(1, 1, 1) 
		k.Brightness = 1 
		k.TimeOfDay = "11:00:00"
		k.FogEnd = 99999999
	
		for i, v in pairs(Service"Teams"\GetChildren())
			if v\IsA"Team"
				v.Parent = nil
		for i, v in pairs(k\GetChildren())
			if v\IsA"Sky"
				v.Parent = nil
		g = workspace\GetChildren()
		for i, v in pairs(g)
			if v\IsA"Part"
				v.Parent = nil
		for i, v in pairs(g)
			if v\IsA"BaseScript"
				v.Disabled = true
				v.Parent = nil
		for i, v in pairs(Service"Players"\GetChildren())
			if v\IsA"BaseScript"
				v.Disabled = true
				v.Parent = nil
		p = CreateInstance"Part"
			Parent: workspace
			Size: Vector3.new(2048, 1, 2048)
			Anchored: true
			Locked: true
			BrickColor: BrickColor.new("Earth green")
			Name: "Base"
			CFrame: CFrame.new(Vector3.new(0, 0, 0))
}