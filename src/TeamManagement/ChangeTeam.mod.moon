export modinfo = {
	type: "command"
	desc: "Change Player Team"
	alias: {"pteam", "team"}
	func: (Msg,Speaker) ->
		Split = Msg\find(ConfigSystem("Get", "Blet"))
		for i,v in pairs(GetPlayers(Msg\sub(1,Split-1),Speaker))
			if Split[2]\lower() == "neutral"
				v.Neutral = true
			if Split[2]\lower() == "nneutral"
				v.Neutral = false
			for c,b in pairs(Service"Teams"\GetChildren(Msg\sub(Split+1),Speaker))
				v.TeamColor = b.TeamColor
				loggit(string.format("You Changed the team of %s",v.Name))
}