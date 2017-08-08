export modinfo = {
	type: "command"
	desc: "Removes all jails"
	alias: {"rj"}
	func: (Msg,Speaker) ->
		x = workspace\FindFirstChild("Main")
		pcall -> x.Parent = nil
}