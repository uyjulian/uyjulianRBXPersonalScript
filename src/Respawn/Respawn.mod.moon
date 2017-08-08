export modinfo = {
	type: "command"
	desc: "Respawn"
	alias: {"respawn"}
	func: getDoPlayersFunction (v) ->
		v.Character = CreateInstance"Model"{
			Parent: workspace
			CreateInstance"Part"{
				Transparency: 1
				CanCollide: false
				Anchored: true
				Name: "Torso"
				Position: Vector3.new(10000,10000,10000)
			}
			CreateInstance"Humanoid"{
				_Init: (obj) -> 
					Spawn -> 
						obj.Torso = obj.Parent\FindFirstChild("Torso")
			}
		}
		Output4(string.format("Respawned %s",v.Name),{Colors.Green}) 
		loggit(string.format("Respawned %s",v.Name))
}