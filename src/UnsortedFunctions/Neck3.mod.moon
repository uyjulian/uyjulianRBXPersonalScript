export modinfo = {
	type: "function"
	id: "Neck3"
	func: (char,segs) ->
		for i = 1,segs
			nseg = CreateInstance"Part"
				Parent: char
				Name: "seg" .. i
				Anchored: false
				CanCollide: true
				Size: Vector3.new 1,1,1
				BrickColor: ConfigSystem "Get", "Ero-iro"
			mseg = CreateInstance"CylinderMesh"
				Parent: nseg
				Scale: Vector3.new 1,1,1
			nseg\BreakJoints!
			wseg = CreateInstance"Weld"
				Parent: nseg
			if i == 1
				wseg.Part0 = char
			else
				wseg.Part0 = char["seg" .. i-1]
			wseg.Part1 = nseg
			if i == 1
				wseg.C1 = CFrame.new 0,-1,0
			else
				wseg.C1 = CFrame.new 0,-0.8,0
			if nseg.Name == "seg" .. segs 
				nseg.Mesh.Parent = nil
				nseg.BrickColor = ConfigSystem "Get", "Ero sentan no iro"
				mseg = CreateInstance"SpecialMesh"
					Parent: nseg
					Scale: Vector3.new 1,0.8,1
			char["seg" .. i].Weld.C0 = CFrame.Angles math.rad(1.5),0,0
			if i > segs
				nseg.Transparency = 1

}
