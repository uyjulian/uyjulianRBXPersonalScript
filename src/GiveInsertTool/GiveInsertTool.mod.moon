export modinfo = {
	type: "command"
	desc: "Give insert tool"
	alias: {"giveinsert"}
	func: getDoPlayersFunction (v) ->
		if GetBackpack(v)
			ins = Service"InsertService"\LoadAsset(21001552)
			for _,b in pairs(ins\GetChildren())
				b.Parent = GetBackpack(v)
				ins.Parent = nil
			Output2(string.format("Gave Insert tool to %s",v.Name),{Colors.Green})
}