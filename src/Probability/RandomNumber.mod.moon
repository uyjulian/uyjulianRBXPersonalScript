export modinfo = {
	type: "command"
	desc: "Gets a random number"
	alias: {"rand"}
	func: (Msg,Speaker) ->
		Output7(string.format("Random number below %s result is: %s",Msg, math.random(tonumber(Msg))),{Colors.Red})
}