local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NilNpc = {}
NilNpc.__index = NilNpc

--------------------------------------------------------------------------------
function NilNpc:NilNpc()
    local o = {}
    setmetatable(o, self)
    o._id = 0
    o._zone = 0
    o._entity = NilEntity:NilEntity()
    o._type = 'NilNpc'
    return o
end

--------------------------------------------------------------------------------
function NilNpc:Id()
    return self._id
end

--------------------------------------------------------------------------------
function NilNpc:Zone()
    return self._zone
end

--------------------------------------------------------------------------------
function NilNpc:Entity()
    return self._entity
end

--------------------------------------------------------------------------------
function NilNpc:Type()
    return self._type
end

return NilNpc
