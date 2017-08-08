export modinfo = {
	type: "command"
	desc: "Set a player's character to nil"
	alias: {"nil"}
	func: getDoPlayersFunction (v) ->
		v.Character = nil 
}