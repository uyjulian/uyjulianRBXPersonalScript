export modinfo = {
	type: "command"
	desc: "BillboardGui name"
	alias: {"bname"}
	func: (Msg,Speaker) ->
		Split = Msg\find(ConfigSystem("Get", "Blet"))
		for _,v in pairs(GetPlayers(Msg\sub(1,Split-1),Speaker))
			pcall ->
				OldHead = v.Character.Head
				Model = CreateInstance"Model"{
					Parent: v.Character.Head
					Name: ""
					CreateInstance"Humanoid"
						MaxHealth: 0
						Health: 0
				}
				BB = CreateInstance"BillboardGui"{
					Parent: OldHead
					Size: UDim2.new(0, 200, 0 ,200)
					ExtentsOffset: Vector3.new(0, 2, 0)
					CreateInstance"TextLabel"
						FontSize: "Size36"
						Font: "ArialBold"
						Text: Msg\sub(Split+1)
						TextTransparency: .3
						TextColor3: BrickColor.new("Black").Color
						TextStrokeTransparency: 0
						Position: UDim2.new(.5, 0, .5, 0)
				}
				Head = OldHead\Clone()
				Head.Parent = Model
				Head.Transparency = 0
				Head.Name = "Head"
				Head.CanCollide = false
				Weld = CreateInstance"Weld"
					Parent: Head
					Part0: Head
					Part1: OldHead
					C0: CFrame.new(0,0,0)
				OldHead.Transparency = 1
}