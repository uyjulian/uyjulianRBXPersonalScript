export modinfo = {
	type: "command"
	desc: "Rirakkusu"
	alias: {"rirak"}
	func: getDoPlayersFunction (v) ->
		t=v.Character.Torso
		ls=t['Left Shoulder']
		rs=t['Right Shoulder']
		lh=t['Left Hip']
		rh=t['Right Hip']
		n=t.Neck
		v.Character.Animate.Disabled=true
		for i=1,180
			ls.C0 = ls.C0 *CFrame.Angles(0,0,math.rad(-(1)))
			rs.C0 = rs.C0 *CFrame.Angles(0,0,math.rad(1))
		for i=1,35
			lh.C0 = lh.C0 *CFrame.new(0,0.01,0) *CFrame.Angles(math.rad(-(1.2)),0,0)
			rh.C0 = rh.C0 *CFrame.new(0,0.01,0) *CFrame.Angles(math.rad(-(1.2)),0,0)
		t.Parent\MoveTo(t.Position+Vector3.new(0,5,0))
		t.Anchored=true
		v.Character.Head.Anchored=true
		s = CreateInstance"Smoke"{
			Parent: t
			Opacity: 0.5
			RiseVelocity: -(25)
			Size: 0.1
		}
}