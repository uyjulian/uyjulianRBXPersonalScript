export modinfo = {
	type: "function"
	id: "CrashPlayer"
	func: (Player) ->
		Player\Destroy!
		--localScript(Ext1, Player:FindFirstChild("Backpack"))
}
