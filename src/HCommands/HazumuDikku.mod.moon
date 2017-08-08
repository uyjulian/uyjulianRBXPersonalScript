export modinfo = {
	type: "command"
	desc: "Hazumu dikku"
	alias: {"hazdik"}
	func: getDoPlayersFunction (v, msg) ->
		Spawn ->
			v.Character.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
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
				Scale: Vector3.new(0.8,1,0.8)
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
			seg = seg+1
			Neck2(d,seg)
			cfa = CFrame.new()
			while wait(0.05)
				if #tostring(seg) >= 1 and #tostring(seg) <= 9
					cfa = CFrame.Angles(math.cos(tick()*(seg/(seg/10)))/(seg/(seg/10)),0,0)
				if #tostring(seg) >= 10 and #tostring(seg) <= 99
					cfa = CFrame.Angles(math.cos(tick()*(seg/(seg/100)))/(seg/(seg/100)),0,0)
				if seg == 100
					cfa = CFrame.Angles(math.cos(tick()*(seg/2))/(seg/2),0,0)
				for i = 1,seg
					d["seg"..i].Weld.C0 = cfa
				--v.Character.Torso.Neck.C0 = CFrame.new(math.cos((tick()*3)+math.pi)*3.7,((math.cos((tick()*6)+math.pi)*1.5)*0.8)+((seg/2)+(seg/10)),0) * CFrame.Angles(math.pi/2,((math.sin((tick()*3)+math.pi/2)*(math.pi/2)))+math.pi,0)
}