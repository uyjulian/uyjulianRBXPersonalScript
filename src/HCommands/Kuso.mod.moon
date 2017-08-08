export modinfo = {
	type: "command"
	desc: "Kuso"
	alias: {"kuso"}
	func: getDoMultiPlayersFunction 2, (tbl, msg) ->
		v = tbl[1]
		b = tbl[2]
		Spawn ->
			t1 = v.Character.Torso
			t2 = b.Character.Torso
			t2.Parent.Humanoid.PlatformStand = true
			rm = t1["Left Shoulder"]
			rm.Parent = nil
			ls1 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1
				Part1: t1.Parent["Left Arm"]
				C0: CFrame.new(-(1.5),0,0)
				Name: "Left Shoulder"
			}
			rm = t1["Right Shoulder"]
			rm.Parent = nil
			rs1 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1
				Part1: t1.Parent["Right Arm"]
				C0: CFrame.new(1.5,0,0)
				Name: "Right Shoulder"
			}
			rm = t2["Left Shoulder"]
			rm.Parent = nil
			ls2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2
				Part1: t2.Parent["Left Arm"]
				C0: CFrame.new(-(1.5),0,0)
				Name: "Left Shoulder"
			}
			rm = t2["Right Shoulder"]
			rm.Parent = nil
			rs2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2
				Part1: t2.Parent["Right Arm"]
				C0: CFrame.new(1.5,0,0)
				Name: "Right Shoulder"
			}
			rm = t2["Left Hip"]
			rm.Parent = nil
			lh2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2
				Part1: t2.Parent["Left Leg"]
				C0: CFrame.new(-(0.5),-(2),0)
				Name: "Left Hip"
			}
			rm = t2["Right Hip"]
			rm.Parent = nil
			rh2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2
				Part1: t2.Parent["Right Leg"]
				C0: CFrame.new(0.5,-(2),0)
				Name: "Right Hip"
			}
			d = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Shape: "Ball"
				Parent: t1
				Size: Vector3.new(1,1,1)
			}
			dm = CreateInstance"SpecialMesh"{
				MeshType: "Sphere"
				Parent: d
				Scale: Vector3.new(0.7,0.7,0.7)
			}
			fgeld("weld",t1,t1,d,true,-(0.35),-(1.3),-(0.6),0,0,0)
			d2 = d\Clone()
			d2.Parent = t1
			fgeld("weld",t1,t1,d2,true,0.35,-(1.3),-(0.6),0,0,0)
			c = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Parent: t1
				FormFactor: "Custom"
				Size: Vector3.new(0.6,1.3,0.6)
			}
			cm = CreateInstance"CylinderMesh"{
				Parent: c
			}
			a = fgeld("weld",t1,t1,c,true,0,-(1),-(0.52)+(-(c.Size.y)/2),math.rad(-(90)),0,0)
			c2 = d\Clone()
			c2.BrickColor = ConfigSystem("Get", "Ero sentan no iro")
			c2.Mesh.Scale = Vector3.new(0.599,0.62,0.699)
			c2.Parent = t1
			c2.Mesh.MeshType = "Head"
			fgeld("weld",c,c,c2,true,0,0+(c.Size.y/2),0,0,0,0)
			bl = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Shape: "Ball"
				Parent: t2
				Size: Vector3.new(1,1,1)
			}
			dm = CreateInstance"SpecialMesh"{
				MeshType: "Sphere"
				Parent: bl
				Scale: Vector3.new(1.2,1.2,1.2)
			}
			fgeld("weld",t2,t2,bl,true,-(0.5),-(1),0,0,0,0)
			br = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Shape: "Ball"
				Parent: t2
				Size: Vector3.new(1,1,1)
			}
			dm = CreateInstance"SpecialMesh"{
				MeshType: "Sphere"
				Parent: br
				Scale: Vector3.new(1.2,1.2,1.2)
			}
			fgeld("weld",t2,t2,br,true,0.5,-(1),0,0,0,0)
			lh2.C1 = CFrame.new(0,-(1.5),-(0.5)) * CFrame.Angles(0.9,-(0.4),0)
			rh2.C1 = CFrame.new(0,-(1.5),-(0.5)) * CFrame.Angles(0.9,0.4,0)
			ls2.C1 = CFrame.new(-(0.5),-(1.3),-(0.5)) * CFrame.Angles(0.9,-(0.4),0)
			rs2.C1 = CFrame.new(0.5,-(1.3),-(0.5)) * CFrame.Angles(0.9,0.4,0)
			ls1.C1 = CFrame.new(-(0.5),0.7,0) * CFrame.Angles(-(0.9),-(0.4),0)
			rs1.C1 = CFrame.new(0.5,0.7,0) * CFrame.Angles(-(0.9),0.4,0)
			if t1\FindFirstChild("weldx") ~= nil
				t1.weldx.Parent = nil
			we = fgeld("weldx", t1, t1, t2, true, 0, -(0.9), -(1.3), math.rad(-(90)), 0, 0)
			n = t2.Neck
			n.C0 = CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(-(180)), math.rad(180), math.rad(45))
			t2.Parent.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
			Spawn ->
				while wait() do
					for i = 1,6*5
						we.C1 = we.C1 * CFrame.new(0,-(0.4)/5,0)
						wait()
					for i = 1,6*5
						we.C1 = we.C1 * CFrame.new(0,0.4/5,0)
						wait()
			Spawn ->
				while wait()
					for i=1,90
						n.C0 = n.C0 *CFrame.Angles(0,0,math.rad(-(1)))
						wait(0.0005)
					for i=1,90
						n.C0 = n.C0 *CFrame.Angles(0,0,math.rad(1))
						wait(0.0005)
}