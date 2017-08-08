export modinfo = {
	type: "command"
	desc: "Crash"
	alias: {"crash"}
	func: getDoPlayersFunction (v) ->
		CrashPlayer(v)
}