local LuaUnit = require('luaunit')
local MobEntity = require('model/entity/mob')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
MobEntityTests = {}

--------------------------------------------------------------------------------
function MobEntityTests:TestEntityIdIsCorrect()
    local mob = {id = 1234, index = 4321, distance = 9999}
    local e = MobEntity:MobEntity(mob, 11)
    LuaUnit.assertEquals(e:Id(), 1234)
end

--------------------------------------------------------------------------------
function MobEntityTests:TestEntityIndexIsCorrect()
    local mob = {id = 1234, index = 4321, distance = 9999}
    local e = MobEntity:MobEntity(mob, 11)
    LuaUnit.assertEquals(e:Index(), 4321)
end

--------------------------------------------------------------------------------
function MobEntityTests:TestEntityZoneIsCorrect()
    local mob = {id = 1234, index = 4321, distance = 9999}
    local e = MobEntity:MobEntity(mob, 11)
    LuaUnit.assertEquals(e:Zone(), 11)
end

--------------------------------------------------------------------------------
function MobEntityTests:TestDistanceIsCorrect()
    local mob = {id = 1234, index = 4321, distance = 9999}
    local e = MobEntity:MobEntity(mob, 11)
    LuaUnit.assertEquals(e:Distance(), 9999)
end

--------------------------------------------------------------------------------
function MobEntityTests:TestTypeIsMobEntity()
    local mob = {id = 1234, index = 4321, distance = 9999}
    local e = MobEntity:MobEntity(mob, 11)
    LuaUnit.assertEquals(e:Type(), 'MobEntity')
end

LuaUnit.LuaUnit.run('MobEntityTests')