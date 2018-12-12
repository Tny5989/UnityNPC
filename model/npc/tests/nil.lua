local LuaUnit = require('luaunit')
local NilNpc = require('model/npc/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilNpcTests = {}

--------------------------------------------------------------------------------
function NilNpcTests:TestDefaultIdIsZero()
    local npc = NilNpc:NilNpc()
    LuaUnit.assertEquals(npc:Id(), 0)
end

--------------------------------------------------------------------------------
function NilNpcTests:TestDefaultEntityIsNilEntity()
    local npc = NilNpc:NilNpc()
    LuaUnit.assertEquals(npc:Entity():Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function NilNpcTests:TestDefaultZoneIsZero()
    local npc = NilNpc:NilNpc()
    LuaUnit.assertEquals(npc:Zone(), 0)
end

--------------------------------------------------------------------------------
function NilNpcTests:TestTypeIsNilNpc()
    local npc = NilNpc:NilNpc()
    LuaUnit.assertEquals(npc:Type(), 'NilNpc')
end

LuaUnit.LuaUnit.run('NilNpcTests')