--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_75",
"minecraft:barrel_76"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "chemicalReactor", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({"minecraft:ender_eye",2},64,{{"minecraft:blaze_powder",1},{"minecraft:ender_pearl",1}})
addRecipe({"techreborn:synthetic_redstone_crystal",1},64,{{n.rs,32},{n.diamond,1}})

--Final Return Statement

return{
recipeList = recipeList
}