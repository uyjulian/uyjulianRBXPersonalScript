export modinfo = {
	type: "function"
	id: "CreateCommandGuiRevision2"
	func: ->
		keysDown = {}
		scrngui = Instance.new"ScreenGui"
		stuffs = scrngui\clone!
		--curGui = nil
		boxActivated = false
		curText = "messeji nyuryoku"
		while not GetPlayerGui LocalPlayer
			wait!
		-- while GetPlayerGui LocalPlayer\FindFirstChild"Lelol"
		-- 	wait!
		stuffs.Parent = GetPlayerGui LocalPlayer 
		
		trySetTextbox = ->
			Spawn ->
				stuffs\ClearAllChildren!
				fmeTmp = GeneratePixelChatFrame curText
				fmeTmp.Parent = stuffs

		onKeyPress = (inputObject, gameProcessedEvent) ->
			if (inputObject.KeyCode == 0) or (inputObject.KeyCode == nil)
				return
			keysDown[inputObject.KeyCode] = true
			if inputObject.KeyCode == Enum.KeyCode.Return
				unless boxActivated
					if keysDown[Enum.KeyCode.RightShift] or keysDown[Enum.KeyCode.LeftShift]
						boxActivated = true
						curText = ""
				else
					boxActivated = false
					PastText = curText
					unless PastText == ""
						Spawn ->
							OnChatted PastText 
					curText = "messeji nyuryoku"
				trySetTextbox!
				return
			--f1, f4, f5, f6 are reserve in studio, can't use these.
			--ingame, f9 is console, f10 is increase graphics, f11 is fullscreen, all can be used while capturing.
			--shift not support on `12345679090-[]\;,./ currently
			if boxActivated
				val = inputObject.KeyCode.Value
				if keysDown[Enum.KeyCode.RightShift] or keysDown[Enum.KeyCode.LeftShift]
					if val >= 97 and val <= 122
						val -= 32
					elseif val >= 91 and val <= 93
						val += 32
					elseif val == 50
						val += 14
					elseif (val == 49) or (val >= 51 and val <= 53)
						val -= 16
					elseif val == 54
						val += 40
					elseif (val == 55) or (val == 57)
						val -= 17
					elseif val == 56
						val -= 14
					elseif val == 48
						val -= 7
					elseif val == 59
						val -= 1
					elseif (val == 44) or (val == 46) or (val == 47)
						val += 16
					elseif val == 61 
						val -= 18
					elseif val == 39
						val -= 5
					elseif val == 45
						val += 50
					elseif val == 96
						val += 30
				if val >= 32 and val <= 126
					curText = string.format "%s%s", curText, string.char(val)
				elseif inputObject.KeyCode == Enum.KeyCode.Backspace
					curText = curText\sub(1, #curText - 1)
					if (#curText == 0) or keysDown[Enum.KeyCode.RightShift] or keysDown[Enum.KeyCode.LeftShift]
						boxActivated = false
						curText = "messeji nyuryoku"
			trySetTextbox!

		onKeyRelease = (inputObject, gameProcessedEvent) ->
			if (inputObject.KeyCode == 0) or (inputObject.KeyCode == nil)
				return
			keysDown[inputObject.KeyCode] = false

		Service"UserInputService".InputBegan\connect(onKeyPress)
		Service"UserInputService".InputEnded\connect(onKeyRelease)
		LocalPlayer.DescendantRemoving\connect (descendant) ->
			if descendant == stuffs
				stuffs = scrngui\clone!
				CommandGUI = stuffs
				stuffs.Parent = GetPlayerGui LocalPlayer 
				trySetTextbox!
		trySetTextbox!
		return stuffs
}
