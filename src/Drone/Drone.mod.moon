export modinfo = {
	type: "command"
	desc: "Creates Pet"
	alias: {"drone"}
	func: getDoPlayersFunction (v) ->
		om = CreateInstance"Part"{
			_Init: (obj) -> 
				Spawn ->
					while wait() 
						obj.CFrame = v.Character.Head.CFrame * CFrame.new(0, 3, 4)
			Parent: v.Character
			Shape: "Ball"
			Size: Vector3.new(2, 2, 2)
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			BrickColor: BrickColor.new("Really black")
			Anchored: true
			CFrame: v.Character.Head.CFrame * CFrame.new(0, 8, 0)
		}
		oo = CreateInstance"Part"{
			_Init: (obj) -> 
				Spawn ->
					while wait() 
						obj.CFrame = v.Character.Head.CFrame * CFrame.new(0, 3, 4)
			Parent: v.Character
			Shape: "Ball"
			Size: Vector3.new(4, 4, 4)
			TopSurface: "Smooth"
			BottomSurface: "Smooth"
			BrickColor: BrickColor.new("Really red")
			Transparency: .7
			Anchored: true
			CFrame: v.Character.Head.CFrame * CFrame.new(0, 8, 0)
			CreateInstance"BillboardGui"{
				Size: UDim2.new(3, 0, 3 ,0)
				ExtentsOffset: Vector3.new(0, 2, 0)
				CreateInstance"TextLabel"{
					FontSize: "Size36"
					Font: "ArialBold"
					Text: "Anata no petto"
					TextTransparency: .3
					BackgroundTransparency: 1
					TextColor3: Color3.new()
					TextStrokeTransparency: 0
					Size: UDim2.new(1,0,1,0)
				}
			}
			CreateInstance"SelectionPartLasso"{
				_Init: (obj) -> 
					Spawn -> 
						obj.Part = obj.Parent
				Humanoid: v.Character and v.Character\FindFirstChild("Humanoid")
				Color: BrickColor.new("Really red")
				Transparency: 0
			}
		}
}