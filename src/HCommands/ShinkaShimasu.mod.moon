export modinfo = {
	type: "command"
	desc: "Shinka shimasu"
	alias: {"shishi"}
	func: getDoPlayersFunction (v, msg) ->
		Spawn ->
			removeOldDick(v.Character)
			D = CreateInstance"Model"{
				Parent: v.Character
				Name: ConfigSystem("Get", "Ero-mei")
			}
			bg = CreateInstance"BodyGyro"{
				Parent: v.Character.Torso
			}
			d = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				Name: "Main"
				Parent: D
				FormFactor: 3
				Size: Vector3.new(1,1,1)
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Position: v.Character.Head.Position
				CanCollide: true
			}
			cy = CreateInstance"CylinderMesh"{
				Parent: d
				Scale: Vector3.new(1,1,1)
			}
			w = CreateInstance"Weld"{
				Parent: v.Character.Head
				Part0: d
				Part1: v.Character.Head
				C0: CFrame.new(0,-(1),2.5)*CFrame.Angles(math.rad(90),0,0)
			}
			ball1 = CreateInstance"Part"{
				Parent: D
				Name: "Left Ball"
				BottomSurface: 0
				TopSurface: 0
				CanCollide: true
				FormFactor: 3
				Size: Vector3.new(1,1,1)
				CFrame: CFrame.new(v.Character["Left Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			bsm = CreateInstance"SpecialMesh"{
				Parent: ball1
				MeshType: "Sphere"
				Scale: Vector3.new(0.9,0.9,0.9)
			}
			b1w = CreateInstance"Weld"{
				Parent: ball1
				Part0: v.Character["Left Leg"]
				Part1: ball1
				C0: CFrame.new(0.855,0.6,-(0.6))
			}
			ball2 = CreateInstance"Part"{
				Parent: D
				Name: "Right Ball"
				BottomSurface: 0
				CanCollide: true
				TopSurface: 0
				FormFactor: 3
				Size: Vector3.new(1,1,1)
				CFrame: CFrame.new(v.Character["Right Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			b2sm = CreateInstance"SpecialMesh"{
				Parent: ball2
				MeshType: "Sphere"
				Scale: Vector3.new(0.9,0.9,0.9)
			}
			b2w = CreateInstance"Weld"{
				Parent: ball2
				Part0: v.Character["Right Leg"]
				Part1: ball2
				C0: CFrame.new(-(0.855),0.6,-(0.6))
			}
			seg = Split(msg)[2] or 1
			other = seg+50
	
			Neck3(d,other)
			par=d
			while true 
				for i=1,seg 
					par["seg"..i].Mesh.Scale = Vector3.new(1,1,1)
					wait(0.015)
					par["seg"..i+1].Mesh.Scale = Vector3.new(2,1,2)
					if par["seg"..i+1].Name == "seg"..seg
						par["seg"..i+1].Mesh.Scale = Vector3.new(2,2,2)
					wait(0.015)
					par["seg"..i+2].Mesh.Scale = Vector3.new(3,1,3)
					if par["seg"..i+2].Name == "seg"..seg
						par["seg"..i+2].Mesh.Scale = Vector3.new(3,3,3)
					wait(0.015)
					par["seg"..i+3].Mesh.Scale = Vector3.new(4,1,4)
					if par["seg"..i+3].Name == "seg"..seg
						par["seg"..i+3].Mesh.Scale = Vector3.new(4,4,4)
					wait(0.015)
					par["seg"..i+4].Mesh.Scale = Vector3.new(3,1,3)
					if par["seg"..i+4].Name == "seg"..seg
						s = CreateInstance"Part"{
							Parent: par["seg"..seg]
							Size: Vector3.new(2,2,2)
							TopSurface: 0
							BottomSurface: 0
							BrickColor: BrickColor.new('White')
							Shape: 'Ball'
						}
						mesh = CreateInstance"SpecialMesh"{
							Parent: s
							MeshType: 'Sphere'
						}
						s.CFrame=CFrame.new(par["seg"..seg].Position)
						par["seg"..i+4].Mesh.Scale = Vector3.new(3,3,3)
					wait(0.015)
					par["seg"..i+5].Mesh.Scale = Vector3.new(2,1,2)
					if par["seg"..i+6].Name == "seg"..seg
						par["seg"..i+6].Mesh.Scale = Vector3.new(2,2,2)
					wait(0.015)
					par["seg"..i+6].Mesh.Scale = Vector3.new(1,1,1)
					if par["seg"..i+6].Name == "seg"..seg
						par["seg"..i+6].Mesh.Scale = Vector3.new(1,1,1)
					wait(0.015)
				wait(0.2)
}