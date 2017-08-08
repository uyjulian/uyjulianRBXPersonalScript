export modinfo = {
	type: "function"
	id: "fgeld"
	func: (zName, zParent, zPart0, zPart1, zCoco, a, b, c, d, e, f) ->
		CreateInstance"Weld"
			_Init: (obj) ->
				if zCoco
					obj.C0 = CFrame.new(a,b,c) * CFrame.fromEulerAnglesXYZ(d,e,f)
				else
					obj.C1 = CFrame.new(a,b,c) * CFrame.fromEulerAnglesXYZ(d,e,f)
			Name: zName
			Parent: zParent
			Part0: zPart0
			Part1: zPart1

}
