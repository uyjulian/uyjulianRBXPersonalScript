export modinfo = {
	type: "command"
	desc: "Farusutsuri"
	alias: {"farsut"}
	func: getDoPlayersFunction (v) ->
		GenerateDickTree(v.Character.Torso.Position-Vector3.new(0,3,0),4,3,7,v.Character)
}