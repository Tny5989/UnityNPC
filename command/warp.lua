local NilCommand = require('command/nil')
local NpcFactory = require('model/npc/factory')
local DialogueFactory = require('model/dialogue/factory')


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local WarpCommand = NilCommand:NilCommand()
WarpCommand.__index = WarpCommand

--------------------------------------------------------------------------------
function WarpCommand:WarpCommand(id, zone, zone_idx)
    local o = NilCommand:NilCommand()
    setmetatable(o, self)
    o._npc = NpcFactory.CreateNpc(id, zone)
    o._dialogue = DialogueFactory.CreateWarpDialogue(o._npc, zone_idx)
    o._dialogue:SetSuccessCallback(function() o._on_success() end)
    o._dialogue:SetFailureCallback(function() o._on_failure() end)
    o._type = 'WarpCommand'
    return o
end

--------------------------------------------------------------------------------
function WarpCommand:OnIncomingData(id, pkt)
    return self._dialogue:OnIncomingData(id, pkt)
end

--------------------------------------------------------------------------------
function WarpCommand:__call()
    self._dialogue:Start()
end

return WarpCommand