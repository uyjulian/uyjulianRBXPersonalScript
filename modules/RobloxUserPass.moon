M = {}

JSON = require"JSON"
glue = require"glue"
file_util = require"file_util"

usrpassdat = "~/.robloxuserpassdat/userinfo"
usrpassdat = file_util.realpath(usrpassdat)

userinfo = {
--Fill in the blanks
}

CacheRobloSecurity = (wat, roblosecurity) ->
	temp = {}
	toRemove = {}
	cachefile = glue.readfile(usrpassdat)
	if cachefile 
		temp = JSON\decode(cachefile)
	currentTime = os.time()
	for i, v in pairs(temp)
		if v.expires <= currentTime
			table.insert(toRemove, i)
	for i, v in pairs(toRemove)
		temp[v] = nil
	if roblosecurity
		temp[wat] = {
			roblosecurity: roblosecurity
			expires: os.time() + 24*60*60
		}
	glue.writefile(usrpassdat, JSON\encode(temp))
	if temp[wat]
		return temp[wat].roblosecurity


RobloxLogin = (username, password) ->
	jsonencoded = JSON\encode{
		username: username
		password: password
	}
	file = io.popen(file_util.shellargs("curl", "-X", "POST", "-H", "Content-Type:application/json", "--cookie-jar", "-", "https://www.roblox.com/NewLogin", "--data", jsonencoded), "r")

	roblosecurity = nil
	for line in file\lines!
		if line\sub(1, 21) == "#HttpOnly_.roblox.com"
			strt, ennd = line\find(".ROBLOSECURITY\t", 1, true)
			if strt
				roblosecurity = line\sub(ennd + 1)
	if roblosecurity
		return roblosecurity 
	error("failure to grab roblosecurity")

M.GetUsernamePassword = (wat) ->
	for i, v in pairs(userinfo)
		if i == wat
			return v

M.GetRobloSecurity = (wat) ->
	for i, v in pairs(userinfo)
		if i == wat
			cache = CacheRobloSecurity(wat)
			if not cache
				login = RobloxLogin(v.username, v.password)
				cache = CacheRobloSecurity(wat, login)
			return cache

return M
