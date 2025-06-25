--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"expandedstorage:barrel_159"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable, byproductsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "furnace", inInvs, byproductsTable)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({"minecraft:brick",1},64,{{"minecraft:clay",1}})
addRecipe({n.stone,1},64,{{n.cobble,1}})
addRecipe({"minecraft:smooth_stone",1},64,{{n.stone,1}})
addRecipe({n.refIron,1},64,{{n.iron,1}})

--Final Return Statement

return{
recipeList = recipeList
}