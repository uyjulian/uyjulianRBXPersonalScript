export modinfo = {
	type: "command"
	desc: "2D character"
	alias: {"twod"}
	func: getDoPlayersFunction (v) ->
		CreateImageCharacter(v.Character, string.format("%sThumbs/Avatar.ashx?x=200&y=200&Format=Png&username=%s",RobloxWebsite, v.Name), 6, 6)
}