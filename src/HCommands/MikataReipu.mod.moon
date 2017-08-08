export modinfo = {
	type: "command"
	desc: "Mikata reipu"
	alias: {"mikrei"}
	func: getDoMultiPlayersFunction 2, (tbl, msg) ->
		v = tbl[1]
		b = tbl[2]
		x = tbl[3]
		Spawn ->
			while not (v.Character and b.Character and x.Character)
			 	wait()
			t1 = v.Character.Torso
			t2 = b.Character.Torso
			t3 = x.Character.Torso
			t1.Parent.Humanoid.WalkSpeed = 6
			t2.Parent.Humanoid.PlatformStand = true
			t3.Parent.Humanoid.PlatformStand = true
			pcall ->
				eww = t1\FindFirstChild(ConfigSystem("Get", "Ero-mei"))
				eww.Parent = nil 
			model = CreateInstance"Model"{
				Parent: t1
				Name: ConfigSystem("Get", "Ero-mei")
			}
			d1 = CreateInstance"Part"{
				Parent: model
				Name: "Main1"
				BrickColor: ConfigSystem("Get", "Ero-iro")
				FormFactor: "Custom"
				TopSurface: 0
				BottomSurface: 0
				Size: Vector3.new(0.5,4,0.5)
				CFrame: CFrame.new(t1.Parent.Head.Position)
			}
			c1 = CreateInstance"CylinderMesh"{
				Parent: d1
			}
			wd1 = CreateInstance"Weld"{
				Parent: d1
				Part0: d1
				Part1: t1.Parent.Head
				C0: CFrame.new(0,-(1.5),2.5) * CFrame.Angles(math.rad(90),0,0)
			}
			b1 = CreateInstance"Part"{
				Parent: model
				Name: "B1"
				BrickColor: d1.BrickColor
				TopSurface: 0
				BottomSurface: 0
				FormFactor: "Custom"
				Size: Vector3.new(1,1,1)
				Shape: "Ball"
			}
			bm1 = CreateInstance"SpecialMesh"{
				Parent: b1
				MeshType: "Sphere"
			}
			wb1 = CreateInstance"Weld"{
				Parent: b1
				Part0: b1
				Part1: d1
				C0: CFrame.new(0.4,0.8,0.3)
			}
			b2 = CreateInstance"Part"{
				Parent: model
				Name: "B2"
				BrickColor: d1.BrickColor
				TopSurface: 0
				BottomSurface: 0
				FormFactor: "Custom"
				Size: Vector3.new(1,1,1)
				Shape: "Ball"
			}
			bm2 = CreateInstance"SpecialMesh"{
				Parent: b1
				MeshType: "Sphere"
			}
			wb2 = CreateInstance"Weld"{
				Parent: b2
				Part0: b2
				Part1: d1
				C0: CFrame.new(-(0.4),0.8,0.3)
			}
			c1 = CreateInstance"Part"{
				Parent: model
				Name: "Tip"
				BrickColor: ConfigSystem("Get", "Ero sentan no iro")
				TopSurface: 0
				BottomSurface: 0
				FormFactor: "Custom"
				Size: Vector3.new(0.6,0.6,0.6)
			}
			sm1 = CreateInstance"SpecialMesh"{
				Parent: c1
			}
			wc1 = CreateInstance"Weld"{
				Parent: c1
				Part0: c1
				Part1: d1
				C0: CFrame.new(0,-(2),0)
			}
			if t3\FindFirstChild"D2" 
				eww = t3\FindFirstChild"D2"
				eww.Parent = nil 
			model2 = CreateInstance"Model"{
				Parent: t3
				Name: "D2"
			}
			d2 = CreateInstance"Part"{
				Parent: model2
				Name: "Main2"
				FormFactor: "Custom"
				TopSurface: 0
				BottomSurface: 0
				BrickColor: d1.BrickColor
				Size: Vector3.new(0.4,1,0.4)
			}
			cm2 = CreateInstance"CylinderMesh"{
				Parent: d2
			}
			wd2 = CreateInstance"Weld"{
				Parent: d2
				Part0: d2
				Part1: t3.Parent.Head
				C0: CFrame.new(0,-(1),2.5) *CFrame.Angles(math.rad(90),0,0)
			}
			b3 = CreateInstance"Part"{
				Parent: model2
				Name: "B1"
				BrickColor: d2.BrickColor
				TopSurface: 0
				BottomSurface: 0
				FormFactor: "Custom"
				Size: Vector3.new(0.5,0.5,0.5)
				Shape: "Ball"
			}
			bm3 = CreateInstance"SpecialMesh"{
				Parent: b3
				MeshType: "Sphere"
				Scale: Vector3.new(0.5,0.5,0.5)
			}
			wb3 = CreateInstance"Weld"{
				Parent: b3
				Part0: b3
				Part1: d2
				C0: CFrame.new(0.3,0.4,0)
			}
			b4 = CreateInstance"Part"{
				Parent: model2
				Name: "B2"
				BrickColor: d2.BrickColor
				TopSurface: 0
				BottomSurface: 0
				FormFactor: "Custom"
				Size: Vector3.new(0.5,0.5,0.5)
				Shape: "Ball"
			}
			bm4 = CreateInstance"SpecialMesh"{
				Parent: b4
				MeshType: "Sphere"
				Scale: Vector3.new(0.5,0.5,0.5)
			}
			wb4 = CreateInstance"Weld"{
				Parent: b4
				Part0: b4
				Part1: d2
				C0: CFrame.new(-(0.3),0.4,0)
			}
			c2 = CreateInstance"Part"{
				Parent: model2
				Name: "Tip"
				BrickColor: ConfigSystem("Get", "Ero sentan no iro")
				TopSurface: 0
				BottomSurface: 0
				FormFactor: "Custom"
				Size: Vector3.new(0.389,0.389,0.389)
			}
			sm1 = CreateInstance"SpecialMesh"{
				Parent: c2
			}
			wc2 = CreateInstance"Weld"{
				Parent: c2
				Part0: c2
				Part1: d2
				C0: CFrame.new(0,-(0.5),0)
			}
			for i,v in pairs(t1\GetChildren())
				if v.className == "Weld" 
					v.Parent = nil
			for i,v in pairs(t2\GetChildren())
				if v.className == "Weld" 
					v.Parent = nil
			for i,v in pairs(t3\GetChildren())
				if v.className == "Weld" 
					v.Parent = nil
			ls1 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1.Parent["Left Arm"]
				Part1: t1
				C0: CFrame.new(1.2,1,0) *CFrame.Angles(math.rad(-(75)),0,math.rad(35))
			}
			rs1 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1.Parent["Right Arm"]
				Part1: t1
				C0: CFrame.new(-(1.2),1,0) *CFrame.Angles(math.rad(-(75)),0,math.rad(-(35)))
			}
			lh1 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1.Parent["Left Leg"]
				Part1: t1
				C0: CFrame.new(0.3,1.8,0.5) *CFrame.Angles(math.rad(45),math.rad(35),0)
			}
			rh1 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1.Parent["Right Leg"]
				Part1: t1
				C0: CFrame.new(-(0.3),1.8,0.5) *CFrame.Angles(math.rad(45),math.rad(-(35)),0)
			}
			ls2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2.Parent["Left Arm"]
				Part1: t2
				C0: CFrame.new(1.35,-(1),0)
			}
			rs2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2.Parent["Right Arm"]
				Part1: t2
				C0: CFrame.new(-(1.35),-(1),0)
			}
			lh2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2.Parent["Left Leg"]
				Part1: t2
				C0: CFrame.new(0.3,1.8,0.4) *CFrame.Angles(math.rad(25),0,math.rad(15))
			}
			rh2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2.Parent["Right Leg"]
				Part1: t2
				C0: CFrame.new(-(0.3),1.8,0.4) *CFrame.Angles(math.rad(25),0,math.rad(-(15)))
			}
			ls3 = CreateInstance"Weld"{
				Parent: t3
				Part0: t3.Parent["Left Arm"]
				Part1: t3
				C0: CFrame.new(1.5,0.4,0.3) *CFrame.Angles(math.rad(-(68)),math.rad(30),0)
			}
			rs3 = CreateInstance"Weld"{
				Parent: t3
				Part0: t3.Parent["Right Arm"]
				Part1: t3
				C0: CFrame.new(-(1.5),0.4,0.5) *CFrame.Angles(math.rad(-(68)),math.rad(-(30)),0)
			}
			lh3 = CreateInstance"Weld"{
				Parent: t3
				Part0: t3.Parent["Left Leg"]
				Part1: t3
				C0: CFrame.new(0.3,1.8,0.4) *CFrame.Angles(math.rad(25),0,math.rad(15))
			}
			rh3 = CreateInstance"Weld"{
				Parent: t3
				Part0: t3.Parent["Right Leg"]
				Part1: t3
				C0: CFrame.new(-(0.3),1.8,0.4) *CFrame.Angles(math.rad(25),0,math.rad(-(15)))
			}
			wp12 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1
				Part1: t2
				C0: CFrame.new(0,-(1),-(4))
				C1: CFrame.Angles(math.rad(90),0,0)
			}
			wp23 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2
				Part1: t3
				C0: CFrame.new(0,3,-(1))
				C1: CFrame.Angles(math.rad(40),math.rad(180),0)
			}
			while wait()
				wait(0.05)
				for i=-(4),-(5),-(0.1)
					wp12.C0 = CFrame.new(0,-(1),i)
					wait(0.005)
				wb3.C0 = CFrame.new(0.3,0,0)
				wb4.C0 = CFrame.new(-(0.3),0,0)
				wait(0.05)
				for i=-(5),-(4),0.1
					wp12.C0 = CFrame.new(0,-(1),i)
					wait(0.005)
				wb3.C0 = CFrame.new(0.3,0.4,0)
				wb4.C0 = CFrame.new(-(0.3),0.4,0)
}