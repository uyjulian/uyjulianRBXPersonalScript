export modinfo = {
	type: "command"
	desc: "Locks all Players Guis"
	alias: {"rguis"}
	func: getDoPlayersFunction (v) ->
		GetPlayerGui(v)\ClearAllChildren()
}