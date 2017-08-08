export modinfo = {
	type: "command"
	desc: "Disconnect"
	alias: {"disc"}
	func: (Msg,Speaker) ->
		Val = CreateInstance"StringValue"{
			Parent: workspace
			Name: string.format("Disconnect : %s",Msg)
		}
		Output2(string.format("Attempted to disconnect: %s",Msg),{Colors.Green},Speaker)
}