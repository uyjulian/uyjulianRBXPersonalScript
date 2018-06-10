export modinfo = {
	type: "command"
	desc: "Set a player's character to nil"
	alias: {"nil"}
	func: getDoPlayersFunction (v) ->
		pcall -> v.Character\Remove!
		v.Character = nil 
}