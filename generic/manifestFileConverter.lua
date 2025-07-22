local config = require("configFiles.config")

local manifestFile = config.manifestFile

local function convertEntry(newKey, oldKey, inputTable, outputTable)
	if inputTable[newKey] then
		outputTable[newKey] = inputTable[newKey]
	elseif inputTable[oldKey] then
		outputTable[newKey] = inputTable[oldKey]
	end
end

if fs.exists(manifestFile) then
	local dmSerial = ""
	local file = fs.open(manifestFile, "r")
	local line = ""
	local count = 1
	while line ~= nil do
		count = count + 1
		dmSerial = dmSerial..line
		line = file.read()
	end
	file.close()
	
	local displayManifestOld = textutils.unserialise(dmSerial)
	local displayManifest = {}
	
	for eName, data in pairs(displayManifestOld) do
		displayManifest[eName] = {}
		convertEntry("a", "amount", data, displayManifest[eName])
		convertEntry("n", "displayName", data, displayManifest[eName])
		convertEntry("s", "maxStack", data, displayManifest[eName])
		convertEntry("r", "hasRecipe", data, displayManifest[eName])
	end
	
	local serialDM = textutils.serialise(displayManifest, {compact = true})
	
	local file = fs.open(manifestFile, "w")
	file.write(serialDM)
	file.close()
end