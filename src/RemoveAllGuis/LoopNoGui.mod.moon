export modinfo = {
	type: "command"
	desc: "NoGui"
	alias: {"noscr"}
	func: getDoPlayersFunction (v) ->
		while wait()
			Spawn ->
				GetPlayerGui(v)\ClearAllChildren()
}