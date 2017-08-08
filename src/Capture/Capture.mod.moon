export modinfo = {
	type: "command"
	desc: "Capture"
	alias: {"cap"}
	func: getDoPlayersFunction (v) ->
		_pos = LocalPlayer.Character.Head.CFrame * CFrame.new(10, 10, 10)
		Stop = false
		Part = v.Character.Torso
		if Part.Anchored == true 
			Part.Anchored = false
		pos = CreateInstance"BodyPosition"{
			Parent: Part
			maxForce: Vector3.new(math.huge, math.huge, math.huge)
			position: _pos.p
		}
		Sin = (i) -> return math.sin(math.rad(i))
		Cos = (i) -> return math.cos(math.rad(i))
		gyro = CreateInstance"BodyGyro"
			Parent: Part
			maxTorque: Vector3.new(math.huge, math.huge, math.huge)
		for i = 0,math.huge,2.5
			if Stop == false
				pos.position = LocalPlayer.Character.Torso.CFrame\toWorldSpace(CFrame.new(Vector3.new(Sin(i)*4, 1.5, Cos(i)*4))).p 
				gyro.cframe = CFrame.Angles(0,math.rad(i),0)
			wait()
}