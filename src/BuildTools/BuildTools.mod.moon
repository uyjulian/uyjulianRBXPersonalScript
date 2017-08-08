export modinfo = {
	type: "command"
	desc: "Build Tools"
	alias: {"btools"}
	func: getDoPlayersFunction (v) ->
		if GetBackpack(v)
			BinTable = {1, 3, 4}
			for i = 1, 3 do
				CreateInstance"HopperBin"
					Parent: GetBackpack(v)
					BinType: BinTable[i]
			Output(string.format("Gave building tools to %s",v.Name),{Colors.Green})
}