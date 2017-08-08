export modinfo = {
	type: "command"
	desc: "Creates Chat Beacon"
	alias: {"beacon"}
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
				CreateInstance"BillboardGui"{
					Size: UDim2.new(3, 0, 3 ,0)
					ExtentsOffset: Vector3.new(0, 2, 0)
					CreateInstance"TextLabel"{
						FontSize: "Size36"
						Font: "ArialBold"
						Text: string.format("%s no chattobikon",LocalPlayer.Name)
						TextTransparency: .3
						BackgroundTransparency: 1
						TextColor3: Color3.new()
						TextStrokeTransparency: 0
						Size: UDim2.new(1,0,1,0)
					}
				}
			}
		}
}