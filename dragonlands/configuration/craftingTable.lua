--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable, byproductsTable)
	local eName, recipeData = core.makeCTableRecipe(productTable, batchLim, ingredientsTable, byproductsTable)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Generic Components
addRecipe({"minecraft:redstone_torch",1},64,{n.rs,nil,nil,n.stick})
addRecipe({n.stick,4},64,{n.plank,nil,nil,n.plank})
addRecipe({"minecraft:torch",4},64,{"minecraft:charcoal",nil,nil,n.stick})
addRecipe({n.furnace,1},64,{n.cobble,n.cobble,n.cobble,n.cobble,nil,n.cobble,n.cobble,n.cobble,n.cobble})
addRecipe({n.piston,1},64,{n.plank,n.plank,n.plank,n.cobble,n.iron,n.cobble,n.cobble,n.rs,n.cobble})
addRecipe({n.glassP,16},64,{n.glass,n.glass,n.glass,n.glass,n.glass,n.glass})
addRecipe({n.plankS,6},64,{n.plank,n.plank,n.plank})
addRecipe({n.barrel,1},64,{"charm:birch_barrel"})
addRecipe({"charm:birch_barrel",1},64,{n.plank,n.plankS,n.plank,n.plank,nil,n.plank,n.plank,n.plankS,n.plank})
addRecipe({n.chest,1},64,{"charm:birch_chest"})
addRecipe({"charm:birch_chest",1},64,{n.plank,n.plank,n.plank,n.plank,nil,n.plank,n.plank,n.plank,n.plank})
addRecipe({"minecraft:compass",1},64,{nil,n.iron,nil,n.iron,n.rs,n.iron,nil,n.iron})
addRecipe({"minecraft:lever",1},64,{n.stick,nil,nil,n.cobble})
--ComputerCraft Stuff
addRecipe({"computercraft:cable",6},64,{nil,n.stone,nil,n.stone,n.rs,n.stone,nil,n.stone})
addRecipe({"computercraft:wired_modem",1},64,{n.stone,n.stone,n.stone,n.stone,n.rs,n.stone,n.stone,n.stone,n.stone})
addRecipe({"computercraft:computer_advanced",1},64,{n.gold,n.gold,n.gold,n.gold,n.rs,n.gold,n.gold,n.glassP,n.gold})
--Bigger Chests/Barrels
addRecipe({"expandedstorage:copper_barrel",1},64,{n.copper,n.copper,n.copper,n.copper,n.barrel,n.copper,n.copper,n.copper,n.copper})
addRecipe({"expandedstorage:iron_barrel",1},64,{n.ironN,n.ironN,n.ironN,n.iron,"expandedstorage:copper_barrel",n.iron,n.ironN,n.ironN,n.ironN})
--Create Transmission
addRecipe({n.cog,1},64,{n.shaft,n.plank})
addRecipe({n.bigCog,1},64,{n.cog,n.plank})
addRecipe({n.belt,1},64,{n.dKelp,n.dKelp,n.dKelp,n.dKelp,n.dKelp,n.dKelp})
addRecipe({"create:gearbox",1},64,{nil,n.cog,nil,n.cog,n.aCasing,n.cog,nil,n.cog})
addRecipe({"create:vertical_gearbox",1},64,{"create:gearbox"})
--Create Components
addRecipe({"create:brass_hand",1},64,{nil,n.andAlloy,nil,n.brassP,n.brassP,n.brassP,nil,n.brassP})
addRecipe({n.eTube,1},64,{"create:polished_rose_quartz",nil,nil,n.ironP})

addRecipe({"create:metal_girder",8},64,{n.ironP,n.ironP,n.ironP,n.andAlloy,n.andAlloy,n.andAlloy})
addRecipe({"create:metal_bracket",4},64,{n.ironN,n.ironN,n.ironN,n.iron,n.andAlloy,n.iron})
--Create Machines
addRecipe({"create:deployer",1},64,{n.eTube,nil,nil,n.aCasing,nil,nil,"create:brass_hand"})
addRecipe({"create:mechanical_saw",1},64,{nil,n.ironP,nil,n.ironP,n.iron,n.ironP,nil,n.aCasing})
addRecipe({"create:mechanical_press",1},64,{n.shaft,nil,nil,n.aCasing,nil,nil,"minecraft:iron_block"})
--Create Trains
addRecipe({"create:track_signal",4},64,{n.tCasing,n.eTube})
addRecipe({"create:track_station",2},64,{n.tCasing,"minecraft:compass"})
addRecipe({"create:controls",1},64,{"minecraft:lever",nil,nil,n.tCasing,nil,nil,"create:precision_mechanism"})
--Tech Reborn Components
addRecipe({n.bmFrame,1},64,{n.refIron,n.refIron,n.refIron,n.refIron,nil,n.refIron,n.refIron,n.refIron,n.refIron})
addRecipe({n.amFrame,1},64,{nil,"techreborn:carbon_plate",nil,n.aAlloyP,n.bmFrame,n.aAlloyP,nil,"techreborn:carbon_plate"})
addRecipe({n.treetap,1},16,{nil,n.stick,nil,n.plank,n.plank,n.plank,n.plank})
addRecipe({n.cell,4},64,{nil,n.tin,nil,n.tin,nil,n.tin,nil,n.tin})
addRecipe({"techreborn:basic_display",1},64,{n.refIronP,n.blackDye,n.refIronP,n.blackDye,n.eCircuit,n.blackDye,n.refIronP,n.glassP,n.refIronP})
addRecipe({"techreborn:carbon_mesh",1},64,{"techreborn:carbon_fiber","techreborn:carbon_fiber"})
addRecipe({"techreborn:mixed_metal_ingot",5},64,{n.invar,n.invar,n.invar,n.brass,n.brass,n.brass,n.aluminium,n.aluminium,n.aluminium})
--Tech Reborn Machines
addRecipe({"techreborn:iron_furnace",1},64,{nil,n.iron,nil,n.iron,nil,n.iron,n.iron,n.furnace,n.iron})
addRecipe({"techreborn:iron_alloy_furnace",1},64,{n.refIron,n.refIron,n.refIron,"techreborn:iron_furnace",nil,"techreborn:iron_furnace",n.refIron,n.refIron,n.refIron})
addRecipe({"techreborn:electric_furnace",1},64,{nil,n.eCircuit,nil,n.rs,"techreborn:iron_furnace",n.rs})
addRecipe({"techreborn:alloy_smelter",1},64,{nil,n.eCircuit,nil,"techreborn:electric_furnace","techreborn:iron_alloy_furnace","techreborn:electric_furnace"})
addRecipe({"techreborn:grinder",1},64,{n.flint,n.flint,n.flint,n.cobble,n.bmFrame,n.cobble,nil,n.eCircuit})
addRecipe({"techreborn:compressor",1},64,{n.stone,nil,n.stone,n.stone,n.eCircuit,n.stone,n.stone,n.bmFrame,n.stone})
addRecipe({"techreborn:extractor",1},1,{n.treetap,n.bmFrame,n.treetap,n.treetap,n.eCircuit,n.treetap})
addRecipe({"techreborn:rolling_machine",1},64,{n.piston,n.aCircuit,n.piston,"techreborn:compressor",n.bmFrame,"techreborn:compressor",n.piston,n.aCircuit,n.piston})
addRecipe({"techreborn:recycler",1},64,{nil,n.eCircuit,nil,n.dirt,"techreborn:compressor",n.dirt,"minecraft:glowstone_dust",n.dirt,"minecraft:glowstone_dust"})
addRecipe({"techreborn:wire_mill",1},64,{n.brassP,"techreborn:extractor",n.brassP,n.eCircuit,n.bmFrame,n.eCircuit,n.brassP,n.piston,n.brassP})
addRecipe({"techreborn:solid_canning_machine",1},64,{n.tin,n.eCircuit,n.tin,n.tin,n.bmFrame,n.tin,n.tin,n.tin,n.tin})
addRecipe({"techreborn:launchpad",1},64,{"techreborn:magnalium_plate","techreborn:magnalium_plate","techreborn:magnalium_plate",n.aCircuit,n.piston,n.aCircuit,n.zincP,n.amFrame,n.zincP})
addRecipe({"techreborn:industrial_centrifuge",1},64,{n.aluminiumP,n.aCircuit,n.aluminiumP,n.amFrame,"techreborn:extractor",n.amFrame,n.aluminiumP,n.aCircuit,n.aluminiumP})
addRecipe({"techreborn:industrial_electrolyzer",1},64,{n.ironP,"techreborn:extractor",n.ironP,n.aCircuit,n.amFrame,n.aCircuit,n.ironP,"techreborn:extractor",n.ironP})
--Tech Reborn Multiblocks
addRecipe({"techreborn:basic_machine_casing",4},64,{n.aluminiumP,n.aluminiumP,n.aluminiumP,n.eCircuit,n.bmFrame,n.eCircuit,n.aluminiumP,n.aluminiumP,n.aluminiumP})
addRecipe({"techreborn:advanced_machine_casing",4},64,{n.steelP,n.steelP,n.steelP,n.aCircuit,n.amFrame,n.aCircuit,n.steelP,n.steelP,n.steelP})
addRecipe({"techreborn:industrial_machine_casing",4},64,{n.chromeP,n.chromeP,n.chromeP,n.dsCore,n.imFrame,n.dsCore,n.chromeP,n.chromeP,n.chromeP})
addRecipe({"techreborn:industrial_blast_furnace",1},64,{n.aCircuit,"techreborn:cupronickel_heating_coil",n.aCircuit,"techreborn:cupronickel_heating_coil",n.amFrame,"techreborn:cupronickel_heating_coil","techreborn:electric_furnace","techreborn:cupronickel_heating_coil","techreborn:electric_furnace"})
addRecipe({"techreborn:industrial_sawmill",1},64,{n.refIron,n.aCircuit,n.refIron,"techreborn:diamond_saw_blade","techreborn:diamond_saw_blade","techreborn:diamond_saw_blade",n.aCircuit,n.amFrame,n.aCircuit})
--Tech Reborn Storage Blocks
addRecipe({"techreborn:crude_storage_unit",1},64,{n.plank,n.plank,n.plank,n.plank,n.barrel,n.plank,n.plank,n.paper,n.plank})
addRecipe({"techreborn:basic_storage_unit",1},64,{n.refIronP,n.refIronP,n.refIronP,"techreborn:crude_storage_unit",n.bmFrame,"techreborn:crude_storage_unit",n.eCircuit,"techreborn:basic_display",n.eCircuit})

addRecipe({"techreborn:basic_tank_unit",1},16,{nil,n.cell,nil,n.rubber,"techreborn:basic_storage_unit",n.rubber,nil,n.cell})

--Final Return Statement

return{
recipeList = recipeList
}