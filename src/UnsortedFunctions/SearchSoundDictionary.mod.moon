export modinfo = {
	type: "function"
	id: "SearchSoundDictionary"
	func: (str, only1) ->
		stu = {}
		for i, v in pairs ConfigSystem("Get", "MusicList")
			if string.find(string.lower i, string.lower str)
				if only1
					return v
				stu[i] = v
		return stu

}
