local LuaUnit = require('luaunit')
local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilEntityTests = {}

--------------------------------------------------------------------------------
function NilEntityTests:TestDefaultIdIsZero()
    local e = NilEntity:NilEntity()
    LuaUnit.assertEquals(e:Id(), 0)
end

--------------------------------------------------------------------------------
function NilEntityTests:TestDefaultIndexIsZero()
    local e = NilEntity:NilEntity()
    LuaUnit.assertEquals(e:Index(), 0)
end

--------------------------------------------------------------------------------
function NilEntityTests:TestDefaultDistanceIsMax()
    local e = NilEntity:NilEntity()
    LuaUnit.assertEquals(e:Distance(), NilEntity.MAX_DISTANCE)
end

--------------------------------------------------------------------------------
function NilEntityTests:TestTypeIsEntity()
    local e = NilEntity:NilEntity()
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function NilEntityTests:TestBagTypeIsNil()
    local e = NilEntity:NilEntity()
    LuaUnit.assertEquals(e:Bag():Type(), 'NilInventory')
end

LuaUnit.LuaUnit.run('NilEntityTests')