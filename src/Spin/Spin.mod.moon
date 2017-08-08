export modinfo = {
	type: "command"
	desc: "Spin"
	alias: {"spin"}
	func: getDoPlayersFunction (v) ->
		if v.Character and v.Character.Torso
			v.Character.Torso.Anchored = true
			Spawn ->
				for i=1,360
					v.Character.Torso.CFrame = v.Character.Torso.CFrame * CFrame.Angles(math.rad(i),math.rad(i),0)
					wait(.01)
				v.Character.Torso.Anchored = false
}