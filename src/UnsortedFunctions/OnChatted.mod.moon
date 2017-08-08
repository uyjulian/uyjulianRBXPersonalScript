export modinfo = {
	type: "function"
	id: "OnChatted"
	func: (Msg) ->
		Spawn ->
			for Name, Command in pairs ConfigSystem("Get", "Commands")
				if Msg\sub(1,#Command.Command+1)\lower! == string.format("%s%s",Command.Command\lower!, ConfigSystem("Get", "Blet"))
					Ran,Error = ypcall(Command.Func,Msg\sub(#Command.Command+2),LocalPlayer)
					Output Error, {Colors.Red} unless Ran
					return

			-- if ConfigSystem "Get", "EnableGuiChat" == true
			-- 	Chat Msg
			-- else
			-- 	tar = LocalPlayer.Character or Probe
			-- 	pcall -> 
			--		Service"Chat"\Chat tar,Msg,"Green"
			ChatPixelRevision2 Msg

}
