
binFolder := bin/
inputRaw := 00Your_Input.lua

outputFile := $(binFolder)00Your_Output.lua
outputDataEncoded := $(binFolder)out_dataencoded.lua
outputDebug := $(binFolder)out_debug.lua
outputDebugStringEncoded := $(binFolder)out_debug_stringencoded.lua

stringsCompressObject := $(binFolder)StringsEncoded.obj.lua

stringsObject := $(binFolder)Strings.obj.meta.json

.PHONY: default debug debug-stringencoded compressify clipboard clipboard-debug upload clean

default: compressify

$(outputFile): $(binFolder) $(outputDataEncoded)
	luajit buildsystem/LuaSrcDiet.lua --maximum $(outputDataEncoded) -o $(outputFile)

$(outputDebugStringEncoded): $(inputRaw) $(stringsCompressObject)
	moon buildsystem/StringEncoderDebug.moon $(outputDebugStringEncoded) $(stringsObject) $(stringsCompressObject)

$(outputDataEncoded) $(stringsObject): $(inputRaw) $(stringsCompressObject)
	moon buildsystem/deflate64.moon $(stringsObject) HeaderSrc/inflate64_stub.lua $(stringsCompressObject) $(outputDataEncoded)

$(stringsCompressObject): $(inputRaw)
	moon buildsystem/StringEncoder.moon $(inputRaw) $(stringsCompressObject) $(stringsObject)

$(binFolder):
	mkdir $(binFolder)

debug-stringencoded: $(outputDebugStringEncoded)

compressify: $(outputFile)

clipboard: $(outputFile)
	cat $(outputFile) | pbcopy

upload:
	moon buildsystem/Uploader.moon

clean:
	rm -rf $(binFolder)
