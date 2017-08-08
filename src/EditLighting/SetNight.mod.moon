export modinfo = {
	type: "command"
	desc: "Night"
	alias: {"night"}
	func: (Msg,Speaker) -> 
		light = Service"Lighting"
		light.TimeOfDay = "24:00:00" 
		Output2("Set time to night",{Colors.Green})
		loggit("Set time to night")
}