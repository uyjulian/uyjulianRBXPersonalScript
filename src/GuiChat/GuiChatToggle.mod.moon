export modinfo = {
	type: "command"
	desc: "Turn GUI chat off/on"
	alias: {"Gui"}
	func: (Msg,Speaker) ->
		if Msg\lower() == "on" or Msg\lower() == "true"
			loggit("Enabled GUI chat")
			ConfigSystem("Set", "EnableGuiChat", true)
		elseif Msg\lower() == "off" or Msg\lower() == "false"
			loggit("Disabled GUI chat")
			ConfigSystem("Set", "EnableGuiChat", false)
		else
			Output5("Invalid argument",{Colors.Green})
}