export modinfo = {
	type: "command"
	desc: "Loadstring into cba"
	alias: {"ltcba"}
	func: (Msg, Speaker) ->
		CreateInstance"StringValue"
			Parent: workspace
			Name: "CBA Attachment"
			Value: Msg

}