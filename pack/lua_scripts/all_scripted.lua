--[[
Import all the lua scripts
--]]

local triggers = require "data.lua_scripts.export_triggers"
local ancillaries = require "data.lua_scripts.export_ancillaries"
local historic_characters = require "data.lua_scripts.export_historic_characters"
local missions = require "data.lua_scripts.export_missions"
local encyclopedia = require "data.lua_scripts.export_encyclopedia"
local experience = require "data.lua_scripts.export_experience"
local political = require "data.lua_scripts.export_political_triggers"

events = triggers.events
--[[
print(events, #events)

for n,v in ipairs(events.historical_events) do print(n, v) end
--]]

log = require("script._lib.lib_logging").new_logger("rome2_luaprofiler", "rome2_luaprofiler.txt", "DEBUG")
package.path = package.path .. ";rome2_luaprofiler/?.lua"

log:info("Profiler script initialized")

local ProFi = log:require("rome2_luaprofiler.profi")
local scripting = require("lua_scripts.episodicscripting")
local is_profiling = false  -- Global flag

local function handle_profiling(context)
    log:pcall(function()
        if context:faction():is_human() then
            if not is_profiling then
                ProFi:start()
                is_profiling = true
                log:info("Profiler started")
            else
                ProFi:stop()
                ProFi:writeReport("rome2_luaprofiler.report.txt")
                is_profiling = false
                log:info("Profiler stopped")
            end
        end
    end)
end

scripting.AddEventCallBack("FactionTurnStart", handle_profiling)

log:info("Profiler script loaded")
