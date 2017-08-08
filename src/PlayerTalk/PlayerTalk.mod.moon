export modinfo = {
	type: "command"
	desc: "Make Players Talk"
	alias: {"pmsg"}
	func: (Msg,Speaker) ->
		for _,talky in pairs(GetPlayers())
			charnam = CharacterName or LocalPlayer.Name
			Service"Chat"\Chat(talky.Character.Head,Msg,"Blue")
			for i,v in pairs(workspace\GetChildren())
				if v\IsA"Part" then
					Service"Chat"\Chat(v,Msg,"Red")
}