curl = require"cURL"
ffi = require"ffi"

M = {}

M.curl_exec = (options) ->
	handle = curl.easy()
	for i, v in pairs(options)
		handle["setopt_" .. i\lower()](handle, v)
	result = handle\perform!
	handle\close!
	return result

M.curl_read_url = (url, in_options) ->
	options = {}
	data = ""
	options["WRITEFUNCTION"] = (str) ->
		data ..= str
		return #str
	options["URL"] = url

	if in_options
		for i, v in pairs(in_options)
			options[i] = v
	M.curl_exec(options)
	return data

M.curl_multi_read = (in_options) ->
	options = {}
	addme = {}
	ret = {}
	for i, v in pairs(in_options)
		if type(i) == "number"
			ret[i] = ""
			v["WRITEFUNCTION"] = (str) ->
				ret[i] ..= str
				return #str
			addme[i] = curl.easy()
			
			for i1, v1 in pairs(v)
				addme[i]["setopt_" .. i1\lower()](addme[i], v1)
		else
			options[i\lower()] = v
	handle = curl.multi(options)
	for i, v in pairs(addme)
		handle\add_handle(v)
	while handle\perform() ~= 0
		os.execute("sleep .1")

	return ret

M.curl_post_url = (url, post_data, in_options) ->

	options = {}


	options["POST"] = 1
	options["POSTFIELDS"] = post_data
	--options["POSTFIELDSIZE"] = #post_data

	if in_options
		for i, v in pairs(in_options)
			options[i] = v

	M.curl_read_url(url, options)

M.curl_new_slist = (options) ->
	return options


M.url_decode = (str) ->
	str = string.gsub(str, "+", " ")
	str = string.gsub(str, "%%(%x%x)", (h) -> string.char(tonumber(h,16)) )
	str = string.gsub(str, "\r\n", "\n")
	return str

M.url_encode = (str) ->
	if (str)
		str = string.gsub(str, "\n", "\r\n")
		str = string.gsub(str, "([^%w %-%_%.%~])", (c) -> string.format("%%%02X", string.byte(c)))
		str = string.gsub(str, " ", "+")
	return str	

M.gen_get_args = (tbl) ->
	conv = {}
	for i, v in pairs(tbl)
		table.insert(conv, M.url_encode(tostring(i)) .. "=" .. M.url_encode(tostring(v)))
	return table.concat(conv, "&")

M.gen_uri_args = (tbl) ->
	conv = {}
	for i, v in pairs(tbl)
		table.insert(conv, M.url_encode(tostring(i)) .. ":" .. M.url_encode(tostring(v)))
	return table.concat(conv, "+")

return M