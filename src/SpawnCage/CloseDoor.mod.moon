export modinfo = {
	type: "command"
	desc: "CloseDoor"
	alias: {"closedoor"}
	func: (Msg,Speaker) ->
		wall = ConfigSystem("Get", "CageWall")
		if wall == nil 
			Output2("No jail detected",{Colors.Green}) 
			return
		wall.CanCollide = true
		wall.Transparency = 0
		Output2("Closed door",{Colors.Red})
		loggit("Closed door")
}