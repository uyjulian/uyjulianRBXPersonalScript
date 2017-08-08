export modinfo = {
	type: "command"
	desc: "Set Sky"
	alias: {"sky"}
	func: (Msg) ->
		SetSky Msg
}