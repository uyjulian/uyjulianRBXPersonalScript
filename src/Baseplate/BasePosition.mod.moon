export modinfo = {
	type: "command"
	desc: "Change base position"
	alias: {"bcfr"}
	func: (Msg,Speaker) ->
		Base = workspace\FindFirstChild("Base")
		Base.CFrame = CFrame.new(tonumber(Msg),1,tonumber(Msg))
		Output2("Changed base ",{Colors.Green},LocalPlayer)
}