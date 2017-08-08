export modinfo = {
	type: "command"
	desc: "Gives player some light"
	alias: {"light"}
	func: getDoPlayersFunction (v) ->
		CreateInstance"Part"{
			_Init: (obj) ->
				Spawn ->
					while wait()
						obj.CFrame = v.Character.Head.CFrame * CFrame.new(0, 8, 0)
			Parent: v.Character
			Name: ""
			Shape: "Ball"
			Size: Vector3.new(4, 4, 4)
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			BrickColor: BrickColor.new("Really red")
			Transparency: .5
			Anchored: true
			CFrame: v.Character.Head.CFrame * CFrame.new(0, 8, 0)
			CreateInstance"PointLight"{
				Range: 15
				Brightness: 15
				Color: Color3.new(250/255,250/255,250/255)
				Enabled: true
			}
		}
}