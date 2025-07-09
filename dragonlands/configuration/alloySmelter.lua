--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_36",
"minecraft:barrel_37"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "alloySmelter", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({n.netherite,3},64,{{n.gold,10},{"minecraft:netherite_scrap",10}})
addRecipe({n.electrum,2},64,{{n.gold,1},{n.silver,1}})
addRecipe({n.invar,3},64,{{n.iron,2},{n.nickel,1}})
addRecipe({n.bronze,4},64,{{n.copper,3},{n.tin,1}})
addRecipe({n.brass,4},64,{{n.copper,3},{n.zinc,1}})

--Final Return Statement

return{
recipeList = recipeList
}