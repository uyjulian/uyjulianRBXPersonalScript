export modinfo = {
	type: "function"
	id: "getDoMultiPlayersFunction"
	func: (Number, SubFunction) ->
		(Msg, Speaker) ->
			currentTable = {}
			for i = 1, Number do
				currentTable[i] = GetPlayers(Split(Msg)[i], Speaker)[1]
				if currentTable[i] == nil then
					error string.format("%s gave no results", tostring(Split(Msg)[i]))
			SubFunction currentTable, Msg, Speaker

}
