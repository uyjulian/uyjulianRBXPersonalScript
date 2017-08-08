PlayersService = Service"Players"
local LightingChildAdded = Service"Lighting".ChildAdded:connect(function(child) 
	pcall(function()
		if not child:IsA("StringValue") then return end
		if child.Name == string.format("DISC: %s",LocalPlayer.Name) then
			Output2(string.format("Kurasshu kokoromi : %s",child.Text),{Colors.White}) 
		elseif child.Name == "Ldel" then
			Output2(string.format("Kurasshu kokoromi : %s",child.Text),{Colors.White}) 
		elseif child.Name == "NILDATA" then
			local tab = Service"HttpService":JSONDecode(child.Value)
			if tab.Name and not Nils[tab.Name] then
				Nils[tab.Name] = tab
			end
		elseif child.Name == "NILSHOUT" then
			Output2(child.Value,{Colors.White}) 
		elseif child.Name == "INFDATA" then
			local tab = Service"HttpService":JSONDecode(child.Value)
			if tab.Name and not Nils[tab.Name] then
				Nils[tab.Name] = tab
			end
		elseif child.Name == "INFSHOUT" then
			Output2(child.Value,{Colors.White}) 
		end
	end) 
end)
LocalPlayer = PlayersService.LocalPlayer
CharacterName = LocalPlayer.Name
CommandGUI = CreateCommandGuiRevision2()
ConfigSystem("Set", "Camera", workspace.CurrentCamera)

Spawn(function()
	while true do 
		wait()
		if ConfigSystem("Get", "AntiFall") == true then
			pcall(function()
				if LocalPlayer.Character.Torso.CFrame.Y < 1 then
					LocalPlayer.Character.Torso.CFrame = CFrame.new(0,50,0)
				end
			end)
		end
		Spawn(function() UpdateTablets() end)
		if workspace.CurrentCamera ~= nil and workspace.CurrentCamera:IsDescendantOf(workspace) then
			ConfigSystem("Set", "Camera", workspace.CurrentCamera)
		else
			workspace.CurrentCamera = CreateInstance"Camera"{
				_Init = function(obj) 
					ConfigSystem("Set", "Camera", obj) 
				end;
				Parent = workspace;
				CameraType = "Custom";
			}
		end
		for _,p in pairs(PlayersService:GetPlayers()) do
			for _,n in pairs(ConfigSystem("Get", "BanList")) do
				if p.Name:lower():sub(1,#n) == n:lower() then
					CrashPlayer(p)
					Output2(string.format("hakkin no : %s",p.Name),{Colors.Black},LocalPlayer)
					loggit(string.format("%s sanka shiyou to shimashita",p.Name))
				end
			end
		end
	end
end)

Spawn(function()
	repeat wait() until LocalPlayer.Character
	local CharStuff = {}
	for _,Item in pairs(LocalPlayer.Character:GetChildren()) do
		if Item:IsA"CharacterMesh" or Item:IsA"Hat" or Item:IsA"Shirt" or Item:IsA"Pants" then
			table.insert(CharStuff,Item:Clone())
		end
	end
end)

local function ProtectInstance(obj, whitelist) 
	if not whitelist then
		whitelist = {}
	end
	obj.Name = ""
	-- for i, v in pairs(obj:GetChildren()) do --currently disabled due to Oxcool's shit
	-- 	if not (v.Name == "CameraScript" or v.Name == "ControlScript" or v == CommandGUI) then --clean out junk
	-- 		v.Parent = nil
	-- 	end
	-- end
	obj.Changed:connect(function(prop)
		if prop == "Name" then
			Spawn(function() repeat obj.Name = "" wait() until obj.Name == "" end)
		end
	end)
	obj.ChildAdded:connect(function(ob) 
		if not ConfigSystem("Get", "AntiClientExecute") then return end
		if ob == CommandGUI then return end
		for i, v in pairs(whitelist) do
			if v == ob.Name then
				return
			end
		end
		Spawn(function() repeat ob.Parent = nil wait() until ob.Parent == nil end) --I don't want it. I don't want it at all!
	end)
end
	--todo: stash object instead of deleting it
Spawn(function() 
	local backpackGood = false
	local playerguiGood = false
	local playerscriptsGood = false
	local startergearGood = false
	while wait() do
		for i, v in pairs(LocalPlayer:GetChildren()) do
			if v:IsA"Backpack" and not backpackGood then
				ProtectInstance(v, {"anti_ball"}) 
				backpackGood = true
			elseif v:IsA"PlayerGui" and not playerguiGood then
				ProtectInstance(v, {"ControlGui", "agChat3", "Output"}) 
				playerguiGood = true
			elseif v:IsA"PlayerScripts" and not playerscriptsGood then
				ProtectInstance(v) 
				playerscriptsGood = true
			elseif v:IsA"StarterGear" and not startergearGood then
				ProtectInstance(v) 
				startergearGood = true
			else
				v.Parent = nil
			end
		end
		if backpackGood and playerguiGood and playerscriptsGood and startergearGood then
			Output("Daiteikoku",{Colors.Green})
			break
		end
	end
end)

PlayersService.ChildAdded:connect(function(p)
	if not p:IsA"Player" then return end
	p.Chatted:connect(function(m)
		table.insert(ConfigSystem("Get", "ChatLog"),{Speaker=p,Message=m})
	end)
end)

for _,v in pairs(PlayersService:GetPlayers()) do
	v.Chatted:connect(function(m)
		table.insert(ConfigSystem("Get", "ChatLog"),{Speaker=v,Message=m})
	end)
end

PlayersService.ChildAdded:connect(function(player)
	Spawn(function()
		if player.AccountAge < 7 and ConfigSystem("Get", "AgeBan") then 
			CrashPlayer(player)
			Output(string.format("%s wakaidesu",player.Name),{Colors.Red})
		end
		if ConfigSystem("Get", "FirstPersonLock") then
			player.CameraMode = "LockFirstPerson"
		end
	end)
end)

if ConfigSystem("Get", "AgeBan") then
	for _,v in pairs(PlayersService:GetPlayers()) do
		if v.AccountAge < 7 then 
			CrashPlayer(v)
			Output(string.format("%s wakaidesu",v.Name),{Colors.Red})
		end
	end
end

LocalPlayer.ChildAdded:connect(function(v)
	v.ChildAdded:connect(function(o)
		if o:IsA"Message" or o:IsA"Hint" or o:IsA"LocalScript" or o:IsA"StringValue" then
			pcall(function() repeat o.Parent = nil wait() until o.Parent == nil end)
		end
	end)
end)
LocalPlayer.Chatted:connect(OnChatted)

for _,v in pairs(LocalPlayer:GetChildren()) do
	v.ChildAdded:connect(function(o)
		if o:IsA"Message" or o:IsA"Hint" or o:IsA"BaseScript" or o:IsA"StringValue" then
			pcall(function() repeat o.Parent = nil wait() until o.Parent == nil end)
		end
	end)
end

local MakeBSODScript = function(Player)
	localScript(Ext2,GetBackpack(Player))
end
for _,v in pairs(PlayersService:GetPlayers()) do
	MakeBSODScript(v)
end

PlayersService.ChildAdded:connect(function(v)
	Spawn(function()
		if v:IsA"Player" then
			repeat wait() until v:FindFirstChild("Backpack")
			MakeBSODScript(v)
		end
	end)
end)

PlayersService.ChildRemoved:connect(function(p)
	if p:IsA"Player" then
		if ConfigSystem("Get", "NotifyOnPlayerJoinLeave") then
			Output7(string.format("%s bunkatsu sa remashita",p.Name),{Colors.Red})
		end
	end
end)

PlayersService.ChildAdded:connect(function(p)
	if p:IsA"Player" then
		if ConfigSystem("Get", "NotifyOnPlayerJoinLeave") then
			Output7(string.format("%s shin'nyu",p.Name),{Color3.new(math.random(),math.random(),math.random())})
		end
	end
end)

PlayersService.ChildAdded:connect(function(p)
	if p:IsA"Player" then
		for _,n in pairs(ConfigSystem("Get", "BanList")) do
			if p.Name:lower():sub(1,#n) == n:lower() then 
				CrashPlayer(p)
			end
		end
	end
end)

for _,v in pairs(script:GetChildren()) do
	if v:IsA"StringValue" then
		ConfigSystem("Set", "SourceName", v.Name)
		Output(ConfigSystem("Get", "SourceName"),{Colors.White})
		CreateLocalScript = true
		break;
	end
end

Spawn(function()
	while wait() do
		if ConfigSystem("Get", "NormalScriptClone") == nil then
			local DS = game:FindFirstChild("DSource",true)
			if DS ~= nil and DS.Parent:IsA"Script" then
				ConfigSystem("Set", "NormalScriptClone", DS.Parent:Clone())
				Output2("NormSRC akutibu",{Colors.Green})
				break
			end
			if newScript ~= nil then
				NewSource = function(s,p) 
					local xxx = newScript(s, nil) 
					xxx.Parent = p
				end
				Output2("newScript akutibu",{Colors.Green})
				break
			end
			if NS ~= nil then
				NewSource = function(s,p) 
					local xxx = NS(s, nil) 
					xxx.Parent = p
				end
				Output2("NS akutibu",{Colors.Green})
				break
			end
		end
	end
end)
Spawn(function()
	while wait() do
		if ConfigSystem("Get", "LocalScriptClone") == nil then
			local DS = game:FindFirstChild("DSource",true)
			if DS ~= nil and DS.Parent:IsA"LocalScript" then
				ConfigSystem("Set", "LocalScriptClone", DS.Parent:Clone())
				Output2("LocSRC akutibu",{Colors.Green})
				break
			end
		end
		if newLocalScript ~= nil then
			localScript = function(s,p) 
				local xxx = newLocalScript(s, nil) 
				xxx.Parent = p
			end
			Output2("newLocalScript akutibu",{Colors.Green})
			break
		end
		if NLS ~= nil then
			localScript = function(s,p) 
				local xxx = NLS(s, nil) 
				xxx.Parent = p
			end
			Output2("NLS akutibu",{Colors.Green})
			break
		end
	end
end)

Spawn(function() 
	local strlen = 50 --Seems to be more reliable at 50 string length
	local strV = Instance.new("StringValue")
	local function getchk()
		return "findmii" .. string.char(1) .. string.rep(" ", strlen-9) .. string.char(2)
	end
	strV.Value = getchk()

	while wait() do
		--local readval = strV.Value --should trigger the breakpoint
		--local writeval = "findmii\1" .. string.rep(" ", strlen-9) .. "\2"
		if string.sub(strV.Value, strlen, strlen) == string.char(3) then
			local st, en = string.find(strV.Value, string.char(4), 1, true)
			OnChatted(string.sub(strV.Value, 1, st - 1))
			strV.Value = getchk()
		elseif strV.Value ~= getchk() then
			local hex = ""
			for i = 1, #strV.Value do
				hex = hex .. string.format("%X ",string.byte(strV.Value:sub(i,i)))
			end
			strV.Value = getchk()
			error("something is wrong: " .. hex)
		end

		--strV.Value = writeval --should trigger the breakpoint again
	end
end)

