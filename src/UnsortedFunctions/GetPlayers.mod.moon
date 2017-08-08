export modinfo = {
	type: "function"
	id: "GetPlayers"
	func: (str) ->
		Rtn = {} 
		plyr = PlayersService\GetPlayers!
		if str == "all"
			for _,v in pairs plyr 
				table.insert Rtn,v
		elseif str == "others"
			for _,v in pairs plyr
				if v ~= LocalPlayer 
					table.insert Rtn,v
		elseif str == "random"
			table.insert Rtn,plyr[math.random(1,#plyr)]
		elseif str == "me"
			table.insert Rtn,LocalPlayer
		elseif str == "vetrans"
			for _,v in pairs plyr
				if v.AccountAge > 365 
					table.insert Rtn,v
		elseif str == "nonvetrans" or str == "notvetrans"
			for _,v in pairs plyr
				if v.AccountAge < 365 
					table.insert Rtn,v
		else
			for _,v in pairs plyr
				if string.sub(string.lower(v.Name),1,#str) == string.lower(str)
					table.insert Rtn,v
		return Rtn
}
