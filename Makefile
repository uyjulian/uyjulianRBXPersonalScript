
binFolder := bin/

outputFile := $(binFolder)uyjulianRBXPersonScript.lua
outputRaw := $(binFolder)out_raw.lua
outputDataEncoded := $(binFolder)out_dataencoded.lua
outputDebug := $(binFolder)out_debug.lua
outputDebugStringEncoded := $(binFolder)out_debug_stringencoded.lua

headerObject := $(binFolder)Header.obj.lua
configObject := $(binFolder)Config.obj.lua
footerObject := $(binFolder)Footer.obj.lua
stringsCompressObject := $(binFolder)StringsEncoded.obj.lua

stringsObject := $(binFolder)Strings.obj.meta.json

commandsObjectFolder := $(binFolder)OutCmds/
headerSrcFolder := HeaderSrc/

srcFolder := src/

.PHONY: default debug debug-stringencoded compressify clipboard clipboard-debug upload clean

default: compressify

$(outputFile): $(binFolder) $(outputDataEncoded)
	luajit buildsystem/LuaSrcDiet.lua --maximum $(outputDataEncoded) -o $(outputFile)

$(outputDebug): $(outputRaw)

$(outputDebugStringEncoded): $(outputRaw) $(stringsCompressObject)
	moon buildsystem/StringEncoderDebug.moon $(outputDebugStringEncoded) $(stringsObject) $(stringsCompressObject)

$(outputDataEncoded) $(stringsObject): $(outputRaw) $(stringsCompressObject)
	moon buildsystem/deflate64.moon $(stringsObject) HeaderSrc/inflate64_stub.lua $(stringsCompressObject) $(outputDataEncoded)

$(stringsCompressObject): $(outputRaw)
	moon buildsystem/StringEncoder.moon $(outputRaw) $(stringsCompressObject) $(stringsObject)

$(outputRaw): $(binFolder) $(headerObject) $(commandsObjectFolder) $(footerObject) $(configObject)
	moon buildsystem/GenRaw.moon $(headerObject) $(configObject) $(commandsObjectFolder) $(footerObject) $(outputRaw)

$(headerObject) $(footerObject): $(binFolder) $(headerSrcFolder)
	moon buildsystem/GenHeader.moon $(headerObject) $(footerObject)

$(configObject): $(headerSrcFolder)Configuration.meta.json
	moon buildsystem/GenConfig.moon HeaderSrc/Configuration.meta.json $(configObject)

$(commandsObjectFolder): $(srcFolder)
	mkdir $(commandsObjectFolder)
	moon buildsystem/GenCmd.moon $(commandsObjectFolder)

$(binFolder):
	mkdir $(binFolder)

debug: $(outputRaw)

debug-stringencoded: $(outputDebugStringEncoded)

compressify: $(outputFile)

clipboard: $(outputFile)
	cat $(outputFile) | pbcopy

clipboard-debug: $(outputRaw)
	cat $(outputRaw) | pbcopy

upload:
	moon buildsystem/Uploader.moon

clean:
	rm -rf $(binFolder)


