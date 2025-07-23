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

--Chemical Reactor
itemQuants["techreborn:chemical_reactor"] = {}
itemQuants["techreborn:chemical_reactor"][1] = {}
itemQuants["techreborn:chemical_reactor"][1][1] = {"minecraft:blaze_powder",1}
itemQuants["techreborn:chemical_reactor"][1][2] = {"minecraft:ender_pearl",1}
itemQuants["techreborn:chemical_reactor"][2] = {}
itemQuants["techreborn:chemical_reactor"][2][1] = {"minecraft:redstone",32}
itemQuants["techreborn:chemical_reactor"][2][2] = {"minecraft:diamond",1}





--Rolling Machine
itemQuants["techreborn:rolling_machine"] = {}
itemQuants["techreborn:rolling_machine"][1] = {}
itemQuants["techreborn:rolling_machine"][1][1] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][1][2] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][1][4] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][1][5] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][1][7] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][1][8] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][2] = {}
itemQuants["techreborn:rolling_machine"][2][1] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][2][2] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][2][3] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][2][4] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][2][5] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][2][6] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][3] = {}
itemQuants["techreborn:rolling_machine"][3][1] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][3][3] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][3][4] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][3][6] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][3][8] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][4] = {}
itemQuants["techreborn:rolling_machine"][4][1] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][4][2] = {"minecraft:iron_ingot",1}
itemQuants["techreborn:rolling_machine"][5] = {}
itemQuants["techreborn:rolling_machine"][5][1] = {"minecraft:gold_ingot",1}
itemQuants["techreborn:rolling_machine"][5][2] = {"minecraft:gold_ingot",1}
itemQuants["techreborn:rolling_machine"][6] = {}
itemQuants["techreborn:rolling_machine"][6][1] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][6][2] = {"minecraft:copper_ingot",1}
itemQuants["techreborn:rolling_machine"][6][3] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][6][4] = {"minecraft:copper_ingot",1}
itemQuants["techreborn:rolling_machine"][6][6] = {"minecraft:copper_ingot",1}
itemQuants["techreborn:rolling_machine"][6][7] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][6][8] = {"minecraft:copper_ingot",1}
itemQuants["techreborn:rolling_machine"][6][9] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][7] = {}
itemQuants["techreborn:rolling_machine"][7][2] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][7][4] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][7][5] = {"techreborn:chrome_ingot",1}
itemQuants["techreborn:rolling_machine"][7][6] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][7][8] = {"techreborn:nickel_ingot",1}
itemQuants["techreborn:rolling_machine"][8] = {}
itemQuants["techreborn:rolling_machine"][8][1] = {"techreborn:aluminum_ingot",1}
itemQuants["techreborn:rolling_machine"][8][2] = {"techreborn:aluminum_ingot",1}
itemQuants["techreborn:rolling_machine"][8][3] = {"techreborn:aluminum_ingot",1}
itemQuants["techreborn:rolling_machine"][8][4] = {"techreborn:magnesium_dust",1}
itemQuants["techreborn:rolling_machine"][8][5] = {"techreborn:magnesium_dust",1}
itemQuants["techreborn:rolling_machine"][8][6] = {"techreborn:magnesium_dust",1}
itemQuants["techreborn:rolling_machine"][8][7] = {"techreborn:aluminum_ingot",1}
itemQuants["techreborn:rolling_machine"][8][8] = {"techreborn:aluminum_ingot",1}
itemQuants["techreborn:rolling_machine"][8][9] = {"techreborn:aluminum_ingot",1}




















return{
itemQuants = itemQuants
}