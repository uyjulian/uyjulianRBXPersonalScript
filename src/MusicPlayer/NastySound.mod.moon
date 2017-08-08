export modinfo = {
	type: "command"
	desc: "Nasty sound"
	alias: {"nsnd", "nastysound"}
	func: getDoPlayersFunction (v) ->
		if not v.Character 
			return
		snd = NewSound("7b509300b5bed2c924d6a0bda990d33b", v.Character, true, 1)
		snd\Play()
}