export modinfo = {
	type: "function"
	id: "Split"
	func: (String) ->
		res = {}
		for s in string.gmatch(String, "[^']+")
			table.insert(res, s)
		if #res == 0
			table.insert(res, String)
		return res

}
