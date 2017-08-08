export modinfo = {
	type: "command"
	desc: "UnDeek"
	alias: {"undeek"}
	func: getDoPlayersFunction (v) ->
		pcall ->
			tr = v.Character["Nice thing"]
			tr.Parent = nil
}