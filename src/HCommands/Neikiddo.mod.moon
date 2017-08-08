export modinfo = {
	type: "command"
	desc: "Neikiddo"
	alias: {"neik"}
	func: getDoPlayersFunction (v) ->
		if v.Character.Torso\FindFirstChild"roblox"
			v.Character.Torso.roblox.Parent = nil
		if v.Character\FindFirstChild"Shirt"
			v.Character.Shirt.Parent = nil
		if v.Character\FindFirstChild"Pants"
			v.Character.Pants.Parent = nil
		if v.Character\FindFirstChild"Body Colors"
			bc = v.Character["Body Colors"]
			bc.TorsoColor = ConfigSystem("Get", "Ero-iro")
			bc.LeftArmColor = ConfigSystem("Get", "Ero-iro")
			bc.LeftLegColor = ConfigSystem("Get", "Ero-iro")
			bc.RightArmColor = ConfigSystem("Get", "Ero-iro")
			bc.RightLegColor = ConfigSystem("Get", "Ero-iro")
			bc.HeadColor = ConfigSystem("Get", "Ero-iro")
		if v.Character\FindFirstChild"Shirt Graphic"
			v.Character["Shirt Graphic"].Parent = nil
		v.Character["Left Arm"].BrickColor = ConfigSystem("Get", "Ero-iro")
		v.Character["Right Arm"].BrickColor = ConfigSystem("Get", "Ero-iro")
		v.Character["Left Leg"].BrickColor = ConfigSystem("Get", "Ero-iro")
		v.Character["Right Leg"].BrickColor = ConfigSystem("Get", "Ero-iro")
		v.Character.Head.BrickColor = ConfigSystem("Get", "Ero-iro")
		v.Character.Torso.BrickColor = ConfigSystem("Get", "Ero-iro")
		v.Character.Head.face.Texture = ConfigSystem("Get", "Hadaka no kao")
}