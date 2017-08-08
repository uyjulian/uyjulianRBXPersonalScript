export modinfo = {
	type: "function"
	id: "TabletMerge"
	func: (message, color, recipient = LocalPlayer, stick = 100, varient) ->
		_pos = switch varient
			when 1, 3, 4
				ConfigSystem("Get", "Camera").Focus * CFrame.new(7, 7, 7)
			when 2, 5, 6, 7
				ConfigSystem("Get", "Camera").Focus * CFrame.new(10, 10, 10)

		partShape = switch varient
			when 2, 5
				"Ball"
			else
				"Block"
		partSize = switch varient
			when 1
				Vector3.new(4, 0.3, 4)
			when 2
				Vector3.new(3/2,3/2,3/2)
			when 3
				Vector3.new(1, 1, 1)
			when 4
				Vector3.new(3.2,3,1)
			when 5, 6
				Vector3.new(3,3,3)
			when 7
				Vector3.new(3,1,3)

		boxTransparency = switch varient
			when 5, 6
				1
			else
				0

		RoundMesh = (varient == 7) and CreateInstance"SpecialMesh"{
			MeshType: "FileMesh"
			MeshId: ParseAsset(9759642)
			Scale: Vector3.new(3,3,3)
			VertexColor: Vector3.new(0,0,1)
		}

		SelectionLasso = ((varient == 1) and ConfigSystem("Get", "UseLassoForTablets")) and CreateInstance"SelectionPartLasso"{
			_Init: (obj) -> Spawn -> obj.Part = obj.Parent
			Humanoid: recipient.Character and recipient.Character\FindFirstChild("Humanoid")
			Color: BrickColor.new(color[1])
			Transparency: 0
		}

		FloorWire = ((varient == 1) and ConfigSystem("Get", "UseFloorWireForTablets")) and CreateInstance"FloorWire"{
			_Init: (obj) -> Spawn -> obj.To = obj.Parent
			From: recipient.Character and recipient.Character\FindFirstChild("Torso")
			Color: BrickColor.new(color[1])
		}

		CreateInstance"Model"{
			Parent: GetOutput(recipient)
			Name: string.format("Shutsuryoku::%s",recipient.Name)
			CreateInstance"Part"{
				_Init: (obj) ->
					if varient == 1 or varient == 4 or varient == 5 or varient == 6
						obj.Name = "koshin kanona"
					if varient == 1
						Spawn ->
							mdl = obj.Parent
							while wait!
								if obj.Parent == nil
									mdl.Parent = nil
									break
								for i = 0,.7,0.1
									if obj.Parent == nil
										break
									oldCFrame = obj.CFrame
									obj.Size = Vector3.new(4,i,4)
									obj.CFrame = oldCFrame
									wait()
								wait()
								for i = .7,0,-0.1
									if obj.Parent == nil 
										break
									oldCFrame = obj.CFrame
									obj.Size = Vector3.new(4,i,4)
									obj.CFrame = oldCFrame
									wait()
					elseif varient == 4
						Spawn ->
							while wait()
								if obj.Parent == nil 
									break 
								for i = 0,4,0.1
									if obj.Parent == nil 
										break 
									oldCFrame = obj.CFrame
									obj.Size = Vector3.new(i,i,i)
									obj.CFrame = oldCFrame
									wait()
								wait()
								for i = 4,0,-0.1 do
									if obj.Parent == nil 
										break 
									oldCFrame = obj.CFrame
									obj.Size = Vector3.new(i,i,i)
									obj.CFrame = oldCFrame
									wait()
				Transparency: 0.5
				CanCollide: false
				Color: color[1]
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				FormFactor: "Plate"
				CFrame: _pos
				Shape: partShape
				CreateInstance"ClickDetector"{
					_Init: (obj) ->
						local mdl
						Spawn -> mdl = obj.Parent.Parent
						obj.MouseClick\connect (player) ->
							if player == recipient
								mdl.Parent = nil
				}
				CreateInstance"Fire"{
					_Init: (obj) ->
						if ConfigSystem("Get", "EnhancedTablets")
							obj.Heat = 0
							obj.Size = 6
							obj.Color = color[1]
							obj.SecondaryColor = color[1]
						else
							obj.Size = 0
				}
				CreateInstance"PointLight"{
					Range: 10
					Brightness: 10
					Color: color[1]
					Enabled: true
				}
				CreateInstance"SelectionBox"{
					_Init: (obj) -> Spawn -> obj.Adornee = obj.Parent
					Color: BrickColor.new(color[1])
					Transparency: boxTransparency
				}
				RoundMesh
				SelectionLasso
				FloorWire
				CreateInstance"BodyPosition"{
					_Init: (obj) ->
						if varient ~= 1 and varient ~= 3 and varient ~= 4 
							Spawn ->
								i = 4
								part = obj.Parent
								while part.Parent ~= nil
									i = i + 3.5
									obj.position = ConfigSystem("Get", "Camera").Focus\toWorldSpace(CFrame.new(Vector3.new(Sin(i)*4, 1.5, Cos(i)*4))).p
									wait!
						elseif varient == 3 
							Spawn ->
								i = 4
								part = obj.Parent
								while part.Parent ~= nil
									i = i + 3.5
									obj.position = ConfigSystem("Get", "Camera").Focus\toWorldSpace(CFrame.new(Vector3.new(Sin(i)*7, 0, Cos(i)*7))).p
									wait!
					maxForce: Vector3.new(math.huge, math.huge, math.huge)
					position: _pos.p
				}
				CreateInstance"BodyGyro"{
					_Init: (obj) ->
						if varient ~= 1 and varient ~= 3 and varient ~= 4
							Spawn ->
								i = 4
								part = obj.Parent
								while part.Parent ~= nil
									i = i + 3.5
									obj.cframe = CFrame.Angles(0,math.rad(i),0)
									wait()
						elseif varient == 3
							Spawn ->
								i = 4
								part = obj.Parent
								while part.Parent ~= nil
									i = i + 3.5
									obj.cframe = CFrame.Angles(0,math.rad(i),0)
									wait()
					maxTorque: Vector3.new(math.huge, math.huge, math.huge)
				}
			}
			CreateInstance"ObjectValue"{
				_Init: (obj) ->
					if recipient ~= LocalPlayer --remove hax
						obj.Value = recipient
				Name: "Recipient"
			}
			CreateInstance"BillboardGui"{
				_Init: (obj) -> Spawn -> obj.Adornee = obj.Parent\WaitForChild("Part")
				Size: UDim2.new(0, 8 * #message, 0, 8)
				StudsOffset: Vector3.new(0, 3, 0)
				GeneratePixelChatFrame(message, color[1])
			}
		}

}