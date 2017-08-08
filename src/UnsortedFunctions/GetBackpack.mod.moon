export modinfo = {
	type: "function"
	id: "GetBackpack"
	func: (Player) ->
		for i, v in pairs Player\GetChildren!
			if v\IsA"Backpack"
				return v
		return nil
}
