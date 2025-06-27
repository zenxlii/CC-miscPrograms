--Imports
local sm = require("slotMaps")
local iq = require("itemQuants")

--Table of all wrapped peripherals.
local wp = {}

--Configurables
local machineTypes = {
"techreborn:compressor"
}
local batteryIn = "expandedstorage:mini_chest_4"
local batteryOut = ""
local outputInv = "minecraft:barrel_27"
local inputInvs = {}
inputInvs["techreborn:compressor"] = {"techreborn:storage_unit_63"}


--Helper Functions
local batchSize = 250
local function batchedParallel(funcs)
	for cnt = 1, #funcs, batchSize do
        local batchEnd = cnt + batchSize - 1
        local highLim = math.min(batchEnd, #funcs)
        parallel.waitForAll(table.unpack(funcs, cnt, highLim))
    end
end

--Converts an item's internal name and
--NBT hash into an encoded name.
--Send
local function nameEncode(iName, iNBT)
	if iNBT == "" or iNBT == nil then
		return iName
	else
		return iName.."#"..iNBT
	end
end

--Converts an item's encoded name into
--the internal name and NBT hash.
local function nameDecode(eName)
	local splitName = {}
    for part in string.gmatch(eName, "[^#]+") do
        splitName[#splitName+1] = part
    end
    local out = {}
    out["name"] = splitName[1]
    if #splitName == 1 then
        out["NBT"] = ""
    else
        out["NBT"] = splitName[2]
    end
    return out
end

--Makes a table for every machine of
--a type specified in machineTypes.
local machineLists = {}
for _, mType in ipairs(machineTypes) do
	machineLists[mType] = peripheral.find(mType)
	machineLists[mType]["input"] = inputInvs[mType]
	machineLists[mType]["type"] = sm.machMaps[mType]
	for cnt, wrap in ipairs(mType) do
		machineLists[mType][cnt] = {"name" = wrap.getName(), "lock" = false}
		wp[machineLists[mType][cnt]["name"]] = machineLists[mType][cnt]["name"].wrap()
	end
end

wp[batteryIn] = peripheral.wrap(batteryIn)
wp[batteryOut] = peripheral.wrap(batteryOut)
wp[outputInv] = peripheral.wrap(outputInv)

local batteryOutSize = wp[batteryOut].size()
local outputSize = wp[outputInv].size()

--Table of inventories to .list() in
--the next main loop iteration.
--This is initialised to every single
--inventory prior to iteration one.
local scanTargets = {
wp.batteryIn,
wp.batteryOut,
wp.outputInv
}

local function resetScanTargets()
	scanTargets = {
	wp.batteryIn,
	wp.batteryOut,
	wp.outputInv
	}
	for _, mList in pairs(machineLists) do
		for _, input in pairs(mList["input"]) do
			table.insert(scanTargets, wp.input)
		end
	end
end

local scanReturns = {}

for _, mList in pairs(machineLists) do
	for _, input in pairs(mList["input"]) do
		wp[input] = peripheral.wrap(input)
		table.insert(scanTargets, wp.input)
	end
	for _, mach in ipairs(mList) do
		table.insert(scanTargets, wp[mach["name"]])
	end
end

--Scanning Functions
local function scan(wrapInv)
	scanReturns[wrapInv.getName()] = wrapInv.list()
end

local function runScans()
	batchedParallel(scanTargets)
	--resetScanTargets()
end

local function updateLockStatus()
	for _, mList in pairs(machineLists) do
		local inSlots = sm.slotMaps[mList.type]
		for _, mach in ipairs(mList) do
			local isClear = true
			local scanData = scanReturns[mach.name]
			for _, slot in pairs(inSlots) do
				if scanData[slot] then
					isClear = false
					break
				end
			end
			if isClear then
				mach.lock = false
			end
		end
	end
end

--Item Movement Functions

--Checks every machine and moves every
--item in an output slot it can into
--the output inventory.
local function extractOutputs(fTable)
	local extractsLeft = outputSize
	for _, itemData in pairs(scanReturns[outputInv]) do
		extractsLeft = extractsLeft - 1
	end
	if extractsLeft == 0 then
		return
	end
	for _, mList in pairs(machineLists) do
		local outSlots = sm.slotMaps[mList.type]
		for _, mach in ipairs(mList) do
			local mName = mach.name
			local scanData = scanReturns[mach.name]
			for _, slotNum in pairs(outSlots) do
				if not scanData[slotNum] then
					table.insert(fTable, function() 
						wp[mName].pushItems(outputInv, slotNum)
					end)
					extractItems = extractsLeft - 1
					if extractsLeft == 0 then
						break
					end
				end
			end
			if extractsLeft == 0 then
				break
			end
		end
		if extractsLeft == 0 then
			break
		end
	end
end

local function subtractItems(mName, amount)
	
end

--Handles item insertion for machines
--with only one standard input slot.
local function insertBasic(mList, fTable, mClass)
	local inputData = scanReturns[mList["input"]]
	if inputData = {} then
		return
	end
	local inSlot = sm.slotMaps[mList.type][1]
	--Make a manifest of everything in
	--the input inventory.
	local inManifest = {}
	for _, iData in pairs(inputData) do
		local eName = nameEncode(iData.name, iData.nbt)
		if inManifest[eName] then
			inManifest[eName] = inManifest[eName] + iData.count
		else
			inManifest[eName] = iData.count
		end
	end
	local itemQ = iq.itemQuants.mClass
	for _, mach in ipairs(mList) do
		if mach.lock then
			--TODO:
			--Finish this section.
			local eName = nameEncode(scanReturns[mach.name][inSlot].name, scanReturns[mach.name][inSlot].nbt)
		else
			for 
		end
	end
end






--
local function masterInsertHandler(fTable)
	for mClass, mList in pairs(machineLists) do
		local mType = mList.type
		if mType == "basic" or mType == "cell4Out" then
			insertBasic(mList, fTable, mClass)
		elseif mType == "basic2In" then
			
		elseif mType == "rolling" then
			
		else
			error(mType.."/n is not a valid slot layout type!")
		end
	end
end



--Main Loop
local function main()
	while true do
		runScans()
		updateLockStatus()
		local itemMoveTable = {}
		extractOutputs(itemMoveTable)
		masterInsertHandler(itemMoveTable)
		batMan(itemMoveTable)
		batchedParallel(itemMoveTable)
		os.sleep(5)
	end
end