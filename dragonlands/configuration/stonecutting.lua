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
--User-Defined Recipes

--Below is an example recipe.
makeRecipeBatch("create:cut_",rootNames,"","",rawStones,"",1,"minecraft:chest_3")

--Final Return Statement

return{
recipeList = recipeList
}