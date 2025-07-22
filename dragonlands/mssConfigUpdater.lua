--This script is meant to be a base
--which replaces the configuration
--files for a massStorageSystem install
--with those in a given alternative
--repository.

local config = require("configFiles.config")

local commonCodeDisk = config.commonCodeDisk

--As we will be overwriting config.lua,
--we need to remove the reference to
--it early.
config = nil

local gitDir = "dragonlands"

local repo = "https://raw.githubusercontent.com/zenxlii/CC-miscPrograms/refs/heads/main/"..gitDir.."/configuration/"

local function downloadFile(path, url)
	--print(string.format("Installing %s to %s", repo..url, path))
	local response = assert(http.get(repo..url, nil, true), "Failed to get " .. repo..url)
	local f = assert(fs.open(path, "wb"), "Cannot open file " .. path)
	f.write(response.readAll())
	f.close()
	response.close()
end

--Delete the old files.
fs.delete(commonCodeDisk.."/configFiles/allowedShorthands.lua")
fs.delete("configFiles/bussin.lua")
fs.delete(commonCodeDisk.."/configFiles/condenseList.lua")
fs.delete(commonCodeDisk.."/configFiles/config.lua")
fs.delete("configFiles/config.lua")
fs.delete("recipes/craftingTable.lua")
fs.delete("recipes/furnace.lua")
fs.delete("recipes/compressor.lua")
fs.delete("recipes/wireMill.lua")
fs.delete("recipes/extractor.lua")
fs.delete("recipes/grinder.lua")
fs.delete("recipes/alloySmelter.lua")
fs.delete("recipes/rollingMachine.lua")
fs.delete("recipes/mixerNoHeat.lua")
fs.delete("recipes/mechanicalSaw.lua")
fs.delete("recipes/deployer.lua")
fs.delete("recipes/assemblyLines.lua")
fs.delete("recipes/stonecutting.lua")
fs.delete("recipes/chemicalReactor.lua")
fs.delete("configFiles/storageList.lua")

--And download the new ones.
downloadFile(commonCodeDisk.."/configFiles/allowedShorthands.lua", "allowedShorthands.lua")
downloadFile("configFiles/bussin.lua", "bussin.lua")
downloadFile(commonCodeDisk.."/configFiles/condenseList.lua", "condenseList.lua")
downloadFile(commonCodeDisk.."/configFiles/config.lua", "config.lua")
downloadFile("configFiles/config.lua", "config.lua")
downloadFile("recipes/craftingTable.lua", "craftingTable.lua")
downloadFile("recipes/furnace.lua", "furnace.lua")
downloadFile("recipes/compressor.lua", "compressor.lua")
downloadFile("recipes/wireMill.lua", "wireMill.lua")
downloadFile("recipes/extractor.lua", "extractor.lua")
downloadFile("recipes/grinder.lua", "grinder.lua")
downloadFile("recipes/alloySmelter.lua", "alloySmelter.lua")
downloadFile("recipes/rollingMachine.lua", "rollingMachine.lua")
downloadFile("recipes/mixerNoHeat.lua", "mixerNoHeat.lua")
downloadFile("recipes/mechanicalSaw.lua", "mechanicalSaw.lua")
downloadFile("recipes/deployer.lua", "deployer.lua")
downloadFile("recipes/assemblyLines.lua", "assemblyLines.lua")
downloadFile("recipes/stonecutting.lua", "stonecutting.lua")
downloadFile("recipes/chemicalReactor.lua", "chemicalReactor.lua")
downloadFile("configFiles/storageList.lua", "storageList.lua")

print("Config replacement is done!")
os.sleep(5)
os.reboot()