export modinfo = {
	type: "command"
	desc: "Remove Team"
	alias: {"rteam"}
	func: (Msg,Speaker) ->
		teams = Service"Teams"
		for i,v in pairs(teams\GetTeams())
			if string.sub(string.lower(v.Name), 1, #Msg) == string.lower(Msg) or Msg == ""
				v.Parent = nil
		Output2("Removed teams",{Colors.Green})
}