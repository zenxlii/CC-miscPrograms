





local scanFuncList = {}
local scanResults = {}

--Nice Little Functions

local function nameEncode(iName, iNBT)
	if iNBT == "" or iNBT == nil then
		return iName
	else
		return iName.."#"..iNBT
	end
end

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

local batchSize = 250

local function batchedParallel(funcs)
	for cnt = 1, #funcs, batchSize do
        local batchEnd = cnt + batchSize - 1
        local highLim = math.min(batchEnd, #funcs)
        parallel.waitForAll(table.unpack(funcs, cnt, highLim))
    end
end

local wrappedPeriTable = {}

local function fastWrap(peripheralName)
	if not wrappedPeriTable[peripheralName] then
		wrappedPeriTable[peripheralName] = peripheral.wrap(peripheralName)
	end
	return wrappedPeriTable[peripheralName]
end

local tryPull = {}

--Adds an inventory name to a table,
--while also putting it into the
--scanFuncList and scanResults.
local function addInv(invName, tableToAddTo, pullSlots)
	table.insert(invName, tableToAddTo)
	local periRef = fastWrap(invName)
	table.insert(scanFuncList, function()
		scanResults[invName] = fastWrap(invName).list()
	end)
	for _, slot in pairs(pullSlots) do
		table.insert(tryPull, {invName, slot})
	end
end

--Machine Input Whitelists

--Short for move out whitelist.
local mowl = {}
mowl["minecraft:iron_ore"] = "wig"
mowl["minecraft:deepslate_iron_ore"] = "wig"
mowl["deeperdarker:sculk_stone_iron_ore"] = "wig"


--Constants

local esB = "expandedstorage:barrel_"

local tIG = "techreborn:industrial_grinder_"

local importBuffer = esB.."9"
table.insert(scanFuncList, function()
	scanResults[importBuffer] = fastWrap(importBuffer).list()
end)

local storageNames = {}
for cnt = 0, 7 do
	addInv(storageNames, esB..cnt)
end

local igPullSlots = {3,4,5,6}
local iGrindWater = {}
local iGrindMercury = {}
local iGrindSodium = {}
for cnt = 0, 3 do
	addInv(iGrindWater, tIG..cnt, igPullSlots)
	addInv(iGrindMercury, tIG..cnt+4, igPullSlots)
	addInv(iGrindSodium, tIG..cnt+8, igPullSlots)
end



--Item Moving Functions

local itemMoveFuncList = {}



--Major Functions

local function runScan()
	batchedParallel(scanFuncList)
end

local function outMoveFunc(sourceName, sourceSlot, targetName, targetSlot)
	table.insert(itemMoveFuncList, function ()
		fastWrap(sourceName).pushItems(targetName, sourceSlot, 64, targetSlot)
	end)
	scanResults[targetName][targetSlot] = true
end

local function findSlotToSendTo(invName, slotNum, tc)
	if tc == "wig" then
		for _, tn in pairs(iGrindWater) do
			if not scanResults[tn][1] then
				outMoveFunc(invName, slotNum, tn, 1)
			end
		end
	elseif tc == "mig" then
		for _, tn in pairs(iGrindMercury) do
			if not scanResults[tn][1] then
				outMoveFunc(invName, slotNum, tn, 1)
			end
		end
	elseif tc == "sig" then
		for _, tn in pairs(iGrindSodium) do
			if not scanResults[tn][1] then
				outMoveFunc(invName, slotNum, tn, 1)
			end
		end
	else
		
	end
end

local function sendItemToWhere(invName, slotNum, eName)
	if mowl[eName] then
		findSlotToSendTo(invName, slotNum, mowl[eName])
	end
end

local function sendToBuffer(invName, slotNum)
	if scanResults[invName][slotNum] then
		table.insert(itemMoveFuncList, function ()
			fastWrap(invName).pushItems(importBuffer, slotNum)
		end)
		scanResults[invName][slotNum] = false
	end
end

local function mainLoop()
	while true do
		--Scan all inventories.
		runScan()
		--Attempt to move as many items
		--from storage into their
		--assigned places.
		for index, invName in ipairs(storageNames) do
			local scan = scanResults[invName]
			for slotNum, iData in pairs(scan) do
				local eName = nameEncode(iData.name, iData.nbt)
				sendItemToWhere(invName, slotNum, eName)
			end
		end
		--Extracts items from any slots
		--that we have explicitly
		--marked for extraction.
		for _, invAndSlot in ipairs(tryPull) do
			sendToBuffer(invAndSlot[1], invAndSlot[2])
		end
		
		
		--Now do all the item movements
		--at once.
		batchedParallel(itemMoveFuncList)
		itemMoveFuncList = {}
	end
end