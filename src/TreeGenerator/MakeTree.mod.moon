export modinfo = {
	type: "command"
	desc: "Make Tree"
	alias: {"tree"}
	func: getDoPlayersFunction (v) ->
		if v.Character\FindFirstChild("Torso") == nil 
			return
		treet = CreateInstance"Part"{
			Parent: workspace
			Size: Vector3.new(4, 20, 4)
			Anchored: true
			Locked: true
			BrickColor: BrickColor.new("Reddish brown")
			CFrame: v.Character.Torso.CFrame * CFrame.new(0, -(13), 0)
		}
		treetop = CreateInstance"Part"{
			Parent: workspace
			BrickColor: BrickColor.new("Earth green")
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			Size: Vector3.new(13, 13, 13)
			Anchored: true
			Shape: "Ball"
			CFrame: treet.CFrame * CFrame.new(0, 13, 0)
		}
		v.Character.Torso.CFrame = v.Character.Torso.CFrame * CFrame.new(0, 5, 0)
		Spawn ->
			for i = 1, 200
				wait()
				if treet ~= nil
					if treetop ~= nil
						treet.CFrame = treet.CFrame * CFrame.new(0, .1, 0)
						treetop.CFrame = treetop.CFrame * CFrame.new(0, .1, 0)
}