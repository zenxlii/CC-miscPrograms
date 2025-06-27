--This library is used to abstract away
--the actual slot numbers of machines,
--so that easier-to-remember strings
--can be used instead.

local slotMaps = {}
slotMaps["basic"] = {}
slotMaps.basic.input = {1}
slotMaps.basic.output = {2}
slotMaps.basic.battery = 3
slotMaps["basic2In"] = {}
slotMaps.basic2In.input = {1,2}
slotMaps.basic2In.output = {3}
slotMaps.basic2In.battery = 4
slotMaps["cell4Out"] = {}
slotMaps.cell4Out.input = {1}
slotMaps.cell4Out.cell = 2
slotMaps.cell4Out.output = {3,4,5,6}
slotMaps.cell4Out.battery = 7
slotMaps["storageUnit"] = {}
slotMaps.storageUnit.input = {1}
slotMaps.storageUnit.output = {2}
slotMaps["rolling"] = {}
slotMaps.rolling.input = {1,2,3,4,5,6,7,8,9}
slotMaps.rolling.output = {10}
slotMaps.rolling.battery = 11

local machMaps = {}
machMaps["techreborn:storage_unit"] = "storageUnit"
machMaps["techreborn:electric_furnace"] = "basic"
machMaps["techreborn:grinder"] = "basic"
machMaps["techreborn:compressor"] = "basic"
machMaps["techreborn:extractor"] = "basic"
machMaps["techreborn:wire_mill"] = "basic"
machMaps["techreborn:alloy_smelter"] = "basic2In"
machMaps["techreborn:assembly_machine"] = "basic2In"
machMaps["techreborn:chemical_reactor"] = "basic2In"
machMaps["techreborn:solid_canning_machine"] = "basic2In"
machMaps["techreborn:industrial_centrifuge"] = "cell4Out"
machMaps["techreborn:industrial_electrolyzer"] = "cell4Out"
machMaps["techreborn:rolling_machine"] = "rolling"





return{
slotMaps = slotMaps,
machMaps = machMaps
}