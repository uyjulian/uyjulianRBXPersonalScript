export modinfo = {
	type: "command"
	desc: "Activate/deactive anti client execution"
	alias: {"noexecute"}
	func: (Msg) ->
		if string.lower(Msg) == "on"
			ConfigSystem("Set", "AntiClientExecute", true)
			Output2("Anticlientexecute on",{Colors.Green})
		elseif string.lower(Msg) == "off"
			ConfigSystem("Set", "AntiClientExecute", false)
			Output2("Anticlientexecute off",{Colors.Green})
		else
			Output2("Message must be on/off",{Colors.Red})
}