export modinfo = {
	type: "command"
	desc: "Change Ambient"
	alias: {"ambient"}
	func: (Msg,Speaker) ->
		taaa = Split(Msg)
		light = Service"Lighting"
		light.Ambient = Color3.new(taaa[1], taaa[2], taaa[3])
		Output2("Changed ambient",{Colors.Green})
}