export modinfo = {
	type: "command"
	desc: "Mini-Explorer"
	alias: {"expl"}
	func: (Msg,Speaker) ->
		rtn = {}
		fty = {}
		fmt1 = "%s (%s)"
		fmt2 = "%s (%s), {%s}, [%s], (%s)"
		if #Msg == 0
			table.insert(rtn,"Valid options: workspace, lighting, gui, players")
		elseif Msg == "workspace"
			Output("Exploring Workspace",{Colors.Green})
			for _,w in pairs(Service"Workspace"\GetChildren())
				Output(string.format(fmt1,w.Name, w.ClassName),{Colors.Yellow})
		elseif Msg == "lightning" 
			Output("Exploring Lighting",{Colors.Green})
			for _,g in pairs(Service"Lighting"\GetChildren()) do
				Output(string.format(fmt1,g.Name, g.ClassName),{Colors.Yellow})
		elseif Msg == "gui" 
			Output("Exploring StarterGui",{Colors.Green})
			for _,g in pairs(Service"StarterGui"\GetChildren()) do
				Output(string.format(fmt1,g.Name, g.ClassName),{Colors.Yellow})
		elseif Msg == "players"
			Output("Exploring Players",{Colors.Green})
			for _,p in pairs(PlayersService\GetPlayers())
				stat = (p.Character and p.Character\FindFirstChild("Humanoid") and p.Character\FindFirstChild("Humanoid").Health) or ("No char")
				Output(string.format(fmt2,p.Name, p.ClassName, p.AccountAge, stat, p.userId),{Colors.Yellow})
		else
			Output("Invalid operation",{Colors.Yellow})
		for _,m in pairs(rtn)
			Output(m,{Color3.new(1,1,1)})
}