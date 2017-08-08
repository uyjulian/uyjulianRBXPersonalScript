export modinfo = {
	type: "command"
	desc: "Run local Script"
	alias: {"lscr"}
	func: (Msg,Speaker) ->
		if localScript(Msg,workspace)
			Output("Local script running",{Colors.Green},Speaker)
		else
			Output("Local script not inited",{Colors.Red},Speaker)
}