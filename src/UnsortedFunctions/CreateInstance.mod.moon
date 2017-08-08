export modinfo = {
	type: "function"
	id: "CreateInstance"
	func: (ty) ->
		(data) ->
			obj = Instance.new ty
			for k, v in pairs data
				if type(k) == "number"
					if pcall game.IsA, v, "Instance"
						v.Parent = obj
				elseif type(v) == "function"
					v obj
				else
					obj[k] = v
			obj

}
