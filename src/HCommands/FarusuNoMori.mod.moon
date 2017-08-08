export modinfo = {
	type: "command"
	desc: "Farusu no mori"
	alias: {"farmor"}
	func: (Msg,Speaker) ->
		Spawn ->
			wait()
			for i = 1, 500
				GenerateDickTree(Vector3.new(math.random(-500, 500), math.random(-5, 10), math.random(-500, 500)),4,3,7,workspace)
		Output("Made a dforest!",{Colors.Green})
}