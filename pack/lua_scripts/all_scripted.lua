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

package.path = package.path .. ";script/profi/?.lua"
profi = require("profi")

is_profiling = false

table.insert(events.FactionTurnStart, function(context)
    if context:faction():is_human() then
        if not is_profiling then
            profi:start()
            is_profiling = true
        else
            profi:stop()
            profi:writeReport("rome2_luaprofiler.report.txt")
            is_profiling = false
        end
    end
end)
