





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
local function addInv(tableToAddTo, invName, pullSlots)
	table.insert(tableToAddTo, invName)
	local periRef = fastWrap(invName)
	table.insert(scanFuncList, function()
		scanResults[invName] = fastWrap(invName).list()
	end)
	if pullSlots then
		for _, slot in pairs(pullSlots) do
			table.insert(tryPull, {invName, slot})
		end
	end
end

--Machine Input Whitelists

--Short for move out whitelist.
local mowl = {}
--Water Grinders
mowl["minecraft:coal_ore"] = "wig"
mowl["minecraft:deepslate_coal_ore"] = "wig"
mowl["deeperdarker:sculk_stone_coal_ore"] = "wig"
mowl["minecraft:copper_ore"] = "wig"
mowl["minecraft:deepslate_copper_ore"] = "wig"
mowl["deeperdarker:sculk_stone_copper_ore"] = "wig"
mowl["minecraft:iron_ore"] = "wig"
mowl["minecraft:deepslate_iron_ore"] = "wig"
mowl["deeperdarker:sculk_stone_iron_ore"] = "wig"
mowl["minecraft:redstone_ore"] = "wig"
mowl["minecraft:deepslate_redstone_ore"] = "wig"
mowl["deeperdarker:sculk_stone_redstone_ore"] = "wig"
mowl["minecraft:lapis_ore"] = "wig"
mowl["minecraft:deepslate_lapis_ore"] = "wig"
mowl["deeperdarker:sculk_stone_lapis_ore"] = "wig"
mowl["techreborn:bauxite_ore"] = "wig"
mowl["techreborn:deepslate_bauxite_ore"] = "wig"
mowl["techreborn:galena_ore"] = "wig"
mowl["techreborn:deepslate_galena_ore"] = "wig"
mowl["techreborn:ruby_ore"] = "wig"
mowl["techreborn:deepslate_ruby_ore"] = "wig"
mowl["techreborn:sapphire_ore"] = "wig"
mowl["techreborn:deepslate_sapphire_ore"] = "wig"
mowl["techreborn:lead_ore"] = "wig"
mowl["techreborn:deepslate_lead_ore"] = "wig"
mowl["techreborn:silver_ore"] = "wig"
mowl["techreborn:deepslate_silver_ore"] = "wig"
--Mercury Grinders

--Sodium Persulphate Grinders

--Crushing Wheels
mowl["minecraft:raw_iron"] = "ccr"
mowl["minecraft:raw_copper"] = "ccr"
mowl["minecraft:raw_gold"] = "ccr"
mowl["create:zinc_ore"] = "ccr"
mowl["create:deepslate_zinc_ore"] = "ccr"
mowl["techreborn:raw_lead"] = "ccr"
mowl["techreborn:raw_silver"] = "ccr"
mowl["minecraft:nether_quartz_ore"] = "ccr"

--3x3 Compaction
mowl["techreborn:copper_nugget"] = "3x3"
mowl["techreborn:zinc_nugget"] = "3x3"

--2x2 Compaction
mowl["techreborn:glowstone_small_dust"] = "2x2"
mowl["techreborn:tungsten_small_dust"] = "2x2"
mowl["techreborn:ruby_small_dust"] = "2x2"
mowl["techreborn:sapphire_small_dust"] = "2x2"
mowl["techreborn:red_garnet_small_dust"] = "2x2"
mowl["techreborn:peridot_small_dust"] = "2x2"
mowl["techreborn:galena_small_dust"] = "2x2"

--1x1 Crafting
mowl["minecraft:raw_iron_block"] = "1x1"
mowl["minecraft:raw_gold_block"] = "1x1"
mowl["minecraft:raw_copper_block"] = "1x1"

--Industrial Blast Furnaces
mowl["techreborn:galena_dust"] = "ibf"
mowl["techreborn:aluminum_dust"] = "ibf"
mowl["techreborn:cell#c710b4dd5e1644e960c4f1a12c0147f9"] = "ibf"

--Bulk Washing
mowl["create:crushed_raw_iron"] = "bwa"
mowl["create:crushed_raw_gold"] = "bwa"
mowl["create:crushed_raw_copper"] = "bwa"
mowl["create:crushed_raw_zinc"] = "bwa"

--Bulk (WIP)

--Smelting
mowl["techreborn:zinc_dust"] = "smt"
mowl["techreborn:nickel_dust"] = "smt"
mowl["create:crushed_raw_lead"] = "smt"
mowl["create:crushed_raw_silver"] = "smt"

--One-Offs
mowl["create:experience_nugget"] = "den"

--Constants

local esB = "expandedstorage:barrel_"

local tIG = "techreborn:industrial_grinder_"

local table27 = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27}

local genImports = {}
addInv(genImports, "minecraft:barrel_5", table27)
addInv(genImports, "minecraft:barrel_4", table27)
addInv(genImports, "minecraft:barrel_15", table27)
addInv(genImports, "minecraft:barrel_12", table27)
addInv(genImports, "minecraft:barrel_14", table27)
addInv(genImports, "minecraft:barrel_18", table27)
addInv(genImports, "minecraft:barrel_20", table27)

local c3x3 = "minecraft:barrel_2"
table.insert(scanFuncList, function()
	scanResults[c3x3] = fastWrap(c3x3).list()
end)

local c2x2 = "minecraft:barrel_8"
table.insert(scanFuncList, function()
	scanResults[c2x2] = fastWrap(c2x2).list()
end)

local c1x1 = "minecraft:barrel_7"
table.insert(scanFuncList, function()
	scanResults[c1x1] = fastWrap(c1x1).list()
end)

local bwa = "minecraft:barrel_10"
table.insert(scanFuncList, function()
	scanResults[bwa] = fastWrap(bwa).list()
end)

local cCr = esB.."10"
table.insert(scanFuncList, function()
	scanResults[cCr] = fastWrap(cCr).list()
end)

local dEn = "minecraft:barrel_6"
table.insert(scanFuncList, function()
	scanResults[dEn] = fastWrap(dEn).list()
end)

local ibf = "minecraft:chest_0"
table.insert(scanFuncList, function()
	scanResults[ibf] = fastWrap(ibf).list()
end)

local smt = "techreborn:electric_furnace_1"
table.insert(scanFuncList, function()
	scanResults[smt] = fastWrap(smt).list()
end)

local exportBuffer = "expandedstorage:chest_4"
table.insert(scanFuncList, function()
	scanResults[exportBuffer] = fastWrap(exportBuffer).list()
end)

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
	elseif tc == "ccr" then
		for slot = 1, 81 do
			if not scanResults[cCr][slot] then
				outMoveFunc(invName, slotNum, cCr, slot)
			end
		end
	elseif tc == "3x3" then
		for slot = 1, 27 do
			if not scanResults[c3x3][slot] then
				outMoveFunc(invName, slotNum, c3x3, slot)
			end
		end
	elseif tc == "2x2" then
		for slot = 1, 27 do
			if not scanResults[c2x2][slot] then
				outMoveFunc(invName, slotNum, c2x2, slot)
			end
		end
	elseif tc == "1x1" then
		for slot = 1, 27 do
			if not scanResults[c1x1][slot] then
				outMoveFunc(invName, slotNum, c1x1, slot)
			end
		end
	elseif tc == "den" then
		for slot = 1, 27 do
			if not scanResults[dEn][slot] then
				outMoveFunc(invName, slotNum, dEn, slot)
			end
		end
	elseif tc == "ibf" then
		for slot = 1, 54 do
			if not scanResults[ibf][slot] then
				outMoveFunc(invName, slotNum, ibf, slot)
			end
		end
	elseif tc == "bwa" then
		for slot = 1, 27 do
			if not scanResults[bwa][slot] then
				outMoveFunc(invName, slotNum, bwa, slot)
			end
		end
	elseif tc == "smt" then
		if not scanResults[smt][1] then
			outMoveFunc(invName, slotNum, smt, 1)
		end
	end
end

local function sendItemToWhere(invName, slotNum, eName)
	if mowl[eName] then
		findSlotToSendTo(invName, slotNum, mowl[eName])
	else
		for slot = 1, 54 do
			if not scanResults[exportBuffer][slot] then
				outMoveFunc(invName, slotNum, exportBuffer, slot)
			end
		end
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

mainLoop()