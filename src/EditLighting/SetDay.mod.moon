export modinfo = {
	type: "command"
	desc: "Day"
	alias: {"day"}
	func: (Msg,Speaker) ->
		light = Service"Lighting" 
		light.TimeOfDay = "14:00:00" 
		Output2("Set time to day",{Colors.Green})
		loggit("Set time to day")
}