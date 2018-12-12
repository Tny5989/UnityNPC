local EntityFactory = require('model/entity/factory')
local NilNpc = require('model/npc/nil')
local EntityNpc = require('model/npc/entity')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NpcFactory = {}

--------------------------------------------------------------------------------
function NpcFactory.CreateNpc(id, zone)
    if not id or not zone then
        return NilNpc:NilNpc()
    else
        return EntityNpc:EntityNpc(id, zone, EntityFactory.CreateMob(id))
    end
end

return NpcFactory
