export modinfo = {
	type: "command"
	desc: "Private base"
	alias: {"pb"}
	func: (Msg,Speaker) ->
		CreateInstance"Model"{
			Parent: workspace
			CreateInstance"Part"
				Name: "PB"
				Anchored: true
				Locked: true
				BrickColor: BrickColor.new("Bright green")
				Size: Vector3.new(50,1,50)
				CFrame: CFrame.new(0,1000,0)
			CreateInstance"Part"
				Locked: true
				Anchored: true
				CanCollide: false
				Transparency: 1
				CFrame: CFrame.new(0,1010,0)
		}
		LocalPlayer.Character.Torso.CFrame = CFrame.new(0,1020,0)
		Output2("Private base created",{Color3.new(math.random(),math.random(),math.random())},Speaker)
		loggit("Private base created")
}