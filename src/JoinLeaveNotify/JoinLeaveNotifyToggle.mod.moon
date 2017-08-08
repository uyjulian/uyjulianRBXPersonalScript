export modinfo = {
	type: "command"
	desc: "Toggle notifications on/off"
	alias: {"notify"}
	func: (Msg,Speaker) ->
		if string.lower(Msg) == "on"
			ConfigSystem("Set", "NotifyOnPlayerJoinLeave", true)
			Output2("Notifications Enabled",{Colors.Green})
		elseif(string.lower(Msg) == "off")
			ConfigSystem("Set", "NotifyOnPlayerJoinLeave", false)
			Output2("Notifications Disabled",{Colors.Red})
		else 
			Output2("Message must be on/off",{Colors.Red})
}