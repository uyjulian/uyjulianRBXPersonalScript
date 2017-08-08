export modinfo = {
	type: "command"
	desc: "Tougou Tsuyoshi character"
	alias: {"touc"}
	func: getDoPlayersFunction (v) ->
		CreateImageCharacter(v.Character, 264666496)
}