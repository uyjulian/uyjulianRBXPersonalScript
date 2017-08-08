export modinfo = {
	type: "function"
	id: "GetOutput"
	func: (recipient) ->
		if recipient == LocalPlayer
			FindOutModel = ConfigSystem("Get", "Camera")\FindFirstChild"Shutsuryoku::PersonScript"
			if not FindOutModel
				NewModel = CreateInstance"Model"
					Parent: ConfigSystem "Get", "Camera"
					Name: "Shutsuryoku::PersonScript"
				return NewModel
			else
				return FindOutModel
		FindOutModel = ConfigSystem("Get", "Camera")\FindFirstChild(string.format("Shutsuryoku::%s",recipient.Name))
		if not FindOutModel
			NewModel = CreateInstance"Model"
				Parent: ConfigSystem("Get", "Camera")
				Name: string.format("Shutsuryoku::%s", recipient.Name)
			return NewModel
		else
			return FindOutModel

}
