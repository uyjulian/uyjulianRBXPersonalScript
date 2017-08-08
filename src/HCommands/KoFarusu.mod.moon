export modinfo = {
	type: "command"
	desc: "Ko farusu"
	alias: {"kofar"}
	func: getDoPlayersFunction (v) ->
		Spawn ->
			sizorz=4
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
				Size: Vector3.new(1,sizorz+0.5,1)
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Position: v.Character.Head.Position
				CanCollide: true
			}
			cy = CreateInstance"CylinderMesh"{
				Parent: d
				Scale: Vector3.new(1.05,1,1.05)
			}
			w = CreateInstance"Weld"{
				Parent: v.Character.Head
				Part0: d
				Part1: v.Character.Head
				C0: CFrame.new(0,-(0.6),1.8)*CFrame.Angles(math.rad(30),0,0)
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
				Scale: Vector3.new(1,0.6,1)
			}
			cw = CreateInstance"Weld"{
				Parent: c
				Part0: d
				Part1: c
				C0: CFrame.new(0,2.3,0)
			}
			ball1 = CreateInstance"Part"{
				Parent: D
				Name: "Left Ball"
				BottomSurface: 0
				TopSurface: 0
				CanCollide: true
				FormFactor: 3
				Size: Vector3.new(1.2,1.2,1.2)
				CFrame: CFrame.new(v.Character["Left Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			bsm = CreateInstance"SpecialMesh"{
				Parent: ball1
				MeshType: "Sphere"
			}
			b1w = CreateInstance"Weld"{
				Parent: ball1
				Part0: v.Character.Torso
				Part1: ball1
				C0: CFrame.new(-(0.6),-(1),-(0.8))
			}
			ball2 = CreateInstance"Part"{
				Parent: D
				Name: "Right Ball"
				BottomSurface: 0
				CanCollide: true
				TopSurface: 0
				FormFactor: 3
				Size: Vector3.new(1.2,1.2,1.2)
				CFrame: CFrame.new(v.Character["Right Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			b2sm = CreateInstance"SpecialMesh"{
				Parent: ball2
				MeshType: "Sphere"
			}
			b2w = CreateInstance"Weld"{
				Parent: ball2
				Part0: v.Character.Torso
				Part1: ball2
				C0: CFrame.new(0.6,-(1),-(0.8))
			}
			char = v.Character
			t = char.Torso
			lw= CreateInstance"Weld"{
				Parent: t
				Name: 'leftWeld'
				Part0: t
				Part1: char['Left Arm']
				C0: CFrame.new(-(1.15),1,-(1)) *CFrame.Angles(math.rad(100),math.rad(10),math.rad(20))
			}
			rw= CreateInstance"Weld"{
				Parent: t
				Name: 'rightWeld'
				Part0: t
				Part1: char['Right Arm']
				C0: CFrame.new(1.15,1,-(1)) *CFrame.Angles(math.rad(100),math.rad(-(10)),math.rad(-(20)))
			}
			while wait()
				lw.C0=CFrame.new(-(1.15),1,-(1)) *CFrame.Angles(math.rad(100),math.rad(10),math.rad(20))
				rw.C0=CFrame.new(1.15,1,-(1)) *CFrame.Angles(math.rad(100),math.rad(-(10)),math.rad(-(20)))
				wait(0.05)
				lw.C0=CFrame.new(-(1.15),0.8,-(1)) *CFrame.Angles(math.rad(95),math.rad(10),math.rad(20))
				rw.C0=CFrame.new(1.15,0.8,-(1)) *CFrame.Angles(math.rad(95),math.rad(-(10)),math.rad(-(20)))
				wait(0.05)
				lw.C0=CFrame.new(-(1.15),0.6,-(1)) *CFrame.Angles(math.rad(90),math.rad(10),math.rad(20))
				rw.C0=CFrame.new(1.15,0.6,-(1)) *CFrame.Angles(math.rad(90),math.rad(-(10)),math.rad(-(20)))
				wait(0.05)
				lw.C0=CFrame.new(-(1.15),0.4,-(1)) *CFrame.Angles(math.rad(85),math.rad(10),math.rad(20))
				rw.C0=CFrame.new(1.15,0.4,-(1)) *CFrame.Angles(math.rad(85),math.rad(-(10)),math.rad(-(20)))
				wait(0.05)
				lw.C0=CFrame.new(-(1.15),0.2,-(1)) *CFrame.Angles(math.rad(80),math.rad(10),math.rad(20))
				rw.C0=CFrame.new(1.15,0.2,-(1)) *CFrame.Angles(math.rad(80),math.rad(-(10)),math.rad(-(20)))
				wait(0.05)
}