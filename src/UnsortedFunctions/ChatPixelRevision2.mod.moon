export modinfo = {
	type: "function"
	id: "ChatPixelRevision2"
	func: (m) ->
		DeModel = CreateInstance"BillboardGui"
			Parent: (LocalPlayer.Character and LocalPlayer.Character\FindFirstChild("Head")) or (Probe)

		if m\sub(1,2) == '/e' 
			return

		m1 = m\gsub "\n"," "
		m1 = m1\gsub "\t"," "
		m1 = m1\gsub "math.pi",tostring(math.pi)
		DeModel.Size = UDim2.new 0,8*#m1,0,8

		FR = GeneratePixelChatFrame m1
		FR.Parent = DeModel

		Spawn ->
			for i = 3, 100 
				DeModel.StudsOffset = Vector3.new 0,i/10,0
				wait!
			for i = 3, 50
				FR.BackgroundTransparency = i / 50
				wait!
			DeModel.Parent = nil
		Spawn ->
			for i = 1,0,1/#m1
				DeModel.Frame.Transparency = i
				wait 1/60
}
