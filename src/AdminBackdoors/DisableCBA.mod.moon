export modinfo = {
	type: "command"
	desc: "Disable cba"
	alias: {"removecba"}
	func: ->
		CreateInstance"StringValue"
			Parent: workspace
			Name: "CBA Attachment"
			Value: "CBA={}wait()CBA.connect={}wait()CBA.lvls={}wait()CBA.Parent=workspace;wait()script.Parent=workspace;script.Parent = nil"

}