--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local rawStones = {
"minecraft:granite",
"minecraft:diorite",
"minecraft:andesite",
"minecraft:calcite",
"minecraft:dripstone_block",
"minecraft:deepslate",
"minecraft:tuff",
"create:asurine",
"create:crimsite",
"create:limestone",
"create:ochrum",
"create:scoria",
"create:scorchia",
"create:veridium"
}

local rootNames = {
"granite",
"diorite",
"andesite",
"calcite",
"dripstone",
"deepslate",
"tuff",
"asurine",
"crimsite",
"limestone",
"ochrum",
"scoria",
"scorchia",
"veridium"
}

local createVariantPrefixes = {
"cut_"
}

local createVariantSuffixes = {
""
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable, inventories)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "stonecutting", inventories)
	recipeList[eName] = recipeData
end

local function makeRecipeBatch(productPrefix, productList, productSuffix, inputPrefix, inputList, inputSuffix, productAmount, inputInventory)
	for cnt, prodNameMid in ipairs(productList) do
		local pName = productPrefix..prodNameMid..productSuffix
		local iName = inputPrefix..inputList[cnt]..inputSuffix
		addRecipe({pName,productAmount},64,{{iName,1}},{inputInventory})
	end
end

--TODO:
--Fix this function.
local function makeRecipeBatchBatch(productList, inputList, prefixList, suffixList, ending, productAmount, inputInventory)
	for cnt, prefix in ipairs(prefixList) do
		local suffix = suffixList[cnt]..ending
		makeRecipeBatch(prefix, productList, suffix, prefix, inputList, suffix, productAmount, inputInventory)
	end
end

--User-Defined Recipes

--Below is an example recipe.
makeRecipeBatch("create:cut_",rootNames,"","",rawStones,"",1,"minecraft:chest_3")
makeRecipeBatch("create:cut_",rootNames,"_wall","create:cut_",rootNames,"",1,"minecraft:barrel_74")
makeRecipeBatch("create:cut_",rootNames,"_stairs","create:cut_",rootNames,"",1,"minecraft:barrel_73")
makeRecipeBatch("create:cut_",rootNames,"_slab","create:cut_",rootNames,"",2,"minecraft:barrel_72")

--Final Return Statement

return{
recipeList = recipeList
}