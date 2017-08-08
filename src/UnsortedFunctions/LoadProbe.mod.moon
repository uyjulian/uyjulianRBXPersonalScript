export modinfo = {
	type: "function"
	id: "LoadProbe"
	func: ->
		pcall ->
			LocalPlayer.Character = nil
		if ConfigSystem "Get", "AutomaticallyRemovePlayer"
			LocalPlayer.Parent = nil
		f = CreateInstance"Part"{
			_Init: (obj) ->
				Spawn ->
					while obj\IsDescendantOf(workspace) and wait!
						obj.CFrame = ConfigSystem("Get", "Camera").Focus
					obj.Parent = nil

			Parent: workspace
			Name: "Purobu"
			Anchored: true
			Shape: "Ball"
			Size: Vector3.new 5,5,5
			Transparency: .3
			BrickColor: BrickColor.new "Black"
			Material: "Plastic"
			Reflectance: .3
			CanCollide: false
			TopSurface: 0
			BottomSurface: 0
			CreateInstance"BillboardGui"{
				Size: UDim2.new 3, 0, 3, 0
				ExtentsOffset: Vector3.new 0, 2, 0
				CreateInstance"TextLabel"{
					FontSize: "Size36"
					Font: "ArialBold"
					Text: CharacterName
					TextTransparency: .3
					BackgroundTransparency: 1
					TextColor3: Color3.new!
					TextStrokeTransparency: 0
					Size: UDim2.new 1,0,1,0
				}
			}
			CreateInstance"PointLight"{
				Range: ConfigSystem "Get", "ProbeLightRange"
				Brightness: ConfigSystem "Get", "ProbeLightBrightness"
				Color: ConfigSystem "Get", "ProbeLightColour"
				Enabled: true
			}
		}
		Probe = f

}
