--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_30"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "wireMill", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({n.goldC,6},64,{{n.gold,1}})
addRecipe({n.copperC,6},64,{{n.copper,1}})
addRecipe({n.tinC,6},64,{{n.tin,1}})
addRecipe({n.hvC,6},64,{{n.refIron,1}})

--Final Return Statement

return{
recipeList = recipeList
}