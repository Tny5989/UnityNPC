local LuaUnit = require('luaunit')
local NilDialogue = require('model/dialogue/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilDialogueTests = {}

--------------------------------------------------------------------------------
function NilDialogueTests:TestSuccessCallbackOnStart()
    local dialogue = NilDialogue:NilDialogue()

    local sc = 0
    function success()
        sc = sc + 1
    end

    local fc = 0
    function failure()
        fc = fc + 1
    end

    dialogue:SetSuccessCallback(success)
    dialogue:SetFailureCallback(failure)
    dialogue:Start()
    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function NilDialogueTests:TestCallbackOnlyCalledOnce()
    local dialogue = NilDialogue:NilDialogue()

    local sc = 0
    function success()
        sc = sc + 1
    end

    dialogue:SetSuccessCallback(success)
    dialogue:Start()
    dialogue:Start()
    dialogue:Start()
    LuaUnit.assertEquals(sc, 1)
end

--------------------------------------------------------------------------------
function NilDialogueTests:TestOnIncomingDataAlwaysReturnsFalse()
    local dialogue = NilDialogue:NilDialogue()
    LuaUnit.assertFalse(dialogue:OnIncomingData(0x052, {}));
end

--------------------------------------------------------------------------------
function NilDialogueTests:TestTargetTypeIsNilNpc()
    local dialogue = NilDialogue:NilDialogue()
    LuaUnit.assertEquals(dialogue:Target():Type(), 'NilNpc')
end

--------------------------------------------------------------------------------
function NilDialogueTests:TestTypeIsNilDialogue()
    local dialogue = NilDialogue:NilDialogue()
    LuaUnit.assertEquals(dialogue:Type(), 'NilDialogue')
end

LuaUnit.LuaUnit.run('NilDialogueTests')