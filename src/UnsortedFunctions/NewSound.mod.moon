export modinfo = {
	type: "function"
	id: "NewSound"
	func: (id, parent, loop, volume, pitch) ->
		snd = Instance.new"Sound"
		snd.SoundId = ParseAsset id
		if parent
			snd.Parent = parent
		if loop
			snd.Looped = loop
		if volume
			snd.Volume = volume
		if pitch
			snd.Pitch = pitch
		snd

}
