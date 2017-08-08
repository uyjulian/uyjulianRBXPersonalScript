export modinfo = {
	type: "command"
	desc: "Load fly script"
	alias: {"fly"}
	func: (Msg,Speaker) ->
		mouse = LocalPlayer\GetMouse() 
		while not mouse ~= nil 
		 	wait()
		plr = LocalPlayer
		torso = LocalPlayer.Character.Torso 
		flying = false 
		deb = true 
		ctrl = {f: 0, b: 0, l: 0, r: 0} 
		lastctrl = {f: 0, b: 0, l: 0, r: 0} 
		maxspeed = 50 
		speed = 0 
		Fly = ->
			bg = CreateInstance"BodyGyro"{
				Parent: torso
				P: 9e4
				maxTorque: Vector3.new(9e9, 9e9, 9e9)
				cframe: torso.CFrame
			}
			bv = CreateInstance"BodyVelocity"{
				Parent: torso
				velocity: Vector3.new(0, 0, 0)
				maxForce: Vector3.new(9e9, 9e9, 9e9)
			}
			while flying 
				CurrentCFrame = ConfigSystem("Get", "Camera").CoordinateFrame
				LocalPlayer.Character.Humanoid.PlatformStand = true 
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 
					speed = speed+.5+(speed/maxspeed) 
					if speed > maxspeed 
						speed = maxspeed 
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 
					speed = speed-1 
					if speed < 0 
						speed = 0 
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 
					bv.velocity = ((CurrentCFrame.lookVector * (ctrl.f + ctrl.b)) + ((CurrentCFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) - CurrentCFrame.p)) * speed 
					lastctrl = {f: ctrl.f, b: ctrl.b, l: ctrl.l, r: ctrl.r} 
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 
					bv.velocity = ((CurrentCFrame.lookVector * (lastctrl.f + lastctrl.b)) + ((CurrentCFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) - CurrentCFrame.p)) * speed 
				else 
					bv.velocity = Vector3.new(0,0,0) 
				bg.cframe = CurrentCFrame * CFrame.Angles(-(math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed)),0,0) 
				wait() 
				flying = false if bg.Parent == nil
			ctrl = {f: 0, b: 0, l: 0, r: 0} 
			lastctrl = {f: 0, b: 0, l: 0, r: 0} 
			speed = 0 
			bg.Parent = nil
			bv.Parent = nil
			plr.Character.Humanoid.PlatformStand = false 
		KeyDownEvent = mouse.KeyDown\connect (key) ->
			if key\lower() == "e" 
				if flying
					flying = false 
				else 
					flying = true 
					Fly() 
			elseif key\lower() == "w" 
				ctrl.f = 1 
			elseif key\lower() == "s" 
				ctrl.b = -(1) 
			elseif key\lower() == "a" 
				ctrl.l = -(1) 
			elseif key\lower() == "d" 
				ctrl.r = 1 
		KeyUpEvent = mouse.KeyUp\connect (key) ->
			if key\lower() == "w" 
				ctrl.f = 0 
			elseif key\lower() == "s" 
				ctrl.b = 0 
			elseif key\lower() == "a" 
				ctrl.l = 0 
			elseif key\lower() == "d" 
				ctrl.r = 0 
		Spawn ->
			while torso.Parent ~= nil
				wait() 
			flying = false 
			KeyDownEvent\disconnect()
			KeyUpEvent\disconnect()
		loggit("You Started Flying")
}