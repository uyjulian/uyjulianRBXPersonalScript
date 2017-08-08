export modinfo = {
	type: "command"
	desc: "Recall Chat Log"
	alias: {"cl"}
	func: (Msg,Speaker) ->
		Output("Showing chatlog",{Colors.White})
		for i=#ConfigSystem("Get", "ChatLog"), #ConfigSystem("Get", "ChatLog") - 49, -(1)
			if not ConfigSystem("Get", "ChatLog")[i]
				break
			else
				S,M = ConfigSystem("Get", "ChatLog")[i].Speaker,ConfigSystem("Get", "ChatLog")[i].Message 
				Output(string.format("%s: %s",tostring(S),M),{Colors.Green})
}