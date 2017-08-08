export modinfo = {
	type: "command"
	desc: "ConfigurationVersion"
	alias: {"version"}
	func: (Msg,Speaker) ->
		Output(string.format("Version of this script: %s",ConfigSystem("Get", "Version")),{Colors.Orange})
}