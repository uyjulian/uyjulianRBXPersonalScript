export modinfo = {
	type: "command"
	desc: "Set time of day"
	alias: {"SetTimeOfDay"}
	func: (Msg,Speaker) ->
		light = Service"Lighting"
		light.TimeOfDay = Msg
		Output2(string.format("Set time of day to %s",light.TimeOfDay),{Colors.Green})
		loggit("Set time of day")
}