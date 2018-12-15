local NilCommand = require('command/nil')
local WarpCommand = require('command/warp')
local Npcs = require('data/npcs')
local Warps = require('data/warps')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local CommandFactory = {}

--------------------------------------------------------------------------------
local function StringToZoneId(name)
    local zone = resources.zones:with('en', windower.convert_auto_trans(name))
    if zone then
        return zone.id
    else
        return 0
    end
end

--------------------------------------------------------------------------------
function CommandFactory.CreateCommand(cmd, name)
    if cmd == 'warp' then
        if not name then
            log('Zone must be provided')
            return NilCommand:NilCommand()
        end

        local warp = Warps.GetByProperty('zone', StringToZoneId(name))
        local npc = Npcs.GetForCurrentZone()

        return WarpCommand:WarpCommand(npc.id, npc.zone, warp.idx)
    else
        log('Unknown command')
        return NilCommand:NilCommand()
    end
end

return CommandFactory