export modinfo = {
	type: "command"
	desc: "Jade Curtiss"
	alias: {"jade"}
	func: getDoPlayersFunction (v) ->
		CreateImageCharacter(v.Character, 266756461)
}