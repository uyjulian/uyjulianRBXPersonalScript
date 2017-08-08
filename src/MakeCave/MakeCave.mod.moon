export modinfo = {
	type: "command"
	desc: "Make Cave"
	alias: {"cave"}
	func: (Msg,Speaker) -> 
		for i = 1, 9
			rock = CreateInstance"Part"{
				Parent: workspace
				Anchored: true
				Shape: "Ball"
				Material: "Slate"
				TopSurface: "Smooth"
				BottomSurface: "Smooth"
				Size: Vector3.new(40, 40, 40)
				BrickColor: BrickColor.new("Stone gray")
				CFrame: CFrame.new(0,1,0)*CFrame.Angles(0,math.rad(i*40),0)*CFrame.new(80/2,0,0)
			}
			Output("Created cave",{Colors.Green})
}