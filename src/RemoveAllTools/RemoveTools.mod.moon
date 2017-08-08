export modinfo = {
	type: "command"
	desc: "Remove Tools"
	alias: {"rtools"}
	func: getDoPlayersFunction (v) ->
		if v\FindFirstChild("Backpack") ~= nil
			if v.Character
				for i,s in pairs(v.Character\GetChildren())
					if s\IsA"Tool" or v\IsA"Model"
						s.Parent = nil
			for i,s in pairs(GetBackpack(v)\GetChildren()) 
				s.Parent = nil
}