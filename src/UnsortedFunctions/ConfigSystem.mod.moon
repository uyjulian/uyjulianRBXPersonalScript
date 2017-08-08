export modinfo = {
	type: "function"
	id: "ConfigSystem"
	func: (Action, Key, Value) ->
		if Action == "Get"
			return Configuration[Key]
		elseif Action == "Set"
			Configuration[Key] = Value
			return
		error "Action was not specified"
}
