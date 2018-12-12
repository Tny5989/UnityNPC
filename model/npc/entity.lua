local NilNpc = require('model/npc/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local EntityNpc = NilNpc:NilNpc()
EntityNpc.__index = EntityNpc

--------------------------------------------------------------------------------
function EntityNpc:EntityNpc(id, zone, entity)
    local o = NilNpc:NilNpc()
    setmetatable(o, self)
    o._id = id
    o._zone = zone
    o._entity = entity
    o._type = 'EntityNpc'
    return o
end

return EntityNpc
