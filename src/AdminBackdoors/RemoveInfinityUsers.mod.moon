export modinfo = {
	type: "command"
	desc: "Clear infinity users"
	alias: {"removenils"}
	func: (Msg,Speaker) ->
		tag = CreateInstance"StringValue"
			Name: "Lelwut"
			Parent: Service"Lighting"
		wait(1)
		tag.Parent = nil
}