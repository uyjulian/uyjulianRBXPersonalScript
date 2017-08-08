export modinfo = {
	type: "command"
	desc: "Get age"
	alias: {"age"}
	func: getDoPlayersFunction (v) ->
		if v ~= nil
			days = v.AccountAge
			weeks = math.floor(days / 7)
			months = math.floor(weeks / 4)
			years = math.floor(months / 12)
			Output(string.format("%s's account age is %s day(s), %s week(s), %s month(s), and %s year(s) old",v.Name, days, weeks, months, years),{Colors.Green})
}