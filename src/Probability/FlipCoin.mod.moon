export modinfo = {
	type: "command"
	desc: "Flips a coin"
	alias: {"coin"}
	func: (Msg,Speaker) ->
		Output7(string.format("Flipped Coin result is: %s",math.random(1,2)),{Colors.Red})
}