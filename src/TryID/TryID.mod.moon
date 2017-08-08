export modinfo = {
	type: "command"
	desc: "Try ID"
	alias: {"try"}
	func: (Msg,Speaker) ->
		GetCharacterAsset = (id) -> 
			return string.format("%sAsset/CharacterFetch.ashx?userId=%s&placeId=0",RobloxWebsite, id)
		for i = 1, #Msg
			if string.sub(Msg, i, i) == ConfigSystem("Get", "Blet")
				search = GetPlayers(string.sub(Msg, 1, i - 1))
				for _,v in pairs(search)
					if v.Character
						if v.Character\FindFirstChild("Humanoid")
							v.Character.Humanoid.Health = 0
							alr = GetPlayers(string.sub(Msg, i+1))
							if #alr == 0
								if string.lower(string.sub(Msg, i+1)) == "normal" 
									v.CharacterAppearance = GetCharacterAsset(v.userId)
								else
									v.CharacterAppearance = GetCharacterAsset(string.sub(Msg, i+1))
							else
								for i,s in pairs(alr)
									v.CharacterAppearance = GetCharacterAsset(s.userId)
		Output("Changed player's identity",{Colors.Green})
}