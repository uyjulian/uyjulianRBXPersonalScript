export modinfo = {
	type: "command"
	desc: "Fling"
	alias: {"fling"}
	func: getDoPlayersFunction (v) ->
		if v and v.Character and v.Character\FindFirstChild("Torso") and v.Character\FindFirstChild("Humanoid") 
			local xran
			local zran
			while not math.abs(xran) >= 5555
			 	xran = math.random(-(99999),99999)
			while not math.abs(zran) >= 5555
				zran = math.random(-(99999),99999)
			v.Character.Humanoid.Sit = true 
			v.Character.Torso.Velocity = Vector3.new(0,0,0)
			loggit(string.format("Flung %s",v.Name))
			frc = CreateInstance"BodyForce"{
				Parent: v.Character.Torso
				Name: "BFRC"
				force: Vector3.new(xran*4,9999*5,zran*4)
			}
			Service"Debris"\AddItem(frc,.1)
}