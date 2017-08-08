export modinfo = {
	type: "function"
	id: "Chat"
	func: (Msg) ->
		chatPart = (LocalPlayer.Character and LocalPlayer.Character\FindFirstChild"Head") or (Probe)
		if chatPart
			Part = CreateInstance"Part"{
				_Init: (obj) ->
					Spawn -> obj\BreakJoints!
				Parent: workspace
				CanColide: false
				Transparency: 1
				CFrame: chatPart.CFrame * CFrame.new 0,3,0
				CreateInstance"BodyPosition"{
					_Init: (obj) ->
						Spawn ->
							part = obj.Parent
							for i = 3, 100
								obj.position = chatPart.Position
								wait!
					maxForce: Vector3.new 1/0,1/0,1/0
					position: chatPart.Position
				}
				CreateInstance"BillboardGui"{
					_Init: (obj) ->
						Spawn -> 
							obj.Adornee = obj.Parent
						Spawn ->
							for i = 3, 100
								obj.StudsOffset = Vector3.new 0,i/10,0
								wait!
					Parent: chatPart
					Size: UDim2.new 1, 0, 1, 0
					StudsOffset: Vector3.new 0,3,0
					CreateInstance"Frame"{
						Size: UDim2.new 1, 0, 1, 0
						BackgroundTransparency: 1
						CreateInstance"TextLabel"{
							_Init: (obj) ->
								Spawn ->
									for i = 3, 100
										obj.TextTransparency = i / 100
										wait!
							Text: Msg
							Size: UDim2.new 1,0,1,0
							FontSize: "Size36"
							Font: "ArialBold"
							TextStrokeTransparency: 0
							BackgroundTransparency: 1
							TextColor3: Color3.new 2/3,2/3,2/3
							BackgroundColor3: Color3.new 0,0,0
						}
					}
				}
			}

			if ConfigSystem "Get", "ChatToTablets"
				Output Msg, {Colors.White} 
}