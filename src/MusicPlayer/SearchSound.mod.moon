export modinfo = {
	type: "command"
	desc: "Find sound in dictionary"
	alias: {"ssnd"}
	func: (Msg, Speaker) ->
		tbl = SearchSoundDictionary(Msg)
		for i, v in pairs(tbl)
			Output(string.format("%s : %s", i, v),{Colors.Green})
}