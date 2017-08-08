export modinfo = {
	type: "command"
	desc: "Turns on/off Chat to tablets"
	alias: {"ct"}
	func: (Msg,Speaker) ->
		if string.lower(Msg) == "on"
			ConfigSystem("Set", "ChatToTablets", true)
			Output2("Chat to tablets on",{Colors.Green})
			loggit("Chat to tablets on")
		elseif string.lower(Msg) == "off"
			ConfigSystem("Set", "ChatToTablets", false)
			Output2("Chat to tablets off",{Colors.Red})
			loggit("Chat to tablets off")
		else 
			Output2("Invalid argument, argument must be on or off",{Colors.Red})
}