export modinfo = {
	type: "command"
	desc: "Name"
	alias: {"SN"}
	func: (Msg,Speaker) ->
		Output(string.format("This script's name is: %s",Name),{Colors.Orange})
}