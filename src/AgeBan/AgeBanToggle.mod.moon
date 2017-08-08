export modinfo = {
	type: "command"
	desc: "Turn Age Ban Phrases on/off"
	alias: {"ConfigurationAgeBan"}
	func: (Msg, Speaker) ->
		if string.lower(Msg) == "on"
			ConfigSystem("Set", "AgeBan", true)
			Output2("Age Banning on", {Colors.Green})
		elseif (string.lower(Msg) == "off")
			ConfigSystem("Set", "AgeBan", false)
			Output2("Age Banning off", {Colors.Red})
		else 
			Output2("Invalid argument, argument must be on or off", {Colors.Red})

}