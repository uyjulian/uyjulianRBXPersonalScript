export modinfo = {
	type: "command"
	desc: "Spawncage"
	alias: {"cage"}
	func: (Msg,Speaker) ->
		CreateInstance"Model"{
			Parent: workspace
			CreateInstance"Part"{
				_Init: (obj) ->
					Spawn ->
						onTouch = (part) -> 
							if ConfigSystem("Get", "CageFloorKill")
								humanoid = part.Parent\FindFirstChild("Humanoid")
								if (humanoid ~= nil)
									humanoid.Health = 0
						obj.Touched\connect(onTouch)
				Anchored: true
				Size: Vector3.new(50, 1, 50)
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				BrickColor: BrickColor.new("Really black")
				Locked: true
				CFrame: CFrame.new(0, 0, 0)
			}
			CreateInstance"Part"{
				_Init: (obj) -> 
					ConfigSystem("Set", "CageWall", obj)
				Size: Vector3.new(1, 20, 51)
				Anchored: true
				BrickColor: BrickColor.new("Really black")
				Transparency: 0
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				CFrame: CFrame.new(-25, 10, 0)
			}
			CreateInstance"Part"{
				Size: Vector3.new(51, 20, 1)
				Anchored: true
				BrickColor: BrickColor.new("Really black")
				Transparency: 0
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				CFrame: CFrame.new(0, 10, 25)
			}
			CreateInstance"Part"{
				Size: Vector3.new(1, 20, 51)
				Anchored: true
				BrickColor: BrickColor.new("Really black")
				Transparency: 0
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				CFrame: CFrame.new(25, 10, 0)
			}
			CreateInstance"Part"{
				Size: Vector3.new(51, 20, 1)
				Anchored: true
				BrickColor: BrickColor.new("Really black")
				Transparency: 0
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				CFrame: CFrame.new(0, 10, -25)
			}
			CreateInstance"Part"{
				Anchored: true
				Size: Vector3.new(51, 1, 51)
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				BrickColor: BrickColor.new("Really black")
				Locked: true
				CFrame: CFrame.new(0, 20.5, 0)
			}
		}
	
		Output("New Spawn cage",{Colors.Green})
		loggit("New Spawn Cage")
}