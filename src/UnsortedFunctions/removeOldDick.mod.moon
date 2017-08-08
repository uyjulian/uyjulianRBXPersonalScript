export modinfo = {
	type: "function"
	id: "removeOldDick"
	func: (char) ->
		if not char then return
		if not char\IsA("Model") then return
		if not char\FindFirstChild(ConfigSystem("Get", "Ero-mei")) then return
		old = char\FindFirstChild(ConfigSystem("Get", "Ero-mei"))
		old.Parent = nil

}
