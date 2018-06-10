export modinfo = {
	type: "command"
	desc: "R a p e two players"
	alias: {"rpe", "rap" .. "e", "ban" .. "g", "owo"}
	func: getDoMultiPlayersFunction 2, (tbl, msg) ->
		v = tbl[1]
		b = tbl[2]
		t1 = PlayersService[v.Name].Character.Torso
		t2 = PlayersService[b.Name].Character.Torso
		t2.Parent.Humanoid.PlatformStand = true
		lefs = t1["Left Shoulder"]
		lefs.Parent = nil
		ls1 = CreateInstance"Weld"{
			Parent: t1
			Part0: t1
			Part1: t1
			C0: CFrame.new(-(1.5), 0, 0)
			C1: CFrame.new(-(.5), .7, 0) * CFrame.Angles(-(.9), -(.4), 0)
			Name: "Left Shoulder"
		} 
		rigs = t1["Right Shoulder"]
		rigs.Parent = nil
		rs1 = CreateInstance"Weld"{
			Parent: t1
			Part0: t1
			Part1: t1.Parent["Right Arm"]
			C0: CFrame.new(1.5, 0, 0)
			C1: CFrame.new(.5, .7, 0) * CFrame.Angles(-(.9), .4, 0)
			Name: "Right Shoulder"
		}
		lefs = t2["Left Shoulder"]
		lefs.Parent = nil
		ls2 = CreateInstance"Weld"{
			Parent: t2
			Part0: t2
			Part1: t2.Parent["Left Arm"]
			C0: CFrame.new(-(1.5), 0, 0)
			C1: CFrame.new(-(.5), -(1.3), -(.5)) * CFrame.Angles(.9, -(.4), 0)
			Name: "Left Shoulder"
		} 
		rigs = t2["Right Shoulder"]
		rigs.Parent = nil
		rs2 = CreateInstance"Weld"{
			Parent: t2
			Part0: t2
			Part1: t2.Parent["Right Arm"]
			C0: CFrame.new(1.5, 0, 0)
			C1: CFrame.new(.5, -(1.3), -(.5)) * CFrame.Angles(.9, .4, 0)
			Name: "Right Shoulder"
		}
		lefh = t2["Left Hip"]
		lefh.Parent = nil
		lh2 = CreateInstance"Weld"{
			Parent: t2
			Part0: t2
			Part1: t2.Parent["Left Leg"]
			C0: CFrame.new(-(.5), -(2), 0)
			C1: CFrame.new(0, -(1.5), -(.5)) * CFrame.Angles(.9, -(.4), 0)
			Name: "Left Hip"
		}
		righ = t2["Right Hip"]
		righ.Parent = nil
		rh2 = CreateInstance"Weld"{
			Parent: t2
			Part0: t2
			Part1: t2.Parent["Right Leg"]
			C0: CFrame.new(.5, -(2), 0)
			C1: CFrame.new(0, -(1.5), -(.5)) * CFrame.Angles(.9, .4, 0)
			Name: "Right Hip"
		}
		d = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			BrickColor: BrickColor.new("Pastel brown")
			Shape: "Ball"
			Parent: t1
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh" {
			MeshType: "Sphere"
			Parent: d
			Scale: Vector3.new(.4, .4, .4)
		}
		fgeld("weld", t1, t1, d, true, -(.2), -(1.3), -(.6), 0, 0, 0)
		d2 = d\Clone()
		d2.Parent = t1
		fgeld("weld", t1, t1, d2, true, .2, -(1.3), -(.6), 0, 0, 0)
		c = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			BrickColor: BrickColor.new("Pastel brown")
			Parent: t1
			FormFactor: "Custom"
			Size: Vector3.new(.4, 1.3, .4)
		}
		cm = CreateInstance"CylinderMesh"{
			Parent: c
		}
		a = fgeld("weld", t1, t1, c, true, 0, -(1), -(.52) + (-(c.Size.y)/2), math.rad(-(80)), 0, 0)
		c2 = d\Clone()
		c2.BrickColor = BrickColor.new("Pink")
		c2.Mesh.Scale = Vector3.new(.4, .62, .4)
		c2.Parent = t1
		fgeld("weld", c, c, c2, true, 0, 0 + (c.Size.y/2), 0, math.rad(-(10)), 0, 0)
		bl = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			BrickColor: BrickColor.new("Pastel brown")
			Shape: "Ball"
			Parent: t2
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: bl
			Scale: Vector3.new(1.2, 1.2, 1.2)
		}
		fgeld("weld", t2, t2, bl, true, -(.5), .5, -(.6), 0, 0, 0)
		br = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			BrickColor: BrickColor.new("Pastel brown")
			Shape: "Ball"
			Parent: t2
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: br
			Scale: Vector3.new(1.2,1.2,1.2)
		}
		fgeld("weld", t2, t2, br, true, .5, .5, -(.6), 0, 0, 0)
		bln = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			Shape: "Ball"
			BrickColor: BrickColor.new("Pink")
			Parent: t2
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: bln
			Scale: Vector3.new(.2, .2, .2)
		}
		fgeld("weld", t2, t2, bln, true, -(.5), .5, -(1.2), 0, 0, 0)
		brn = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			Shape: "Ball"
			Parent: t2
			BrickColor: BrickColor.new("Pink")
			Size: Vector3.new(1,1,1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: brn
			Scale: Vector3.new(.2, .2, .2)
		}
		fgeld("weld", t2, t2, brn, true, .5, .5, -(1.2), 0, 0, 0)
		if t1\FindFirstChild("weldx") ~= nil
			t1.weldx.Parent = nil
		we = fgeld("weldx", t1, t1, t2, true, 0, -(.9), -(1.3), math.rad(-(90)), 0, 0)
		n = t2.Neck
		n.C0 = CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(-(210)), math.rad(180), 0)
		while true 
			wait() 
			for i = 1, 6 
				we.C1 = we.C1 * CFrame.new(0, -(.3), 0) 
				wait() 
			for i = 1, 6 
				we.C1 = we.C1 * CFrame.new(0, .3, 0) 
				wait() 
}