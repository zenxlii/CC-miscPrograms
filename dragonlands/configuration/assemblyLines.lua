--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable, inventories)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "assemblyLine", inventories)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({"railways:track_monorail",6},1,{{"create:metal_bracket",1},{n.ironP,1},{"create:metal_girder",1}},{"minecraft:barrel_67","minecraft:barrel_68","minecraft:barrel_69"})

--Final Return Statement

return{
recipeList = recipeList
}