local LuaUnit = require('luaunit')
local NpcFactory = require('model/npc/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NpcFactoryTests = {}

--------------------------------------------------------------------------------
function NpcFactoryTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 5, valid_target = true }
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20
end

--------------------------------------------------------------------------------
function NpcFactoryTests:TestNilNpcCreatedWhenBadParam()
    local npc = NpcFactory.CreateNpc()
    LuaUnit.assertEquals(npc:Type(), 'NilNpc')
end

--------------------------------------------------------------------------------
function NpcFactoryTests:TestEntityNpcCreatedWhenBadMob()
    function windower.ffxi.get_mob_by_id(id)
        return nil
    end

    local key = NpcFactory.CreateNpc(1234, 4321)
    LuaUnit.assertEquals(key:Type(), 'EntityNpc')
end

--------------------------------------------------------------------------------
function NpcFactoryTests:TestEntityNpcCreatedWhenFarAway()
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end


    local npc = NpcFactory.CreateNpc(1234, 4321)
    LuaUnit.assertEquals(npc:Type(), 'EntityNpc')
end


--------------------------------------------------------------------------------
function NpcFactoryTests:TestEntityNpcCreatedWhenValidIdPassed()
    local npc = NpcFactory.CreateNpc(1234, 4321)
    LuaUnit.assertEquals(npc:Type(), 'EntityNpc')
end

LuaUnit.LuaUnit.run('NpcFactoryTests')