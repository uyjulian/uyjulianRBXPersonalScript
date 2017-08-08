export modinfo = {
	type: "command"
	desc: "Name"
	alias: {"name"}
	func: (Msg,Speaker) ->
		Split = Msg\find(ConfigSystem("Get", "Blet"))
		for _,v in pairs(GetPlayers(Msg\sub(1,Split-1),Speaker))
			pcall ->
				OldHead = v.Character.Head
				Model = CreateInstance"Model"{
					Parent: v.Character.Head
					Name: Msg\sub(Split+1)
				}
				Head = OldHead\Clone()
				Head.Parent = Model
				Head.Transparency = 0
				Head.Name = "Head"
				Head.CanCollide = false
				Hum = CreateInstance"Humanoid"{
					Parent: Model
					MaxHealth: 0
					Health: 0
				}
				Weld = CreateInstance"Weld"{
					Parent: Head
					Part0: Head
					Part1: OldHead
					C0: CFrame.new(0,0,0)
				}
				OldHead.Transparency = 1
}