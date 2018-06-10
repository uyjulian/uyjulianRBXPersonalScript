export modinfo = {
	type: "command"
	desc: "Explode Player"
	alias: {"bam", "explode"}
	func: getDoPlayersFunction (v) ->
		Explosion = CreateInstance"Explosion"{
			_Init: (obj) ->
				obj.Hit\connect (Hit) ->
					if Hit\IsDescendantOf(v.Character) == false
						Hit.Anchored = false
						Hit\BreakJoints()
			Parent: workspace
			BlastRadius: 100
			BlastPressure: 1000000
			Position: (v.Character and v.Character\FindFirstChild("Torso") and v.Character\FindFirstChild("Torso").Position) or Vector3.new(0,0,0)
		}
		Output(string.format("Exploded %s",v.Name),{Colors.Red})
		loggit(string.format("Exploded %s",v.Name))
}