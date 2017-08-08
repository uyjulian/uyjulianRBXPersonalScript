export modinfo = {
	type: "function"
	id: "GetTime"
	func: ->
		Hour = math.floor (tick()%86400)/60/60
		Minute = math.floor ((tick()%86400)/60/60-Hour)*60
		string.format "%u:%02u", Hour, Minute

}
