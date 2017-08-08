export modinfo = {
	type: "command"
	desc: "Get Asset"
	alias: {"getasset"}
	func: (Msg,Speaker) ->
		for id in Msg\gmatch("%d+")
			asset_id = tonumber(id)
			if asset_id ~= nil then
				root = Service"InsertService"\LoadAsset(asset_id)
				for a, b in pairs(root\GetChildren())
					if b\IsA"Hat" or b\IsA"Tool"
						if LocalPlayer.Character
							b.Parent = LocalPlayer.Character
							Output2(string.format("%s has been given %s \"%s\" [%s]", LocalPlayer.Name, b.className, b.Name, tostring(asset_id)),{Colors.Green})
}