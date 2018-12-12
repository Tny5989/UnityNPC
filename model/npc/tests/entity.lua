local LuaUnit = require('luaunit')
local EntityFactory = require('model/entity/factory')
local EntityNpc = require('model/npc/entity')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
EntityNpcTests = {}

--------------------------------------------------------------------------------
function EntityNpcTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 9999, valid_target = true }
    end
end

--------------------------------------------------------------------------------
function EntityNpcTests:TestNpcIdIsCorrect()
    local lock = EntityNpc:EntityNpc(1234, 1, EntityFactory.CreateMob(1234))
    LuaUnit.assertEquals(lock:Id(), 1234)
end

--------------------------------------------------------------------------------
function EntityNpcTests:TestZoneIsCorrect()
    local lock = EntityNpc:EntityNpc(1234, 1, EntityFactory.CreateMob(1234))
    LuaUnit.assertEquals(lock:Zone(), 1)
end

--------------------------------------------------------------------------------
function EntityNpcTests:TestNpcEntityIsCorrect()
    local entity = EntityFactory.CreateMob(1234)
    local lock = EntityNpc:EntityNpc(1234, 1, entity)
    LuaUnit.assertEquals(lock:Entity(), entity)
end

--------------------------------------------------------------------------------
function EntityNpcTests:TestTypeIsEntityNpc()
    local lock = EntityNpc:EntityNpc(1234, 1, EntityFactory.CreateMob(1234))
    LuaUnit.assertEquals(lock:Type(), 'EntityNpc')
end

LuaUnit.LuaUnit.run('EntityNpcTests')