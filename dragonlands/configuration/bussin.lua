local config = require("configFiles.config")
local importBuffer = config.importBuffer
local taskTable = {}

--Add tasks like the task below to
--taskTable.
local clientDumpImportTask = {}
clientDumpImportTask["taskType"] = "import"
clientDumpImportTask["target"] = importBuffer
clientDumpImportTask["specificSlots"] = false
table.insert(taskTable, clientDumpImportTask)
--Add your tasks below here!
local procSysImportTask = {}
procSysImportTask["taskType"] = "import"
procSysImportTask["target"] = "expandedstorage:chest_5"
procSysImportTask["specificSlots"] = false
table.insert(taskTable, procSysImportTask)

local furnOut = {}
furnOut["taskType"] = "import"
furnOut["target"] = "expandedstorage:barrel_160"
furnOut["specificSlots"] = false
table.insert(taskTable, furnOut)

local machBlock1Out = {}
machBlock1Out["taskType"] = "import"
machBlock1Out["target"] = "minecraft:barrel_23"
machBlock1Out["specificSlots"] = false
table.insert(taskTable, machBlock1Out)



return{
taskTable = taskTable
}