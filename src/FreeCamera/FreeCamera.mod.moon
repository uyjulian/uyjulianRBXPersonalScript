export modinfo = {
	type: "command"
	desc: "Free camera"
	alias: {"freecam"}
	func: ->
		if LocalPlayer.Character ~= nil
			LocalPlayer.Character.Parent = nil
		LocalPlayer.Character = nil
		camera = ConfigSystem("Get", "Camera")
		camera.CameraType = "Fixed"
		camera.CameraSubject = nil
}