export modinfo = {
	type: "command"
	desc: "Remove tablets"
	alias: {"dt", "dismiss"}
	func: (Msg,Speaker) ->
		DismissTablets!
}