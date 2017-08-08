export modinfo = {
	type: "command"
	desc: "Change base size"
	alias: {"bvec"}
	func: (Msg,Speaker) ->
		Base = workspace\FindFirstChild("Base")
		Base.Size = Vector3.new(tonumber(Msg),1,tonumber(Msg))
		Output2("Changed base size",{Colors.Green},LocalPlayer)
}