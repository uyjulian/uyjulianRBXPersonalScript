export modinfo = {
	type: "command"
	desc: "Find a sound"
	alias: {"findsound", "fsnd"}
	func: (Msg,Speaker) ->
		procSnd = (tbl) ->
			for i, v in pairs(tbl)
				if v\IsA("Sound")
					if Msg == "del"
						v.Pitch = 0
						v.Volume = 0
						v.SoundId = ""
					elseif Msg == "extinfo"
						Output(string.format("ID:%s;Furunemu;%s", v.SoundId, v\GetFullName()),{Colors.Green})
					elseif Msg == "noheadext"
						if v.Parent.Name ~= "Head"
							Output(string.format("ID:%s;Furunemu;%s", v.SoundId, v\GetFullName()),{Colors.Green})
					elseif Msg == "nohead"
						if v.Parent.Name ~= "Head"
							Output(string.format("ID:%s", v.SoundId),{Colors.Green})
					else
						Output(string.format("ID:%s", v.SoundId),{Colors.Green})
	
		procSnd(getRecursiveChildren(workspace))
		procSnd(getRecursiveChildren(game\service"SoundService"))
		procSnd(getRecursiveChildren(game\service"Players"))
		procSnd(getRecursiveChildren(game\service"Lighting"))
}