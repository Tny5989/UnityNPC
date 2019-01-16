local LuaUnit = require('luaunit')
local PlayerEntity = require('model/entity/player')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PlayerEntityTests = {}

--------------------------------------------------------------------------------
function PlayerEntityTests:TestEntityIdIsCorrect()
    local player = {id = 1234, index = 4321, distance = 9999}
    local e = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(e:Id(), 1234)
end

--------------------------------------------------------------------------------
function PlayerEntityTests:TestEntityIndexIsCorrect()
    local player = {id = 1234, index = 4321, distance = 9999}
    local e = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(e:Index(), 4321)
end

--------------------------------------------------------------------------------
function PlayerEntityTests:TestDistanceIsZero()
    local player = {id = 1234, index = 4321, distance = 9999}
    local e = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(e:Distance(), 0)
end

--------------------------------------------------------------------------------
function PlayerEntityTests:TestTypeIsPlayerEntity()
    local player = {id = 1234, index = 4321, distance = 9999}
    local e = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(e:Type(), 'PlayerEntity')
end

--------------------------------------------------------------------------------
function PlayerEntityTests:TestBagTypeIsPlayerBag()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_items()
        return {max = 0, count = 0}
    end

    local player = {id = 1234, index = 4321, distance = 9999}
    local e = PlayerEntity:PlayerEntity(player)
    LuaUnit.assertEquals(e:Bag():Type(), 'PlayerInventory')
end

LuaUnit.LuaUnit.run('PlayerEntityTests')