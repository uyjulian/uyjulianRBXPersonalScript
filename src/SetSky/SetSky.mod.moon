export modinfo = {
	type: "command"
	desc: "Set Sky"
	alias: {"sky", "skybox"}
	func: (Msg) ->
		SetSky Msg
}