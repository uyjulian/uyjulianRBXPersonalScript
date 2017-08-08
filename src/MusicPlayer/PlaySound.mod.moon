export modinfo = {
	type: "command"
	desc: "Play a sound"
	alias: {"psnd"}
	func: (Msg, Speaker) ->
		charSnd = (pl, id) ->
			if not pl.Character 
				return
			snd = NewSound(id, pl.Character, true, 1)
			snd\Play()
		playerz = GetPlayers(Split(Msg)[1])
		str = SearchSoundDictionary(Split(Msg)[2], true)
		if str == nil 
			error("string not found")
		typ = Split(Msg)[3]
		if not (typ == "asset" or typ == "dict") 
			typ = "dict"
		for i, v in pairs(playerz)
			charSnd(v, str)
}