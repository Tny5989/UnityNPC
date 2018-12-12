local LuaUnit = require('luaunit')
local NilInteraction = require('model/interaction/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilInteractionTests = {}

--------------------------------------------------------------------------------
function NilInteractionTests:TestTypeIsNilInteraction()
    local interaction = NilInteraction:NilInteraction()
    LuaUnit.assertEquals(interaction:Type(), 'NilInteraction')
end

--------------------------------------------------------------------------------
function NilInteractionTests:TestCallHasNoWindowerDependency()
    local interaction = NilInteraction:NilInteraction()
    windower = nil
    interaction()
end

--------------------------------------------------------------------------------
function NilInteractionTests:TestSuccessCallbackCalled()
    local interaction = NilInteraction:NilInteraction()
    local count = 0
    function callback()
        count = count + 1
    end
    interaction:SetSuccessCallback(callback)
    interaction()
    LuaUnit.assertEquals(count, 1)
end

--------------------------------------------------------------------------------
function NilInteractionTests:TestOnIncomingDataReturnsFalse()
    local interaction = NilInteraction:NilInteraction()
    LuaUnit.assertFalse(interaction:OnIncomingData(0x052, {}))
end

--------------------------------------------------------------------------------
function NilInteractionTests:TestFailureCallbackIsNeverCalled()
    local interaction = NilInteraction:NilInteraction()
    local count = 0
    function callback()
        count = count + 1
    end
    interaction:SetFailureCallback(callback)
    interaction()
    LuaUnit.assertEquals(count, 0)
end

LuaUnit.LuaUnit.run('NilInteractionTests')