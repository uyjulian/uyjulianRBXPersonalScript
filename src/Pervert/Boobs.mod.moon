export modinfo = {
	type: "command"
	desc: "Boobs"
	alias: {"bb"}
	func: getDoPlayersFunction (v) ->
		size = 3
		t2 = v.Character.Torso
		pcall ->
			rm = v.Character.Torso["Oppai"]
			rm.Parent = nil
		mdl = CreateInstance"Model"{
			Parent: t2
			Name: "Oppai"
		}
		bl = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			BrickColor: BrickColor.new("Pastel brown")
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: bl
			Scale: Vector3.new(1.2, 1.2, 1.2)
		}
		fgeld("weld", mdl, t2, bl, true, -.5, .5, -.6, 0, 0, 0)
		br = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			BrickColor: BrickColor.new("Pastel brown")
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: br
			Scale: Vector3.new(1.2, 1.2, 1.2)
		}
		fgeld("weld", mdl, t2, br, true, .5, .5, -.6, 0, 0, 0)
		bln = CreateInstance"Part"{
			BrickColor: BrickColor.new("Pink")
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: bln
			Scale: Vector3.new(.2, .2, .2)
		}
		fgeld("weld", mdl, t2, bln, true, -.5, .5, -1.2, 0, 0, 0)
		brn = CreateInstance"Part"{
			BrickColor: BrickColor.new("Pink")
			TopSurface: 0
			BottomSurface: 0
			CanCollide: false
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1, 1, 1)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: brn
			Scale: Vector3.new(.2, .2, .2)
		}
		fgeld("weld", mdl, t2, brn, true, .5, .5, -1.2, 0, 0, 0)
}