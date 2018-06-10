export modinfo = {
	type: "command"
	desc: "Rejoin the current game job"
	alias: {"rj", "rejoin"}
	func: (Msg,Speaker) ->
		Service("TeleportService")\TeleportToPlaceInstance(game.PlaceId, game.JobId, Speaker)
}