export modinfo = {
	type: "command"
	desc: "Make Forest"
	alias: {"forest"}
	func: (Msg,Speaker) ->
		tmodel = CreateInstance"Model"{
			Parent: workspace
		}
		tree = CreateInstance"Model"{
			CreateInstance"Part"{
				_Init: (obj) ->
					Spawn ->
						obj.Parent.PrimaryPart = obj
				Name: "Trunk"
				Size: Vector3.new(4, 20, 4)
				Anchored: true
				Locked: true
				BrickColor: BrickColor.new("Reddish brown")
			}
			CreateInstance"Part"{
				_Init: (obj) ->
					Spawn ->
						obj.CFrame = obj.Parent.Trunk.CFrame * CFrame.new(0, 13, 0)
				BrickColor: BrickColor.new("Earth green")
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				Size: Vector3.new(13, 13, 13)
				Anchored: true
				Shape: "Ball"
			}
		}
		Spawn ->
			wait()
			for i = 1, 3000
				treec = tree\clone()
				treec\SetPrimaryPartCFrame(CFrame.new(math.random(-(500), 500), math.random(-(5), 10), math.random(-(500), 500)))
				treec.Parent = tmodel
	
		Output("Made a forest!",{Colors.Green})
}