export modinfo = {
	type: "command"
	desc: "Teleport to the center of the level"
	alias: {"home"}
	func: (Msg,Speaker) ->
		LocalPlayer.Character.Torso.CFrame = CFrame.new(0,20,0)
		loggit("Went to the center of the level")
}