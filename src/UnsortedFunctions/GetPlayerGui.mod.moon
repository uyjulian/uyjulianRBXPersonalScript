export modinfo = {
	type: "function"
	id: "GetPlayerGui"
	func: (player) ->
		for i, v in pairs player\GetChildren!
			if v\IsA"PlayerGui"
				return v
		return nil
}
