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
addRecipe({"techreborn:cupronickel_heating_coil",3},64,{{n.nickel,1},{n.copper,1},{n.nickel,1},{n.copper,1},nil,{n.copper,1},{n.nickel,1},{n.copper,1},{n.nickel,1}})
addRecipe({n.ironBars,24},64,{{n.iron,1},{n.iron,1},{n.iron,1},{n.iron,1},{n.iron,1},{n.iron,1}})
addRecipe({"techreborn:nichrome_heating_coil",2},64,{nil,{n.nickel,1},nil,{n.nickel,1},{n.chrome,1},{n.nickel,1},nil,{n.nickel,1}})
addRecipe({"techreborn:magnalium_plate",3},64,{{n.aluminium,1},{n.aluminium,1},{n.aluminium,1},{"techreborn:magnesium_dust",1},{"techreborn:magnesium_dust",1},{"techreborn:magnesium_dust",1},{n.aluminium,1},{n.aluminium,1},{n.aluminium,1}})

--Final Return Statement

return{
recipeList = recipeList
}