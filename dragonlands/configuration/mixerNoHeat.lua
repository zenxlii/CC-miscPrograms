--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_61",
"minecraft:barrel_62"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "mixerNoHeat", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({n.andAlloy,1},64,{{"create:zinc_nugget",1},{"minecraft:andesite",1}})

--Final Return Statement

return{
recipeList = recipeList
}