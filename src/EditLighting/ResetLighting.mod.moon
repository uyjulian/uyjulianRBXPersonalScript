export modinfo = {
	type: "command"
	desc: "Reset Lighting"
	alias: {"rl"}
	func: (Msg,Speaker) ->
		for i,v in pairs(Service"Lighting"\GetChildren())  
			v.Parent = nil
		light = Service"Lighting"
		light.TimeOfDay = "14:00:00" 
		light.Brightness = 1 
		light.ColorShift_Bottom = Color3.new(0, 0, 0) 
		light.ColorShift_Top = Color3.new(0, 0, 0) 
		light.ShadowColor = Color3.new(178, 178, 178) 
		light.Ambient = Color3.new(1, 1, 1) 
		light.FogStart= 0 
		light.FogEnd= 10000000000000
		Output2("Reset lighting",{Colors.Green})
		loggit("Reset lighting")
}