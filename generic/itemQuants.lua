local itemQuants = {}

--Single Item Only Recipes
itemQuants["techreborn:wire_mill"] = {} 
itemQuants["techreborn:extractor"] = {}
itemQuants["techreborn:grinder"] = {}

--Single Ingredient Recipes
--Formatted as follows:
--[machineName][ingredientName] = amount

--Compressor
itemQuants["techreborn:compressor"] = {}
itemQuants["techreborn:compressor"]["techreborn:saw_dust"] = 2

--Multiple Ingredient Recipes
--Formatted as follows:
--[machineName][recipePriority][ingredient1] = {eName, amount}
--[machineName][recipePriority][ingredient2] = {eName, amount}
--and so on for as many ingredients are
--in the recipe.

--Alloy Smelter
itemQuants["techreborn:alloy_smelter"] = {}
itemQuants["techreborn:alloy_smelter"][1] = {}
itemQuants["techreborn:alloy_smelter"][1][1] = {"minecraft:gold_ingot", 10}
itemQuants["techreborn:alloy_smelter"][1][2] = {"minecraft:netherite_scrap", 10}
itemQuants["techreborn:alloy_smelter"][2] = {}
itemQuants["techreborn:alloy_smelter"][2][1] = {"minecraft:gold_ingot", 1}
itemQuants["techreborn:alloy_smelter"][2][2] = {"techreborn:silver_ingot", 1}
itemQuants["techreborn:alloy_smelter"][3] = {}
itemQuants["techreborn:alloy_smelter"][3][1] = {"minecraft:iron_ingot", 2}
itemQuants["techreborn:alloy_smelter"][3][2] = {"techreborn:nickel_ingot", 1}
itemQuants["techreborn:alloy_smelter"][4] = {}
itemQuants["techreborn:alloy_smelter"][4][1] = {"minecraft:copper_ingot", 3}
itemQuants["techreborn:alloy_smelter"][4][2] = {"techreborn:tin_ingot", 1}
itemQuants["techreborn:alloy_smelter"][5] = {}
itemQuants["techreborn:alloy_smelter"][5][1] = {"minecraft:copper_ingot", 3}
itemQuants["techreborn:alloy_smelter"][5][2] = {"create:zinc_ingot", 1}









--Rolling Machine























return{
itemQuants = itemQuants
}