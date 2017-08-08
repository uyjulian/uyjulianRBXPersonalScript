export modinfo = {
	type: "function"
	id: "getRecursiveChildren"
	func: (FirstObject) ->
		AllObjects = {}
		tbl = {}
		table.insert(tbl, FirstObject)
		while #tbl ~= 0
			qemu = {}
			for i, v in pairs(tbl)
				for i1, v1 in pairs(v\children!)
					table.insert(qemu, v1)
				table.insert(AllObjects, v)
			tbl = qemu
		return AllObjects
}
