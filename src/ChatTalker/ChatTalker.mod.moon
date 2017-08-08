export modinfo = {
	type: "command"
	desc: "Chat Talker"
	alias: {"chatt"}
	func: (Msg,Speaker) ->
		loggit("Created Beacon")
		CreateInstance"Model"{
			Parent: workspace
			Name: "ChatBeacon"
			CreateInstance"Part"{
				Anchored: true
				Shape: "Ball"
				CanCollide: false
				Size: Vector3.new(1,1,1)
				Transparency: 1
				BrickColor: BrickColor.new("Really black")
				TopSurface: 0
				BottomSurface: 0
			}
			CreateInstance"Part"{
				_Init: (obj) ->
					Spawn ->
						while wait()
							wait(3)
							texts = {"Onions taste good.", "Yummy!"}
							m = math.random(1, #texts)
							c = Service"Chat"
							c\Chat(obj, texts[m], "Red")
				Name: "Head"
				Anchored: true
				CanCollide: false
				Shape: "Ball"
				Size: Vector3.new(3,3,3)
				Transparency: .75
				BrickColor: BrickColor.new("Medium stone grey")
				Material: "Slate"
				Reflectance: 1
				TopSurface: 0
				BottomSurface: 0
			}
		}
}