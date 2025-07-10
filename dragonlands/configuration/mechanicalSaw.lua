--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_64"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "mechanicalSaw", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({"minecraft:stripped_birch_log",1},64,{{"minecraft:birch_log",1}})
addRecipe({n.plank,6},64,{{"minecraft:stripped_birch_log",1}})
addRecipe({n.shaft,6},64,{{n.andAlloy,1}})

--Final Return Statement

return{
recipeList = recipeList
}