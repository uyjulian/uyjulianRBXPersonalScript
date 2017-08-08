export modinfo = {
	type: "command"
	desc: "Change Walkspeed"
	alias: {"walkspeed"}
	func: (Msg,Speaker) ->
		for i = 1, #Msg
			if string.sub(Msg, i, i) == ConfigSystem("Get", "Blet")
				search = GetPlayers(string.sub(Msg, 1, i - 1))
				for _,v in pairs(search)
					if v.Character
						if v.Character\FindFirstChild("Humanoid")
							v.Character.Humanoid.WalkSpeed = tonumber(string.sub(Msg, i+1))
		Output("Changed walkspeed",{Colors.Green}) 
}