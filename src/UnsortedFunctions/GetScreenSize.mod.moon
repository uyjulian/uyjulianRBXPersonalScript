export modinfo = {
	type: "function"
	id: "GetScreenSize"
	func: ->
		mse = LocalPlayer\GetMouse!
		mse.ViewSizeX, mse.ViewSizeY

}
