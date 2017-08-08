export modinfo = {
	type: "function"
	id: "loggit"
	func: (Message) ->
		table.insert ConfigSystem("Get", "Log"), string.format("%s - %s", GetTime!, Message)

}
