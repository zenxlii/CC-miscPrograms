--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_34"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "grinder", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({"techreborn:obsidian_dust",4},64,{{n.obsidian,1}})
addRecipe({n.glowstone,4},64,{{n.glowstoneB,1}})
addRecipe({"techreborn:coal_dust",1},64,{{"minecraft:coal",1}})

--Final Return Statement

return{
recipeList = recipeList
}