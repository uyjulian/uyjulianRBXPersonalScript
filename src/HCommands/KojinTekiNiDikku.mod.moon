export modinfo = {
	type: "command"
	desc: "Kojin-teki ni dikku"
	alias: {"kojteknidik"}
	func: getDoMultiPlayersFunction 2, (tbl, msg) ->
		v = tbl[1]
		b = tbl[2]
		Spawn ->
			t2 = b.Character
			v.Character.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
			t2.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
			v.Character.Torso.Anchored=true
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
				Size: Vector3.new(1,5,1)
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Position: v.Character.Head.Position
				CanCollide: true
			}
			cy = CreateInstance"CylinderMesh"{
				Parent: d
				Scale: Vector3.new(0.6,1,0.6)
			}
			w = CreateInstance"Weld"{
				Parent: v.Character.Head
				Part0: d
				Part1: v.Character.Head
				C0: CFrame.new(0,-(2),2.35)*CFrame.Angles(math.rad(70),0,0)
			}
			c = CreateInstance"Part"{
				Name: "Mush"
				BottomSurface: 0
				TopSurface: 0
				FormFactor: 3
				Size: Vector3.new(1,1,1)
				CFrame: CFrame.new(d.Position)
				BrickColor: ConfigSystem("Get", "Ero sentan no iro")
				CanCollide: true
				Parent: D
			}
			msm = CreateInstance"SpecialMesh"{
				Parent: c
				MeshType: "Head"
				Scale: Vector3.new(1.199,1.199,1.199)
			}
			cw = CreateInstance"Weld"{
				Parent: c
				Part0: d
				Part1: c
				C0: CFrame.new(0,2.5,0)
			}
			ball1 = CreateInstance"Part"{
				Parent: D
				Name: "Left Ball"
				BottomSurface: 0
				TopSurface: 0
				CanCollide: true
				FormFactor: 3
				Size: Vector3.new(2,2,2)
				CFrame: CFrame.new(v.Character["Left Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			bsm = CreateInstance"SpecialMesh"{
				Parent: ball1
				MeshType: "Sphere"
				Scale: Vector3.new(0.8,0.8,0.8)
			}
			b1w = CreateInstance"Weld"{
				Parent: ball1
				Part0: v.Character["Left Leg"]
				Part1: ball1
				C0: CFrame.new(1.2,0.5,-(0.6))
			}
			ball2 = CreateInstance"Part"{
				Parent: D
				Name: "Right Ball"
				BottomSurface: 0
				CanCollide: true
				TopSurface: 0
				FormFactor: 3
				Size: Vector3.new(2,2,2)
				CFrame: CFrame.new(v.Character["Right Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			b2sm = CreateInstance"SpecialMesh"{
				Parent: ball2
				MeshType: "Sphere"
				Scale: Vector3.new(0.8,0.8,0.8)
			}
			b2w = CreateInstance"Weld"{
				Parent: ball2
				Part0: v.Character["Right Leg"]
				Part1: ball2
				C0: CFrame.new(-(1.2),0.5,-(0.6))
			}
			newweld= CreateInstance"Weld"{
				Parent: d
				Part0: d
				Part1: t2.Torso
				C0: CFrame.new(0,2,1)*CFrame.Angles(math.rad(90),0,0)
			}
			ls = CreateInstance"Weld"{
				Parent: t2
				Part0: t2["Left Arm"]
				Part1: t2.Torso
				C0: CFrame.new(1.35,-(1),0)
			}
			rs = CreateInstance"Weld"{
				Parent: t2
				Part0: t2["Right Arm"]
				Part1: t2.Torso
				C0: CFrame.new(-(1.35),-(1),0)
			}
			lh = CreateInstance"Weld"{
				Parent: t2
				Part0: t2["Left Leg"]
				Part1: t2.Torso
				C0: CFrame.new(0.3,1.8,0.4) *CFrame.Angles(math.rad(25),0,math.rad(15))
			}
			rh = CreateInstance"Weld"{
				Part0: t2["Right Leg"]
				Part1: t2.Torso
				C0: CFrame.new(-(0.3),1.8,0.4) *CFrame.Angles(math.rad(25),0,math.rad(-(15)))
			}
			while true
				for i=1,135/2
					rs.C0 = rs.C0 * CFrame.Angles(0,0,math.rad(2))
					ls.C0 = ls.C0 * CFrame.Angles(0,0,math.rad(2))
					wait(0.0005)
				for i=1,135/2
					rs.C0 = rs.C0 * CFrame.Angles(0,0,math.rad(-(2)))
					ls.C0 = ls.C0 * CFrame.Angles(0,0,math.rad(-(2)))
					wait(0.0005)
}