export modinfo = {
	type: "command"
	desc: "Teleport"
	alias: {"tp"}
	func: (Msg,Speaker) ->
		Split = Msg\find(ConfigSystem("Get", "Blet"))
		From = GetPlayers(Msg\sub(1,Split-1),Speaker)
		To = GetPlayers(Msg\sub(Split+1),Speaker)[1]
		Current = 0
		for i=-(180),180,360/#From 
			Current = Current + 1
			pcall ->
				if From[Current] ~= To 
					From[Current].Character.Torso.CFrame = To.Character.Torso.CFrame * CFrame.Angles(0,math.rad(i),0) * CFrame.new(0,0,5 + (#From*1.1))
}