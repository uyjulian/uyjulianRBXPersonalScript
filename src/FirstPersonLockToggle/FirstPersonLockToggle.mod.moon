export modinfo = {
	type: "command"
	desc: "Turns on/off 1st person lock"
	alias: {"lock1"}
	func: (Msg,Speaker) ->
		if string.lower(Msg) == "on" 
			ConfigSystem("Set", "FirstPersonLock", true)
			Output2("1st person lock on",{Colors.Green})
		elseif(string.lower(Msg) == "off") 
			ConfigSystem("Set", "FirstPersonLock", false)
			Output2("1st person lock off",{Colors.Red})
		else 
			Output2("Invalid argument",{Colors.Red})
}