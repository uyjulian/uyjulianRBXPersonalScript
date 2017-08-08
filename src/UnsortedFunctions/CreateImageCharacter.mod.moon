export modinfo = {
	type: "function"
	id: "CreateImageCharacter"
	func: (char, img, x = 4, y = 6) ->
		ss = CreateInstance"Part"{
			TopSurface: "Smooth"
			Transparency: 1
			CanCollide: false
			Size: Vector3.new x, y, 1
			FormFactor: "Symmetric"
			BottomSurface: "Smooth"
			CFrame: CFrame.new 0, 3, 4.5, 1, 0, 0, 0, 1, 0, 0, 0, 1
			Position: Vector3.new 0, 3, 4.5
			CreateInstance"SurfaceGui"{
				CreateInstance"ImageLabel"{
					Image: ParseAsset img
					BorderSizePixel: 0
					Size: UDim2.new 1, 0, 1, 0
					BackgroundTransparency: 1
					BackgroundColor3: Color3.new 1, 1, 1
				}
			}
		}
		char.Torso.Transparency = 1
		char.Head.Transparency = 1
		char["Left Arm"].Transparency = 1
		char["Left Leg"].Transparency = 1
		char["Right Arm"].Transparency = 1
		char["Right Leg"].Transparency = 1
		w = CreateInstance"ManualWeld"
			Parent: ss
			Part0: char.Torso
			Part1: ss
		ss.Parent = char
}
