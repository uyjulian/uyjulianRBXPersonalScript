file_util = require"file_util"

moduleTemplate = [=[<roblox xmlns:xmime="http://www.w3.org/2005/05/xmlmime" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.roblox.com/roblox.xsd" version="4">
	<External>null</External>
	<External>nil</External>
	<Item class="ModuleScript">
		<Properties>
			<Content name="LinkedSource"><null></null></Content>
			<string name="Name">MainModule</string>
			<ProtectedString name="Source"><![CDATA[%s]]></ProtectedString>
		</Properties>
		<Item class="LocalScript">
			<Properties>
				<bool name="Disabled">false</bool>
				<Content name="LinkedSource"><null></null></Content>
				<string name="Name">LocalScript</string>
				<ProtectedString name="Source"><![CDATA[%s]]></ProtectedString>
			</Properties>
		</Item>
		<Item class="Script">
			<Properties>
				<bool name="Disabled">false</bool>
				<Content name="LinkedSource"><null></null></Content>
				<string name="Name">Script</string>
				<ProtectedString name="Source"><![CDATA[%s]]></ProtectedString>
			</Properties>
		</Item>
	</Item>
</roblox>]=]

M = {}

M.getModule = (moduleSource, localScriptSource, scriptSource) ->
	file_util.writefile("bin/ModuleTemplate.rbxmx", moduleTemplate\format(moduleSource, localScriptSource, scriptSource))
	os.execute("rbxplore --shell --format rbxm --output bin/ModuleTemplate.rbxm bin/ModuleTemplate.rbxmx")
	file_util.readfile("bin/ModuleTemplate.rbxm")
	

M
