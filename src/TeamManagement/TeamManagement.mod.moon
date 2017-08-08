export modinfo = {
	type: "command"
	desc: "New Team"
	alias: {"newteam"}
	func: (Msg,Speaker) ->
		team = CreateInstance"Team"{
			Parent: Service"Teams"
			Name: Msg
			TeamColor: BrickColor.random()
		}
		Output2(string.format("Created new team %s.",team.Name),{Colors.Green})
}