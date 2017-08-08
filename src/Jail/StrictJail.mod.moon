export modinfo = {
	type: "command"
	desc: "Makes a strict jail"
	alias: {"sjail"}
	func: getDoPlayersFunction (v) ->
		Spawn ->
			MainCF = v.Character.Torso.CFrame
			Main = CreateInstance"Model"{
				Parent: workspace
				Name: "Main"
			}
			Part = CreateInstance"Part"{
				Name: "Part"
				FormFactor: "Custom"
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				Reflectance: 0
				Transparency: 0
				Anchored: true
				Locked: true
				CanCollide: true
				BrickColor: BrickColor.new("Really black")
				Size: Vector3.new(2,1,4)
				CreateInstance"BlockMesh"{
					Scale: Vector3.new(1,1,.1)
				}
			}
			table.insert(ConfigSystem("Get", "Jails"),{Jail: Main, Player: v})
			for Pitch = 1, 360, 360 
				for Yaw = 1, 360, 360/13 
					for Angle = 1,180, 8 
						Parted = Part\Clone()
						Parted.CFrame = MainCF * CFrame.Angles(math.rad(Pitch),math.rad(Yaw),math.rad(Angle)) * CFrame.new(0,5,0)
						Parted.Parent = Main
						if math.floor(Angle/5) == Angle/5
							wait()
			v.Character.Torso.CFrame = MainCF
			while Main.Parent ~= nil 
				wait()
				pcall ->
					if (v.Character.Torso.CFrame.p - MainCF.p).magnitude > 1
						v.Character.Torso.CFrame = MainCF
}