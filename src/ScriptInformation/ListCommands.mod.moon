export modinfo = {
	type: "command"
	desc: "List commands"
	alias: {"cmds"}
	func: (Msg,Speaker) ->
		for name, v in pairs(ConfigSystem("Get", "Commands"))
			Output(string.format("%s : %s",name, v.Command), {Colors.Orange})
}