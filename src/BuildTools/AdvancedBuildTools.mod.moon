export modinfo = {
	type: "command"
	desc: "Build Toolss"
	alias: {"bt00ls"}
	func: getDoPlayersFunction (v) ->
		BuildTools = {73089166, 73089204, 73089190, 58880579, 60791062, 73089239, 18474459, 36334760, 58901534, 16975388, 58901405, 58901575}
		if GetBackpack(v)
			for q,w in ipairs(BuildTools)
				ins = Service"InsertService"\LoadAsset(w)
				for _,b in pairs(ins\GetChildren())
					b.Parent = GetBackpack(v)
					ins.Parent = nil
			Output2(string.format("Gave advanced building tools to %s",v.Name),{Colors.Green})
}