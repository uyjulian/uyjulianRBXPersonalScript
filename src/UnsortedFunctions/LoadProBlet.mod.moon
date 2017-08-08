export modinfo = {
	type: "function"
	id: "LoadProBlet"
	func: ->
		pcall ->
			LocalPlayer.Character = nil
		if ConfigSystem("Get", "AutomaticallyRemovePlayer")
			LocalPlayer.Parent = nil
		LocalPlayer.Character = nil
		om = CreateInstance"Part"{
			Parent: workspace
			Shape: "Ball"
			Size: Vector3.new(3, 3, 3)
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			BrickColor: BrickColor.new("Black")
			Material: "Plastic"
			Anchored: true
			CanCollide: false
		} 
		oo = CreateInstance"Part"{
			Parent: workspace
			Shape: "Ball"
			Size: Vector3.new(5, 5, 5)
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			BrickColor: BrickColor.new("Black")
			Material: "Plastic"
			Transparency: .7
			Anchored: true
			CanCollide: false
			CreateInstance"PointLight"{
				Range: ConfigSystem("Get", "ProbeLightRange")
				Brightness: ConfigSystem("Get", "ProbeLightBrightness")
				Color: ConfigSystem("Get", "ProbeLightColour")
				Enabled: true
			}
		}
		BB = CreateInstance"BillboardGui"{
			Parent: oo
			Size: UDim2.new(3, 0, 3 ,0)
			ExtentsOffset: Vector3.new(0, 2, 0)
			CreateInstance"TextLabel"{
				FontSize: "Size36"
				Font: "ArialBold"
				Text: CharacterName
				TextTransparency: .3
				BackgroundTransparency: 1
				TextColor3: Color3.new!
				TextStrokeTransparency: 0
				Size: UDim2.new(1,0,1,0)
			}
		} 
		Probe = oo
		Spawn ->
			while oo\IsDescendantOf(workspace) and wait!
				oo.CFrame = ConfigSystem("Get", "Camera").Focus
				om.CFrame = ConfigSystem("Get", "Camera").Focus
			oo.Parent = nil
			om.Parent = nil

}