--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_65",
"minecraft:barrel_66"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "deployer", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({n.aCasing,1},64,{{n.andAlloy,1},{"minecraft:stripped_birch_log",1}})
addRecipe({n.bCasing,1},64,{{n.brass,1},{"minecraft:stripped_birch_log",1}})
addRecipe({n.cCasing,1},64,{{n.copper,1},{"minecraft:stripped_birch_log",1}})
addRecipe({n.tCasing,1},64,{{"techreborn:obsidian_plate",1},{n.bCasing,1}})

--Final Return Statement

return{
recipeList = recipeList
}