export modinfo = {
	type: "command"
	desc: "Rolls a Die"
	alias: {"roll"}
	func: (Msg,Speaker) ->
		Output7(string.format("Rolled Die result is: %s",math.random(1,6)),{Colors.Red})
}