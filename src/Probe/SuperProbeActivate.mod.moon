export modinfo = {
	type: "command"
	desc: "Activates Your Super Probe"
	alias: {"sprobe"}
	func: (Msg,Speaker) ->
		if LocalPlayer.Character
			LocalPlayer.Character = nil
		LoadProBlet()
		Output("Super Probe Loaded",{Colors.Red})
		loggit("You Went Super Probe Mode")
}