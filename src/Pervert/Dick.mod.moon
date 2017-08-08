export modinfo = {
	type: "command"
	desc: "bigdeek"
	alias: {"bigdeek"}
	func: getDoPlayersFunction (v) ->
		color = "Pastel brown"
		pcall ->
			rm = v.Character["Nice thing"]
			rm.Parent = nil
		D = CreateInstance"Model"{
			Parent: v.Character
			Name: "Nice thing"
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
			Size: Vector3.new(.6 * 2, 2.5 * 2, .6 * 2)
			BrickColor: BrickColor.new(color)
			Position: v.Character.Head.Position
			CanCollide: false
		}
		cy = CreateInstance"CylinderMesh"{
			Parent: d
		}
		w = CreateInstance"Weld"{
			Parent: v.Character.Head
			Part0: d
			Part1: v.Character.Head
			C0: CFrame.new(0, .25, 2.1)*CFrame.Angles(math.rad(45),0,0)
		}
		c = CreateInstance"Part"{
			Name: "Mush"
			BottomSurface: 0
			TopSurface: 0
			FormFactor: 3
			Size: Vector3.new(.6 * 2, .6 * 2, .6 * 2)
			CFrame: CFrame.new(d.Position)
			BrickColor: BrickColor.new("Pink")
			CanCollide: false
			Parent: D
		}
		msm = CreateInstance"SpecialMesh"{
			Parent: c
			MeshType: "Sphere"
		}
		cw = CreateInstance"Weld"{
			Parent: c
			Part0: d
			Part1: c
			C0: CFrame.new(0, 2.6, 0)
		}
		ball1 = CreateInstance"Part"{
			Parent: D
			Name: "Left Ball"
			BottomSurface: 0
			TopSurface: 0
			CanCollide: false
			FormFactor: 3
			Size: Vector3.new(1 * 2, 1 * 2, 1 * 2)
			CFrame: CFrame.new(v.Character["Left Leg"].Position)
			BrickColor: BrickColor.new(color)
		}
		bsm = CreateInstance"SpecialMesh"{
			Parent: ball1
			MeshType: "Sphere"
		}
		b1w = CreateInstance"Weld"{
			Parent: ball1
			Part0: v.Character["Left Leg"]
			Part1: ball1
			C0: CFrame.new(0, .5, -.5)
		}
		ball2 = CreateInstance"Part"{
			Parent: D
			Name: "Right Ball"
			BottomSurface: 0
			CanCollide: false
			TopSurface: 0
			FormFactor: 3
			Size: Vector3.new(1 * 2, 1 * 2, 1 * 2)
			CFrame: CFrame.new(v.Character["Right Leg"].Position)
			BrickColor: BrickColor.new(color)
		}
		b2sm = CreateInstance"SpecialMesh"{
			Parent: ball2
			MeshType: "Sphere"
		}
		b2w = CreateInstance"Weld"{
			Parent: ball2
			Part0: v.Character["Right Leg"]
			Part1: ball2
			C0: CFrame.new(0, .5, -.5)
		}
}