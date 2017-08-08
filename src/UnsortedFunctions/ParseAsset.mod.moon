export modinfo = {
	type: "function"
	id: "ParseAsset"
	func: (id) ->
		if not id 
			error("id not provided")
		if type(id) ~= "string"
			id = tostring(id)
		if not id 
			error("tostring failed")
		if string.sub(id, 1, 11) == "rbxasset://"
			return id --leave it alone
		elseif string.sub(id, 1, 13) == "rbxassetid://"
			return id --leave it alone
		elseif string.sub(id, 1, 10) == "rbxhttp://"
			return id --leave it alone
		elseif string.sub(id, 1, 7) == "http://"
			return id --leave it alone
		elseif string.sub(id, 1, 8) == "https://"
			return id --leave it alone
		elseif string.sub(id, 1, 18) == "rbxthumb420x420://"
			return ParseAsset(("rbxhttp://Thumbs%sAsset.ashx?assetId=%s&imageFormat=png&width=420&height=420")\format(string.rep("/", 1e4), string.sub(id, 19)))
		elseif string.sub(id, 1, 18) == "rbxvhumb420x420://"
			return ParseAsset(("rbxhttp://Game%sTools/ThumbnailAsset.ashx?assetVersionId=%u&fmt=png&wd=420&ht=420")\format(string.rep("/", 1e4), string.sub(id, 19)))
		elseif string.sub(id, 1, 15) == "rbxassethash://"
			hash = string.sub(id, 16)
			if #hash ~= 32
				error("invalid hash length")
			id = string.format("%s%sAsset?hash=%s", RobloxWebsite, string.rep("/", 1e4), hash) --Add more slashes so it's harder to get the asset
			return id 
		elseif #id == 32 --this is a hash
			id = string.format("%s%sAsset?hash=%s", RobloxWebsite, string.rep("/", 1e4), id)
			return id 
		elseif tonumber(id)
			id = string.format("rbxassetid://%u", id)
			return id 
		else
			error("invalid asset")


}
