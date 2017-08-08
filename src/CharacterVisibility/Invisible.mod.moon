export modinfo = {
	type: "command"
	desc: "Invisible"
	alias: {"invisible"}
	func: getDoPlayersFunction (v) ->
		if v and v.Character 
			for a, obj in pairs(v.Character\GetChildren()) 
				if obj\IsA"BasePart" 
					obj.Transparency = 1 
					if obj\FindFirstChild"face" 
						obj.face.Transparency = 1 
				elseif obj\IsA"Hat" and obj\FindFirstChild"Handle"
					obj.Handle.Transparency = 1 
}