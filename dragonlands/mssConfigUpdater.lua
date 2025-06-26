--This script is meant to be a base
--which replaces the configuration
--files for a massStorageSystem install
--with those in a given alternative
--repository.

local config = require("configFiles.config")

local commonCodeDisk = config.commonCodeDisk

--As we will be overwriting config.lua,
--we need to remove the reference to
--it early.
config = nil