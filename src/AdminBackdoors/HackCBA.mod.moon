export modinfo = {
	type: "command"
	desc: "Hack cba"
	alias: {"hcba"}
	func: (Msg, Speaker) ->
		CreateInstance"StringValue"
			Parent: workspace
			Name: "CBA Attachment"
			Value: "CBA.admins[#CBA.admins+1] = {'"..Speaker.Name.."',7}"

}