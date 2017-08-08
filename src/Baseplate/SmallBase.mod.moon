export modinfo = {
	type: "command"
	desc: "Small base"
	alias: {"sbase"}
	func: (Msg,Speaker) ->
		Base = workspace\FindFirstChild("Base")
		Base.Size = Vector3.new(50,1,50)
		Base.CFrame = CFrame.new(0,0,0)
		Output2("Made base smaller",{Colors.Green},LocalPlayer)
}