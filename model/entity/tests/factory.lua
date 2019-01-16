local LuaUnit = require('luaunit')
local EntityFactory = require('model/entity/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
EntityFactoryTests = {}

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenUnableToGetPlayer()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return nil
    end

    local e = EntityFactory.CreatePlayer()
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenUnableToGetPlayerMob()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return {id = 1234}
    end

    function windower.ffxi.get_mob_by_id()
        return nil
    end

    local e = EntityFactory.CreatePlayer()
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestPlayerEntityCreatedWhenAllInformationObtained()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_player()
        return {id = 1234}
    end

    function windower.ffxi.get_mob_by_id()
        return {id = 1234, index = 4321, distance = 9999}
    end

    function windower.ffxi.get_items()
        return {max = 0, count = 0}
    end

    local e = EntityFactory.CreatePlayer()
    LuaUnit.assertEquals(e:Type(), 'PlayerEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenBadParam()
    windower = {}
    windower.ffxi = {}

    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end

    function windower.ffxi.get_info()
        return { zone = 11 }
    end

    local e = EntityFactory.CreateMob(nil)
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenUnableToGetMobInfo()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id()
        return nil
    end

    function windower.ffxi.get_info()
        return { zone = 11 }
    end

    local e = EntityFactory.CreateMob(1234)
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestNilEntityCreatedWhenUnableToGetZone()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end

    function windower.ffxi.get_info()
        return nil
    end

    local e = EntityFactory.CreateMob(1234)
    LuaUnit.assertEquals(e:Type(), 'NilEntity')
end

--------------------------------------------------------------------------------
function EntityFactoryTests:TestMobEntityCreatedWhenAllInformationObtained()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 9999}
    end

    function windower.ffxi.get_info()
        return { zone = 11 }
    end

    local e = EntityFactory.CreateMob(1234)
    LuaUnit.assertEquals(e:Type(), 'MobEntity')
end

LuaUnit.LuaUnit.run('EntityFactoryTests')