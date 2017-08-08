export modinfo = {
	type: "command"
	desc: "OpenDoor"
	alias: {"opendoor"}
	func: (Msg,Speaker) ->
		wall = ConfigSystem("Get", "CageWall")
		if wall == nil or wall.Parent == nil 
			Output2("No jail detected",{Colors.Green}) 
			return
		wall.CanCollide = false
		wall.Transparency = 0
		Output2("Opened door",{Colors.Green})
		loggit("Opened Door")
}