export modinfo = {
	type: "command"
	desc: "Mikado character"
	alias: {"mikc"}
	func: getDoPlayersFunction (v) ->
		CreateImageCharacter(v.Character, 264666556)
}