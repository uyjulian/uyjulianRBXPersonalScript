export modinfo = {
	type: "command"
	desc: "Tests Output1"
	alias: {"t1"}
	func: (Msg,Speaker) ->
		Output(Msg,{Colors.Green})
}