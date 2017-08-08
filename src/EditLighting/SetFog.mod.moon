export modinfo = {
	type: "command"
	desc: "Fog on/off"
	alias: {"fog"}
	func: (Msg,Speaker) ->
		light = Service"Lighting"
		if string.lower(Msg) == "on"
			light.FogStart = 0 
			light.FogEnd = 100 
			Output2("Fogs on",{Colors.Green})
			loggit("Fogs on")
		elseif(string.lower(Msg) == "off")
			light.FogStart = 0 
			light.FogEnd = 9e9
			Output2("Fogs off",{Colors.Green})
			loggit("Fogs off")
		else 
			Output2("Message must be on/off",{Colors.Red})
}