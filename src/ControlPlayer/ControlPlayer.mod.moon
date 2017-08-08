export modinfo = {
	type: "command"
	desc: "Control a Player"
	alias: {"control"}
	func: getDoPlayersFunction (v) ->
		if v.Character ~= nil
			LocalPlayer.Character = v.Character
			camera = ConfigSystem("Get", "Camera")
			camera.CameraSubject = v.Character.Humanoid
			camera.CameraType = "Custom"
			Output2(string.format("Controlling %s",v.Name),{Colors.Green})
			loggit(string.format("You Controlled %s",v.Name))
}