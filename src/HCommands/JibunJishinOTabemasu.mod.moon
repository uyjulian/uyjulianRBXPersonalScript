export modinfo = {
	type: "command"
	desc: "Jibun jishin o tabemasu"
	alias: {"jibjistabe"}
	func: getDoPlayersFunction (v) ->
		Spawn ->
			char=v.Character
			t=char.Torso
			char.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
			n=t.Neck
			lw= CreateInstance"Weld"{
				Parent: t
				Name: 'leftWeld'
				Part0: t
				Part1: char['Left Arm']
				C0: CFrame.new(-(1),1,-(1)) *CFrame.Angles(math.rad(100),math.rad(10),math.rad(30))
			}
			rw= CreateInstance"Weld"{
				Parent: t
				Name: 'rightWeld'
				Part0: t
				Part1: char['Right Arm']
				C0: CFrame.new(1,0.5,-(1)) *CFrame.Angles(math.rad(80),math.rad(-(10)),math.rad(-(30)))
			}
			seg = 5
			while not v.Character
			 	wait()
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
				Position: v.Character.Torso.Position
				CanCollide: true
			}
			cy = CreateInstance"CylinderMesh"{
				Parent: d
				Scale: Vector3.new(0.3,1,0.3)
			}
			w = CreateInstance"Weld"{
				Parent: v.Character.Torso
				Part0: d
				Part1: v.Character.Torso
				C0: CFrame.new(0,-(0.8),1)*CFrame.Angles(math.rad(90),0,0)
			}
			ball1 = CreateInstance"Part"{
				Parent: D
				Name: "Left Ball"
				BottomSurface: 0
				TopSurface: 0
				CanCollide: true
				FormFactor: 3
				Size: Vector3.new(1.5,1.5,1.5)
				CFrame: CFrame.new(v.Character["Left Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			bsm = CreateInstance"SpecialMesh"{
				Parent: ball1
				MeshType: "Sphere"
				Scale: Vector3.new(0.3,0.3,0.3)
			}
			b1w = CreateInstance"Weld"{
				Parent: ball1
				Part0: v.Character["Left Leg"]
				Part1: ball1
				C0: CFrame.new(0.3,1,-(0.6))
			}
			ball2 = CreateInstance"Part"{
				Parent: D
				Name: "Right Ball"
				BottomSurface: 0
				CanCollide: true
				TopSurface: 0
				FormFactor: 3
				Size: Vector3.new(1.5,1.5,1.5)
				CFrame: CFrame.new(v.Character["Right Leg"].Position)
				BrickColor: ConfigSystem("Get", "Ero-iro")
			}
			b2sm = CreateInstance"SpecialMesh"{
				Parent: ball2
				MeshType: "Sphere"
				Scale: Vector3.new(0.3,0.3,0.3)
			}
			b2w = CreateInstance"Weld"{
				Parent: ball2
				Part0: v.Character["Right Leg"]
				Part1: ball2
				C0: CFrame.new(-(0.3),1,-(0.6))
			}
			Neck1(d,seg)
			while wait()
				for i=1,50
					n.C0 = n.C0 *CFrame.Angles(math.rad(-(0.2)),0,0)
					wait(0.0015)
				for i=1,50 
					n.C0 = n.C0 *CFrame.Angles(math.rad(0.2),0,0)
					wait(0.0015)
}