--Imports
local sm = require("slotMaps")
local iq = require("itemQuants")

--Table of all wrapped peripherals.
local wp = {}

--Configurables
local machineTypes = {
"techreborn:compressor",
"techreborn:wire_mill",
"techreborn:extractor",
"techreborn:grinder"
}
local emptyBatteryENames = {}
emptyBatteryENames["techreborn:red_cell_battery"] = true
emptyBatteryENames["techreborn:lithium_ion_battery"] = true
emptyBatteryENames["techreborn:energy_crystal"] = true
emptyBatteryENames["techreborn:lapotron_crystal"] = true
emptyBatteryENames["techreborn:lapotronic_orb"] = true
local batteryIn = "expandedstorage:mini_chest_4"
local maxBattIn = 1
local batteryOut = "techreborn:storage_unit_62"
local maxBattOut = 1
local outputInv = "minecraft:barrel_28"
local inputInvs = {}
inputInvs["techreborn:compressor"] = {"minecraft:barrel_29"}
inputInvs["techreborn:wire_mill"] = {"minecraft:barrel_31"}
inputInvs["techreborn:extractor"] = {"minecraft:barrel_33"}
inputInvs["techreborn:grinder"] = {"minecraft:barrel_35"}


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
local preMachineLists = {}
local machineLists = {}
for _, mType in ipairs(machineTypes) do
	print("Machine type "..mType.." found!")
	preMachineLists[mType] = {peripheral.find(mType)}
	machineLists[mType] = {}
	machineLists[mType]["input"] = inputInvs[mType]
	machineLists[mType]["type"] = sm.machMaps[mType]
	local cntr = 1
	for _, wrap in pairs(preMachineLists[mType]) do
		machineLists[mType][cntr] = {}
		machineLists[mType][cntr].name = peripheral.getName(wrap)
		machineLists[mType][cntr].lock = false
		wp[machineLists[mType][cntr]["name"]] = peripheral.wrap(machineLists[mType][cntr]["name"])
		cntr = cntr + 1
	end
end

preMachineLists = nil

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
batteryIn,
batteryOut,
outputInv
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
		table.insert(scanTargets, input)
	end
	for _, mach in ipairs(mList) do
		table.insert(scanTargets, mach.name)
	end
end

--Scanning Functions
local function scan(inv)
	scanReturns[inv] = wp[inv].list()
end

local function runScans()
	local scansToMake = {}
	for _, target in pairs(scanTargets) do
		table.insert(scansToMake, function() 
			scan(target)
		end)
	end
	batchedParallel(scansToMake)
	--resetScanTargets()
end

local function updateLockStatus()
	for _, mList in pairs(machineLists) do
		local inSlots = sm.slotMaps[mList.type].input
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
		local outSlots = sm.slotMaps[mList.type].output
		for _, mach in ipairs(mList) do
			local mName = mach.name
			local scanData = scanReturns[mach.name]
			for _, slotNum in pairs(outSlots) do
				if scanData[slotNum] then
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

--Function which handles the insertion
--of items from an input inventory into
--a machine.
--Assumes that the calling function has
--already checked for if there's enough
--stuff to make this work.
local function insertInput(eName, amount, source, target, targetSlot, inManifest, inputData, fTable)
	
	local amountLeft = amount
	local breaker = false
	for sourceSlot, iData in pairs(inputData) do
		local iName = nameEncode(iData.name, iData.nbt)
		if iName == eName then
			local quant = iData.count
			if quant >= amountLeft then
				table.insert(fTable, function()
					wp[source].pushItems(target, sourceSlot, amountLeft, targetSlot)
				end)
				inputData[sourceSlot].count = inputData[sourceSlot].count - amountLeft
				breaker = true
			elseif quant > 0 then
				table.insert(fTable, function()
					wp[source].pushItems(target, sourceSlot, quant, targetSlot)
				end)
				inputData[sourceSlot].count = 0
				amountLeft = amountLeft - quant
			end
			if inputData[sourceSlot].count == 0 then
				inputData[sourceSlot] = nil
			end
		end
		if breaker then
			break
		end
	end
	inManifest[eName] = inManifest[eName] - amount
	if amountLeft == amount then
		return false
	else
		return true
	end
end

--Handles item insertion for machines
--with only one standard input slot.
local function insertBasic(mList, fTable, mClass)
	local inputData = scanReturns[mList.input[1]]
	if inputData == {} then
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
	local itemQ = iq.itemQuants[mClass]
	for _, mach in ipairs(mList) do
		if mach.lock then
			--TODO:
			--Finish this section.
			if scanReturns[mach.name][inSlot] then
				local eName = nameEncode(scanReturns[mach.name][inSlot].name, scanReturns[mach.name][inSlot].nbt)
			end
		else
			for eName, amount in pairs(inManifest) do
				local movedAnything = false
				if itemQ[eName] then
					if itemQ[eName] <= amount then
						movedAnything = insertInput(eName, itemQ[eName], mList.input[1], mach.name, inSlot, inManifest, inputData, fTable)
						mach.lock = true
						break
					end
				else
					movedAnything = insertInput(eName, 1, mList.input[1], mach.name, inSlot, inManifest, inputData, fTable)
					mach.lock = true
					break
				end
			end
		end
	end
end






--Determines which insertion function
--to use for a given machine type.
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

--Battery manager which handles both
--the extraction of empty batteries and
--the insertion of fresh ones.
local function batMan(fTable)
	local battInState = scanReturns[batteryIn]
	local battInCount = 0
	local battOutState = scanReturns[batteryOut]
	local battOutCount = 0
	local breaker = false
	for mClass, mList in pairs(machineLists) do
		local batterySlot = sm.slotMaps[sm.machMaps[mClass]].battery
		if batterySlot then
			for _, mach in ipairs(mList) do
				local battSlotData = scanReturns[mach.name][batterySlot]
				if maxBattIn ~= battInCount and not battSlotData then
					table.insert(fTable, function()
						wp[batteryIn].pushItems(mach.name, 1, 1, batterySlot)
					end)
					battInState[1] = nil
					battInCount = battInCount + 1
				elseif maxBattOut ~= battOutCount and battSlotData and not battSlotData.nbt then
					local battName = nameEncode(battSlotData.name, battSlotData.nbt)
					if battSlotData.nbt == nil then
					--if battName == battSlotData.name then
					--if emptyBatteryENames[battName] and string.find(battName, "#") == nil then
						table.insert(fTable, function()
							wp[batteryOut].pullItems(mach.name, batterySlot, 1, 1)
						end)
						battOutState[1] = true
						battOutCount = battOutCount + 1
					end
				elseif maxBattIn == battInCount and maxBattOut == battOutCount then
					breaker = true
					break
				end
			end
		end
		if breaker then
			break
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
		scanReturns = {}
		os.sleep(1)
	end
end

main()