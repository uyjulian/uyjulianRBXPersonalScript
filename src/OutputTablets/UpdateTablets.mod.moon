export modinfo = {
	type: "function"
	id: "UpdateTablets"
	func: ->
		if ConfigSystem("Get", "TabletRotationEnabled") == true
			ConfigSystem("Set", "TabletRotation", ConfigSystem("Get", "TabletRotation") + ConfigSystem("Get", "TabletRotationIncrement")) 
		Tablets = GetTablets LocalPlayer
		cf = ConfigSystem("Get", "Camera").Focus
		m = #Tablets / 16
		if not ConfigSystem("Get", "EnhancedTablets")
			for k,v in pairs Tablets
				TabPart = v\FindFirstChild("koshin kanona") or v\FindFirstChild("Part")
				if TabPart
					-- TabPart:SetNetworkOwner(LocalPlayer) --serv
					TabPart.Anchored = true
					c = cf * CFrame.Angles(0,math.pi*2/#Tablets*k+ConfigSystem("Get", "TabletRotation"),0) * CFrame.new(5+10*m,0,0)
					TabPart.CFrame = CFrame.new(c.p,cf.p) * CFrame.Angles(-math.pi/4,0,0)
					if TabPart\FindFirstChild("BodyPosition") 
						TabPart.BodyPosition.Parent = nil
					if TabPart\FindFirstChild("BodyGyro")  
						TabPart.BodyGyro.Parent = nil
		else
			for k,v in pairs Tablets
				TabPart = v\FindFirstChild("koshin kanona") or v\FindFirstChild("Part")
				if TabPart
					-- TabPart:SetNetworkOwner(LocalPlayer) --
					TabPart.Anchored = false
					c = cf * CFrame.Angles(0,math.pi*2/#Tablets*k+ConfigSystem("Get", "TabletRotation"),0) * CFrame.new(5+10*m,0,0)
					if not TabPart\FindFirstChild("BodyPosition")
						CreateInstance"BodyPosition"
							Parent: TabPart
							maxForce: Vector3.new math.huge, math.huge, math.huge
					if not TabPart\FindFirstChild("BodyGyro")
						CreateInstance"BodyGyro"
							Parent: TabPart
							maxTorque: Vector3.new math.huge, math.huge, math.huge
					TabPart.BodyPosition.position = c.p
					TabPart.BodyGyro.cframe = CFrame.new(c.p,cf.p) * CFrame.Angles(-math.pi/3,0,0)

}
