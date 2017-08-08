export modinfo = {
	type: "command"
	desc: "Remove boobs"
	alias: {"unbb"}
	func: getDoPlayersFunction (v) ->
		pcall ->
			tr = v.Character.Torso["Oppai"]
			tr.Parent = nil
}