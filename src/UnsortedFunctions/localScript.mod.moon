export modinfo = {
	type: "function"
	id: "localScript"
	func: (Source, Parent) ->
		return unless CreateLocalScript
		NewScript = ConfigSystem("Get", "LocalScriptClone")\Clone!
		NewScript\ClearAllChildren!
		Souc = CreateInstance"StringValue"
			Parent: NewScript
			Name: ConfigSystem "Get", "SourceName"
			Value: Source
		NewScript.Disabled = true
		NewScript.Parent = Parent
		NewScript.Disabled = false
		NewScript

}
