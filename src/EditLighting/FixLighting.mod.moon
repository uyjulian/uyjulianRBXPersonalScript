export modinfo = {
	type: "command"
	desc: "Fix lighting"
	alias: {"flig"}
	func: (Msg,Speaker) ->
		light = Service"Lighting"
		light\ClearAllChildren()
		light.Ambient = Color3.new(1,1,1)
		light.ColorShift_Bottom = Color3.new(0,0,0)
		light.ColorShift_Top = Color3.new(0,0,0)
		light.ShadowColor = Color3.new(.69, .69, .69)
		light.Brightness = .2
		light.FogStart = 0
		light.FogEnd = 100000
		light.FogColor = Color3.new(.74, .74, .74)
		light.TimeOfDay = 12
		Output("Cleaned Lighting",{Colors.Green},Speaker)
		loggit("Cleaned Lighting")
}