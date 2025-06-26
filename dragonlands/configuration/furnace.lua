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
addRecipe({"minecraft:brick",1},64,{{"minecraft:clay_ball",1}})
addRecipe({n.stone,1},64,{{n.cobble,1}})
addRecipe({"minecraft:smooth_stone",1},64,{{n.stone,1}})
addRecipe({n.refIron,1},64,{{n.iron,1}})
addRecipe({n.aAlloy,1},64,{{"techreborn:mixed_metal_ingot",1}})
addRecipe({n.glass,1},64,{{n.sand,1}})
addRecipe({n.dKelp,1},64,{{"minecraft:kelp",1}})
addRecipe({"minecraft:nether_brick",1},64,{{n.nRack,1}})

--Final Return Statement

return{
recipeList = recipeList
}