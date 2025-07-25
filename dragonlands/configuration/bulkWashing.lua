--Required Stuff
local core = require("recipeCoreDefs")

local n = core.sh

local inInvs = {
"minecraft:chest_4"
}

local recipeList = {}
--Relevant Recipe Function Wrapper
local function addRecipe(productTable, batchLim, ingredientsTable)
	local eName, recipeData = core.makeExternalRecipe(productTable, batchLim, ingredientsTable, "bulkWashing", inInvs)
	recipeList[eName] = recipeData
end
--User-Defined Recipes

--Below is an example recipe.
--addRecipe({,3},64,{{"techreborn:sap",1}})

--Concrete
local concPre = "minecraft:"
local concPost = "_concrete"
local concPPost = "_concrete_powder"
local dyeColours = {"white","orange","magenta","light_blue","yellow","lime","pink","gray","light_gray","cyan","purple","blue","brown","green","red","black"}
for _, colour in ipairs(dyeColours) do
	addRecipe({concPre..colour..concPost,1},64,{{concPre..colour..concPPost,1}})
end

--Final Return Statement

return{
recipeList = recipeList
}