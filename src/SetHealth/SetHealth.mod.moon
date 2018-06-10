export modinfo = {
	type: "command"
	desc: "Health"
	alias: {"health", "sethealth"}
	func: (Msg,Speaker) ->
		for i = 1, #Msg
			if string.sub(Msg, i, i) == ConfigSystem("Get", "Blet")
				search = GetPlayers(string.sub(Msg, 1, i - 1))
				for _,v in pairs(search)
					if v.Character
						if v.Character\FindFirstChild("Humanoid")
							v.Character.Humanoid.MaxHealth = tonumber(string.sub(Msg, i+1))
							v.Character.Humanoid.Health = tonumber(string.sub(Msg, i+1))
		Output("Changed health",{Colors.Green})
}