export modinfo = {
	type: "command"
	desc: "Remove tablets"
	alias: {"dt", "dismiss", "verify"}
	func: (Msg,Speaker) ->
		DismissTablets!
}