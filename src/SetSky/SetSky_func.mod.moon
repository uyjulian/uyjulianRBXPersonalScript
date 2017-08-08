export modinfo = {
	type: "function"
	id: "SetSky"
	func: (TexAsset) ->
		sky = CreateInstance"Sky"
			Parent: Service"Lighting"
			SkyboxBk: ParseAsset TexAsset
			SkyboxDn: ParseAsset TexAsset
			SkyboxFt: ParseAsset TexAsset
			SkyboxLf: ParseAsset TexAsset
			SkyboxRt: ParseAsset TexAsset
			SkyboxUp: ParseAsset TexAsset
		loggit "Henko sa reta sukai"

}
