export modinfo = {
	type: "command"
	desc: "Ferachio"
	alias: {"ferchi"}
	func: getDoMultiPlayersFunction 2, (tbl, msg) ->
		v = tbl[1]
		b = tbl[2]
		Spawn ->
			t1 = b.Character.Torso
			t2 = v.Character.Torso
			t2.Parent.Humanoid.PlatformStand = true
			rm = t1["Left Shoulder"]
			rm.Parent = nil
			ls1 = CreateInstance"Weld"{
				Parent: t1
				Part0: t1
				Part1: t1.Parent["Left Arm"]
				C0: CFrame.new(-1.5,0,0)
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
				C0: CFrame.new(-1.5,0,0)
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
				C0: CFrame.new(-0.5,-2,0)
				Name: "Left Hip"
			}
			rm = t2["Right Hip"]
			rm.Parent = nil
			rh2 = CreateInstance"Weld"{
				Parent: t2
				Part0: t2
				Part1: t2.Parent["Right Leg"]
				C0: CFrame.new(0.5,-2,0)
				Name: "Right Hip"
			}
			d = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				BrickColor: BrickColor.new("Medium stone grey")
				Shape: "Ball"
				Parent: t1
				Size: Vector3.new(1,1,1)
			}
			dm = CreateInstance"SpecialMesh"{
				MeshType: "Sphere"
				Parent: d
				Scale: Vector3.new(0.4,0.4,0.4)
			}
			fgeld("weld",t1,t1,d,true,-(0.2),-(1.3),-(0.6),0,0,0)
			d2 = d\Clone()
			d2.Parent = t1
			fgeld("weld",t1,t1,d2,true,0.2,-(1.3),-(0.6),0,0,0)
			c = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				BrickColor: ConfigSystem("Get", "Ero-iro")
				Parent: t1
				FormFactor: "Custom"
				Size: Vector3.new(0.4,1.3,0.4)
			}
			cm = CreateInstance"CylinderMesh"{
				Parent: c
			}
			a = fgeld("weld",t1,t1,c,true,0,-(1),-(0.52)+(-(c.Size.y)/2),math.rad(-(80)),0,0)
			c2 = d\Clone()
			c2.BrickColor = BrickColor.new("Medium stone grey")
			c2.Mesh.Scale = Vector3.new(0.4,0.62,0.4)
			c2.Parent = t1
			fgeld("weld",c,c,c2,true,0,0+(c.Size.y/2),0,math.rad(-(10)),0,0)
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
			fgeld("weld",t2,t2,bl,true,-(0.5),0.5,-(0.6),0,0,0)
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
			fgeld("weld",t2,t2,br,true,0.5,0.5,-(0.6),0,0,0)
			bln = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				Shape: "Ball"
				Parent: t2
				Size: Vector3.new(1,1,1)
			}
			dm = CreateInstance"SpecialMesh"{
				MeshType: "Sphere"
				Parent: bln
				Scale: Vector3.new(0.2,0.2,0.2)
			}
			fgeld("weld",t2,t2,bln,true,-(0.5),0.5,-(1.2),0,0,0)
			brn = CreateInstance"Part"{
				TopSurface: 0
				BottomSurface: 0
				CanCollide: false
				Shape: "Ball"
				Parent: t2
				Size: Vector3.new(1,1,1)
			}
			dm = CreateInstance"SpecialMesh"{
				MeshType: "Sphere"
				Parent: brn
				Scale: Vector3.new(0.2,0.2,0.2)
			}
			fgeld("weld",t2,t2,brn,true,0.5,0.5,-(1.2),0,0,0)
			lh2.C1 = CFrame.new(0,-(1.5),-(0.5)) * CFrame.Angles(0.9,-(0.4),0)
			rh2.C1 = CFrame.new(0,-(1.5),-(0.5)) * CFrame.Angles(0.9,0.4,0)
			ls2.C1 = CFrame.new(-(0.5),-(1.3),-(0.5)) * CFrame.Angles(0.7,-(0.2),0)
			rs2.C1 = CFrame.new(0.5,-(1.3),-(0.5)) * CFrame.Angles(0.7,0.2,0)
			ls1.C1 = CFrame.new(-(0.5),0.9,0.5) * CFrame.Angles(-(1.2),.2,0)
			rs1.C1 = CFrame.new(0.5,0.9,0.5) * CFrame.Angles(-(1.2),-(.2),0)
			if t1\FindFirstChild("weldx") ~= nil
				t1.weldx.Parent = nil
			we = fgeld("weldx", t1, t1, t2, true, 0, -(1.8), -(2.47), math.rad(-(130)), 0, 172.79)
			n = t2.Neck
			n.C0 = CFrame.new(0, 1.2, 0) * CFrame.Angles(math.rad(-(235)), math.rad(180), 0)
			Spawn ->
				while wait()
					for i = 1,6
						we.C1 = we.C1 * CFrame.new(0.0,0.05,-(0.05))
						ls2.C1 = ls2.C1 * CFrame.new(0,0,0) * CFrame.Angles(0.014,-(0.004),0)
						rs2.C1 = rs2.C1 * CFrame.new(0,0,0) * CFrame.Angles(0.014,-(0.004),0)
						ls1.C1 = ls1.C1 * CFrame.new(0,0,0) * CFrame.Angles(-(0.020),0,0)
						rs1.C1 = rs1.C1 * CFrame.new(0,0,0) * CFrame.Angles(-(0.020),0,0)
						wait()
					for i = 1,6
						we.C1 = we.C1 * CFrame.new(0.0,-(0.05),0.05)
						ls2.C1 = ls2.C1 * CFrame.new(0,0,0) * CFrame.Angles(-(0.014),0.004,0)
						rs2.C1 = rs2.C1 * CFrame.new(0,0,0) * CFrame.Angles(-(0.014),0.004,0)
						ls1.C1 = ls1.C1 * CFrame.new(0,0,0) * CFrame.Angles(0.020,0,0)
						rs1.C1 = rs1.C1 * CFrame.new(0,0,0) * CFrame.Angles(0.020,0,0)
						wait()
}