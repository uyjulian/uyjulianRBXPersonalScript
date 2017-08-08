export modinfo = {
	type: "command"
	desc: "Chat through chat beacon"
	alias: {"b"}
	func: (Msg,Speaker) ->
		for i,v in pairs(workspace\GetChildren())
			if v.Name == "ChatBeacon"
				Service"Chat"\Chat(v.Head,string.format("%s: %s",CharacterName, Msg),"Red")
}