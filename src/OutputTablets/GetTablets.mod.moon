export modinfo = {
	type: "function"
	id: "GetTablets"
	func: (Player) ->
		Tablets = {}
		for i, v in pairs(GetOutput(Player)\GetChildren!)
			if v.Parent and v\FindFirstChild "koshin kanona"
				table.insert Tablets, v
		Tablets

}
