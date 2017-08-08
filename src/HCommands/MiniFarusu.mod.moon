export modinfo = {
	type: "command"
	desc: "Mini farusu"
	alias: {"minfar"}
	func: getDoPlayersFunction (v) ->
		t1 = v.Character.Torso
		t1.Parent.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
		removeOldDick(v.Character)
		mdl = CreateInstance"Model"{
			Parent: v.Character
			Name: ConfigSystem("Get", "Ero-mei")
		}
		d = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			BrickColor: ConfigSystem("Get", "Ero-iro")
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1,1,1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: d
			Scale: Vector3.new(0.4,0.4,0.4)
		}
		fgeld("weld",t1,t1,d,true,-(0.2),-(1.3),-(0.6),0,0,0)
		d2 = d\Clone()
		d2.Parent = mdl
		fgeld("weld",t1,t1,d2,true,0.2,-(1.3),-(0.6),0,0,0)
		c = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			BrickColor: ConfigSystem("Get", "Ero-iro")
			Parent: mdl
			FormFactor: "Custom"
			Size: Vector3.new(0.4,1.3,0.4)
		}
		cm = CreateInstance"CylinderMesh"{
			Parent: c
		}
		a = fgeld("weld",t1,t1,c,true,0,-(1),-(0.52)+(-(c.Size.y)/2),math.rad(-(80)),0,0)
		c2 = d\Clone()
		c2.BrickColor = ConfigSystem("Get", "Ero sentan no iro")
		c2.Mesh.Scale = Vector3.new(0.4,0.62,0.4)
		c2.Parent = mdl
		fgeld("weld",c,c,c2,true,0,0+(c.Size.y/2),0,math.rad(-(10)),0,0)
		d = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			BrickColor: ConfigSystem("Get", "Ero-iro")
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1,1,1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: d
			Scale: Vector3.new(0.4,0.4,0.4)
		}
		fgeld("weld",t1,t1,d,true,-(0.2),-(1.3),-(0.6),0,0,0)
		d2 = d\Clone()
		d2.Parent = mdl
		fgeld("weld",t1,t1,d2,true,0.2,-(1.3),-(0.6),0,0,0)
		c = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			BrickColor: ConfigSystem("Get", "Ero-iro")
			Parent: mdl
			FormFactor: "Custom"
			Size: Vector3.new(0.4,1.3,0.4)
		}
		cm = CreateInstance"CylinderMesh"{
			Parent: c
		}
		a = fgeld("weld",t1,t1,c,true,0,-(1),-(0.52)+(-(c.Size.y)/2),math.rad(-(80)),0,0)
		c2 = d\Clone()
		c2.BrickColor = ConfigSystem("Get", "Ero sentan no iro")
		c2.Mesh.Scale = Vector3.new(0.4,0.62,0.4)
		c2.Parent = mdl
		c2.Name = "Mush"
		fgeld("weld",c,c,c2,true,0,0+(c.Size.y/2),0,math.rad(-(10)),0,0)
}