export modinfo = {
	type: "command"
	desc: "Parent cba"
	alias: {"pcba"}
	func: ->
		CreateInstance"StringValue"
			Parent: workspace
			Name: "CBA Attachment"
			Value: "script.Parent=Workspace"

}