export modinfo = {
	type: "function"
	id: "Neck1"
	func: (char,segs) ->
		for i = 1,segs
			nseg = CreateInstance"Part"
				Parent: char
				Name: "Part" .. i
				Anchored: false
				CanCollide: true
				Size: Vector3.new 1,1,1
				BrickColor: ConfigSystem "Get", "Ero-iro"
			mseg = CreateInstance"CylinderMesh"
				Parent: nseg
				Scale: Vector3.new 0.3,0.8,0.3
			nseg\BreakJoints!
			wseg = CreateInstance"Weld"
				Parent: nseg
			if i == 1
				wseg.Part0 = char
			else
				wseg.Part0 = char["Part" .. i-1]
			wseg.Part1 = nseg
			if i == 1
				wseg.C1 = CFrame.new 0,-0.8,0.34
			else
				wseg.C1 = CFrame.new 0,-0.8,0.35
			char["Part"..i].Weld.C0 = CFrame.Angles math.pi/4,0,0
			if nseg.Name == 'Part' .. segs
				nseg.Mesh.Parent = nil
				nseg.BrickColor = ConfigSystem "Get", "Ero sentan no iro"
				mesh = CreateInstance"SpecialMesh"
					Parent: nseg
					Scale: Vector3.new 0.4,0.35,0.4
				--nseg.Weld.C1 = CFrame.new(0,0,0) * CFrame.Angles(0,0,0)
				char["Part"..segs].Weld.C0 = CFrame.new(0,0.1,0.8) * CFrame.Angles(math.rad(-55),0,0)

}
