export modinfo = {
	type: "command"
	desc: "Seieki"
	alias: {"seieki"}
	func: getDoPlayersFunction (v) ->
		while true
			s = CreateInstance"Part"{
				Parent: v.Character[ConfigSystem("Get", "Ero-mei")]
				BrickColor: BrickColor.new("White")
				Size: Vector3.new(0.5,0.5,0.5)
				TopSurface: 0
				BottomSurface: 0
				Shape: 0
				CFrame: CFrame.new(v.Character[ConfigSystem("Get", "Ero-mei")].Main.Position+Vector3.new(0,1,0))
			}
			dm = CreateInstance"SpecialMesh"{
				MeshType: "Sphere"
				Parent: s
				Scale: Vector3.new(0.1,0.1,0.1)
			}
			wait(0.5)
}