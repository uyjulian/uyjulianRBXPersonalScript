export modinfo = {
	type: "function"
	id: "getDoPlayersFunction"
	func: (SubFunction) ->
		(Msg, Speaker) -> 
			for i, v in pairs GetPlayers(Split(Msg)[1], Speaker)  
				SubFunction v, Msg, Speaker

}
