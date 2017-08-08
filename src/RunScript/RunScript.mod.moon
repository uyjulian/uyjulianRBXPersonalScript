export modinfo = {
	type: "command"
	desc: "Run normal Script"
	alias: {"scr"}
	func: (Msg,Speaker) ->
		if NewSource(Msg,workspace)
			Output("Normal script running",{Colors.Green},Speaker)
		else
			Output("Normal script not inited",{Colors.Red},Speaker)
}