export modinfo = {
	type: "function"
	id: "NewSource"
	func: (Source, Parent) ->
		if ConfigSystem("Get", "NormalScriptClone") == nil 
			return nil
		DS = ConfigSystem("Get", "NormalScriptClone")\Clone!
		DS\ClearAllChildren!

		EN = CreateInstance"StringValue"
			Parent: DS
			Name: ConfigSystem("Get", "SourceName")
			Value: Source
		DS.Disabled = true
		DS.Parent = Parent
		DS.Disabled = false
		return DS

}
