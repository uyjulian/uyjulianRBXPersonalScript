export modinfo = {
	type: "command"
	desc: "Oppai2"
	alias: {"oppai"}
	func: getDoPlayersFunction (v, msg) ->
		size = Split(msg)[2] or 1
		abcd = size*2
		v.Character.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
		t2 = v.Character.Torso
		mdl = CreateInstance"Model"{
			Parent: t2
			Name: "Bewbs"
		}
		bl = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			BrickColor: ConfigSystem("Get", "Ero-iro")
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(size,size,size)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: bl
			Scale: Vector3.new(1.2,1.2,1.2)
		}
		fgeld("weld",mdl,t2,bl,true,-(size)/2,size/abcd,-(size)/2,0,0,0)
		br = CreateInstance"Part"{
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			BrickColor: ConfigSystem("Get", "Ero-iro")
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(size,size,size)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: br
			Scale: Vector3.new(1.2,1.2,1.2)
		}
		fgeld("weld",mdl,t2,br,true,size/2,size/abcd,-(size)/2,0,0,0)
		bln = CreateInstance"Part"{
			BrickColor: ConfigSystem("Get", "Ero sentan no iro")
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1,1,1)
			CFrame: CFrame.new(bl.Position)
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: bln
			Scale: Vector3.new(size/10,size/10,size/10)
		}
		if size == 1
			dm.Scale = Vector3.new(0.2,0.2,0.2)
		fgeld("weld",mdl,t2,bln,true,-(size)/2,size/abcd,-(size) + -(size)/10,0,0,0)
		brn = CreateInstance"Part"{
			BrickColor: ConfigSystem("Get", "Ero sentan no iro")
			TopSurface: 0
			BottomSurface: 0
			CanCollide: true
			Shape: "Ball"
			Parent: mdl
			Size: Vector3.new(1,1,1)
			CFrame: CFrame.new(br.Position)	
		}
		dm = CreateInstance"SpecialMesh"{
			MeshType: "Sphere"
			Parent: brn
			Scale: Vector3.new(size/10,size/10,size/10)
		}
		if size == 1
			dm.Scale = Vector3.new(0.2,0.2,0.2)
		fgeld("weld",mdl,t2,brn,true,size/2,size/abcd,-(size) + -(size)/10,0,0,0)
}