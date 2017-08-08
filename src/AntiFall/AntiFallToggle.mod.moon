export modinfo = {
	type: "command"
	desc: "Toggle ConfigurationAntiFall on/off"
	alias: {"antifall"}
	func: (Msg, Speaker) ->
		if string.lower(Msg) == "on"
			ConfigSystem("Set", "AntiFall", true)
			Output2("Antifall on",{Colors.Green})
		elseif (string.lower(Msg) == "off")
			ConfigSystem("Set", "AntiFall", false)
			Output2("Antifall off",{Colors.Red})
		else 
			Output2("Message must be on/off",{Colors.Red})

}