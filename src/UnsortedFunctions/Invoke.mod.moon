export modinfo = {
	type: "function"
	id: "Invoke"
	func: (self, name, ...) ->
		self[name](self, ...)

}
