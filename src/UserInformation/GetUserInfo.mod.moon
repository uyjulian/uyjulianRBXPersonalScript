export modinfo = {
	type: "command"
	desc: "Get Info"
	alias: {"info"}
	func: getDoPlayersFunction (p) ->
		stat = (p.Character and p.Character\FindFirstChild("Humanoid") and p.Character\FindFirstChild("Humanoid").Health) or ("No char")
		Output(string.format("Info About %s",p.Name),{Colors.Green})
		Output(p.Name,{Colors.Yellow})
		Output(string.format("(%s)",p.ClassName),{Colors.Yellow})
		Output(string.format("Age Is {%s}",p.AccountAge),{Colors.Yellow})
		Output(string.format("The Stats Are [%s]",stat),{Colors.Yellow})
		Output(string.format("User Id Is (%s)",p.userId),{Colors.Yellow})
}