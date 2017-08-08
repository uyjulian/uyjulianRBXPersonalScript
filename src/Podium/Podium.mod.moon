export modinfo = {
	type: "command"
	desc: "Generate podium"
	alias: {"podium"}
	func: getDoPlayersFunction (v) ->
		MainColor = Color3.new(0,0,0)
		SeccondaryColor = Color3.new(1,1,1)
		Main = CreateInstance"Model"{
			Parent: workspace
			Name: "NilPodium"
		}
		MainCFrame = v.Character.Torso.CFrame * CFrame.new(0,-(4),0) + v.Character.Torso.CFrame.lookVector*3
		SecondaryCFrame = v.Character.Torso.CFrame * CFrame.new(0,-(4) + (25 * .9),((2 * 25) * -(1)) - 10 ) + v.Character.Torso.CFrame.lookVector * 3
		if CFrame == nil 
			return 
		createStep = (i) -> 
			return CreateInstance"Model"{
				CreateInstance"Part"{
					FormFactor: "Custom"
					Name: "Step"
					Anchored: true
					Locked: true
					Reflectance: 0
					TopSurface: "Smooth"
					BottomSurface: "Smooth"
					BrickColor: BrickColor.new(SeccondaryColor)
					Size: Vector3.new(6,1,3)
					CFrame: MainCFrame * CFrame.new(0,(i*.9), i * -(2))
					CreateInstance"BlockMesh"{}
				}
				CreateInstance"Part"{
					FormFactor: "Custom"
					Name: "Carpet"
					Anchored: true
					Locked: true
					Reflectance: 0
					TopSurface: "Smooth"
					BottomSurface: "Smooth"
					BrickColor: BrickColor.new(MainColor)
					Size: Vector3.new(4,1,3.2)
					CFrame: MainCFrame * CFrame.new(0,(i*.9)+ .1, i * -(2))
					CreateInstance"BlockMesh"{}
				}
			}
		createTorch = (i) ->
			Spike = CreateInstance"Part"{
				FormFactor: "Custom"
				Name: "Spike"
				Anchored: true
				Locked: true
				Reflectance: 0
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				BrickColor: BrickColor.new(MainColor)
				Size: Vector3.new(1, 7, 1)
				CFrame: SecondaryCFrame * CFrame.Angles(math.rad(0),math.rad((360/6)*i),math.rad(45)) * CFrame.new(7,-(7),0)
			}
			return CreateInstance"Model"{
				Spike
				CreateInstance"Part"{
					Reflectance: 1e2+999
					FormFactor: "Custom"
					Name: "Torch"
					Shape: "Ball"
					Anchored: true
					Locked: true
					Size: Vector3.new(2,2,2)
					CFrame: Spike.CFrame * CFrame.new(0,3.5,0) * CFrame.Angles(0,0,0)
					CreateInstance"Fire"{}
				}
			}
		Spawn ->
			queue = {}
			torches = {}
	
			for i=1,25
				table.insert(queue, createStep(i)) 
			for i = 1,math.floor(360/6)
				table.insert(torches, createTorch(i))
			table.insert(queue, CreateInstance"Model"{ 
					CreateInstance"Part"{
						FormFactor: "Custom"
						Name: "MainCirc"
						Anchored: true
						Locked: true
						Reflectance: 0
						TopSurface: "Smooth"
						BottomSurface: "Smooth"
						BrickColor: BrickColor.new(SeccondaryColor)
						Size: Vector3.new(20,1,20)
						CFrame: SecondaryCFrame
						CreateInstance"CylinderMesh"{}
					}
					CreateInstance"Part"{
						FormFactor: "Custom"
						Name: "SeccondaryCirc"
						Anchored: true
						Locked: true
						Reflectance: 0
						TopSurface: "Smooth"
						BottomSurface: "Smooth"
						BrickColor: BrickColor.new(MainColor)
						Size: Vector3.new(18,1,18)
						CFrame: SecondaryCFrame * CFrame.new(0,.1,0)
						CreateInstance"CylinderMesh"{}
					}
					unpack(torches)
				}
			)
	
			for i, v in pairs(queue)
				wait()
				v.Parent = Main
}