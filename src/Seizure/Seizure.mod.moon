export modinfo = {
	type: "command"
	desc: "Make a player have a seizure"
	alias: {"seizure"}
	func: getDoPlayersFunction (v) ->
		Spawn ->
			ConfigSystem("Set", "DisSei"..v.Name, false)
			g = v.Character 
			while not ConfigSystem("Get", "DisSei"..v.Name)
				wait() 
				g.Humanoid.PlatformStand = true  
				g.Torso.Velocity = Vector3.new(math.random(-(10),10),-(5),math.random(-(10),10)) 
				g.Torso.RotVelocity = Vector3.new(math.random(-(5),5),math.random(-(5),5),math.random(-(5),5)) 
}