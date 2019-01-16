local LuaUnit = require('luaunit')
local DialogueFactory = require('model/dialogue/factory')
local EntityFactory = require('model/entity/factory')

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
    local npc = DialogueFactory.CreateWarpDialogue(nil, 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNilNpc()
    local npc = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(), 2)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenBadZone()
    local npc = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), nil)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
end

--------------------------------------------------------------------------------
function DialogueFactoryTests:TestNilDialogueCreatedWhenNegativeZone()
    local npc = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), -1)
    LuaUnit.assertEquals(npc:Type(), 'NilDialogue')
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
    local npc = DialogueFactory.CreateWarpDialogue(EntityFactory.CreateMob(1234), 2)
    LuaUnit.assertEquals(npc:Type(), 'WarpDialogue')
end

LuaUnit.LuaUnit.run('DialogueFactoryTests')