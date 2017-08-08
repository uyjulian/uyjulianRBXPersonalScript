export modinfo = {
	type: "command"
	desc: "Remove Podiums"
	alias: {"rpodiums"}
	func: (Msg,Speaker) ->
		for i,v in pairs(workspace\GetChildren())
			if v.Name == "NilPodium"
				v.Parent = nil
}