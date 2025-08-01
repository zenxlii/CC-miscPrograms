--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:barrel_22"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "compressor", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
addRecipe({n.ironP,1},64,{{n.iron,1}})
addRecipe({n.goldP,1},64,{{n.gold,1}})
addRecipe({n.copperP,1},64,{{n.copper,1}})
addRecipe({n.tinP,1},64,{{n.tin,1}})
addRecipe({n.aluminiumP,1},64,{{n.aluminium,1}})
addRecipe({n.chromeP,1},64,{{n.chrome,1}})
addRecipe({n.zincP,1},64,{{n.zinc,1}})
addRecipe({n.nickelP,1},64,{{n.nickel,1}})
addRecipe({"techreborn:titanium_plate",1},64,{{n.titanium,1}})
addRecipe({"techreborn:lapis_plate",1},64,{{n.lapisB,1}})
addRecipe({"techreborn:redstone_plate",1},64,{{n.rsB,1}})
addRecipe({"techreborn:lead_plate",1},64,{{n.lead,1}})
addRecipe({n.brassP,1},64,{{n.brass,1}})
addRecipe({n.refIronP,1},64,{{n.refIron,1}})
addRecipe({n.aAlloyP,1},64,{{n.aAlloy,1}})
addRecipe({n.steelP,1},64,{{n.steel,1}})
addRecipe({n.electrumP,1},64,{{n.electrum,1}})
addRecipe({n.invarP,1},64,{{n.invar,1}})
addRecipe({"techreborn:coal_plate",1},64,{{"techreborn:coal_dust",1}})
addRecipe({"techreborn:carbon_plate",1},64,{{"techreborn:carbon_mesh",1}})
addRecipe({"techreborn:quartz_plate",1},64,{{"techreborn:quartz_dust",1}})
addRecipe({"techreborn:obsidian_plate",9},64,{{"minecraft:obsidian",1}})

--Final Return Statement

return{
recipeList = recipeList
}