--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productEName, batchLim, pullInv, pullSlot)
	local eName, recipeData = core.makeInfiniteRetrieveRecipe(productEName, batchLim, pullInv, pullSlot)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe(n.cobble, 64, "techreborn:storage_unit_68", 2)
--Final Return Statement

return{
recipeList = recipeList
}