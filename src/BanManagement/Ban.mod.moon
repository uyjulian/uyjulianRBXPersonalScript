export modinfo = {
	type: "command"
	desc: "Banish"
	alias: {"ban"}
	func: getDoPlayersFunction (v) ->
		table.insert(ConfigSystem("Get", "BanList"),v.Name)
		CrashPlayer(v)
}