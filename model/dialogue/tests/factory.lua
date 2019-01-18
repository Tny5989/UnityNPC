local LuaUnit = require('luaunit')
local DialogueFactory = require('model/dialogue/factory')
local EntityFactory = require('model/entity/factory')
local NilInventory = require('model/inventory/nil')
local PlayerInventory = require('model/inventory/player')
local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MockEntity = NilEntity:NilEntity()
MockEntity.__index = MockEntity

--------------------------------------------------------------------------------
function MockEntity:MockEntity(id, idx, distance, bag)
    local o = NilEntity:NilEntity()
    setmetatable(o, self)
    o._id = id
    o._index = idx
    o._distance = distance
    o._bag = bag
    o._type = 'MockEntity'
    return o
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
DialogueFactoryTests = {}

--------------------------------------------------------------------------------
function DialogueFactoryTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 5, valid_target = true }
    end

    function windower.ffxi.get_info()
        return { zone = 11 }
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 20

    function log()
    end
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadNpc()
    local dialogue = DialogueFactory.CreateWarpDialogue(nil, 2)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilNpc()
    local dialogue = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(), 2)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadZone()
    local dialogue = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), nil)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNegativeZone()
    local dialogue = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), -1)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadEntity()
    function windower.ffxi.get_mob_by_id(_)
        return nil
    end

    local key = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), 2)
    LuaUnit.assertEquals(key:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenFarAway()
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 2000, valid_target = true }
    end

    local key = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), 2)
    LuaUnit.assertEquals(key:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestWarpDialogueCreatedWhenValidParams()
    local dialogue = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), 2)
    LuaUnit.assertEquals(dialogue:Type(), 'WarpDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadNpc_Buy()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local bag = PlayerInventory:PlayerInventory(items)
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(nil, entity, 2, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadPlayer_Buy()
    local bag = NilInventory:NilInventory()
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(entity, nil, 2, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilNpc_Buy()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local bag = PlayerInventory:PlayerInventory(items)
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(NilEntity:NilEntity(), entity, 2, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilPlayer_Buy()
    local bag = NilInventory:NilInventory()
    local entity = MockEntity:MockEntity(1234, 4321, 0, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(entity, NilEntity:NilEntity(), 2, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenFarAway_Buy()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 30, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(mob, player, 2, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadItemId_Buy()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(mob, player, nil, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadItemCount_Buy()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(mob, player, 2)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenFullInventory_Buy()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 2 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(mob, player, 2, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestBuyDialogueCreatedWhenValidParams()
    local items = { { id = 2, index = 1 , count = 1 }, max = 2, count = 1 }
    local pbag = PlayerInventory:PlayerInventory(items)
    local player = MockEntity:MockEntity(1234, 4321, 0, pbag)
    local bag = NilInventory:NilInventory()
    local mob = MockEntity:MockEntity(1234, 4321, 5, bag)
    local dialogue = DialogueFactory.CreateBuyDialogue(mob, player, 2, 6)
    LuaUnit.assertEquals(dialogue:Type(), 'BuyDialogue')
end

LuaUnit.LuaUnit.run('DialogueFactoryTests')