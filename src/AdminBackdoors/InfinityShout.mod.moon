export modinfo = {
	type: "command"
	desc: "Infinity shout"
	alias: {"ishout"}
	func: (Msg,Speaker) ->
		tag = CreateInstance"StringValue"
			Parent: Service"Lighting"
			Name: "INFSHOUT"
			Value: string.format("%s: %s",CharacterName, Msg)
		wait(1)
		tag.Parent = nil
		loggit(string.format("You shouted %s",Msg))

}