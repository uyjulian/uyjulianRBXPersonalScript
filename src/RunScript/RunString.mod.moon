export modinfo = {
	type: "command"
	desc: "Loadstring"
	alias: {"load"}
	func: (Msg,Speaker) ->
		loggit("You Used Loadstring")
		Ran,Error = Spawn -> 
			loadstring(Msg)()
		if not Ran
			Output(Error,{Colors.Red})
		else
			Output("Script ran",{Colors.Green})
}