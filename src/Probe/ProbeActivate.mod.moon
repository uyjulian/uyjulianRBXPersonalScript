export modinfo = {
	type: "command"
	desc: "Activate probe"
	alias: {"probe"}
	func: (Msg,Speaker) ->
		if LocalPlayer.Character
			LocalPlayer.Character = nil
		LoadProbe()
		Output("Probe Loaded",{Colors.Red})
		loggit("You Went Probe Mode")
}