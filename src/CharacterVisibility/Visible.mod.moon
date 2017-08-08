export modinfo = {
	type: "command"
	desc: "Visible"
	alias: {"visible"}
	func: getDoPlayersFunction (v) ->
		if v and v.Character 
			for a,obj in pairs(v.Character\GetChildren()) 
				if obj\IsA"BasePart" 
					obj.Transparency = 0 
					if obj\FindFirstChild"face" 
						obj.face.Transparency = 0 
				elseif obj\IsA"Hat" and obj\FindFirstChild"Handle" 
					obj.Handle.Transparency = 0 
}