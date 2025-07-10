--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_40",
"minecraft:barrel_41",
"minecraft:barrel_42",
"minecraft:barrel_43",
"minecraft:barrel_44",
"minecraft:barrel_45",
"minecraft:barrel_46",
"minecraft:barrel_47",
"minecraft:barrel_48"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "rollingMachine", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({n.bucket,2},64,{{n.iron,1},nil,{n.iron,1},{n.iron,1},nil,{n.iron,1},nil,{n.iron,1}})

--Final Return Statement

return{
recipeList = recipeList
}