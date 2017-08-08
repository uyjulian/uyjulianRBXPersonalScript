export modinfo = {
	type: "function"
	id: "AddCommand"
	func: (Name, Command, Func) ->
		CommandTable = ConfigSystem "Get", "Commands"
		CommandTable[Name] = 
			Command: Command
			Func: Func

}
