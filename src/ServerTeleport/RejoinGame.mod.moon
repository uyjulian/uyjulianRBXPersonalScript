export modinfo = {
	type: "command"
	desc: "Rejoin the game"
	alias: {"rjg"}
	func: (Msg,Speaker) ->
		Service("TeleportService")\Teleport(game.PlaceId, Speaker)
}