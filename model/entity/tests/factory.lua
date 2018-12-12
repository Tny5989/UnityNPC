local LuaUnit = require('luaunit')
local EntityFactory = require('model/entity/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
EntityFactoryTests = {}

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenBadParam()
    local e = EntityFactory.CreateMob()
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenUnableToGetMobInfo()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id()
        return nil
    end

    local e = EntityFactory.CreateMob(1234)
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenInvalidTarget()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 9999, valid_target = false }
    end

    local e = EntityFactory.CreateMob(1234)
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestMobEntityCreatedWhenAllInformationObtained()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 9999, valid_target = true }
    end

    local e = EntityFactory.CreateMob(1234)
    LuaUnit.assertEquals(e:Type(), 'MobEntity')
end

LuaUnit.LuaUnit.run('EntityFactoryTests')