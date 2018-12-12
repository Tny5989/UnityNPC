local LuaUnit = require('luaunit')
local NilCommand = require('command/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilCommandTests = {}

--------------------------------------------------------------------------------
function NilCommandTests:TestOnIncomingDataReturnFalse()
    local c = NilCommand:NilCommand()
    LuaUnit.assertFalse(c:OnIncomingData(0x052, {}))
end

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandWindowerRequirement()
    windower = nil
    NilCommand:NilCommand()()
end

--------------------------------------------------------------------------------
function NilCommandTests:TestNilCommandSettingsRequirement()
    settings = nil
    NilCommand:NilCommand()()
end

--------------------------------------------------------------------------------
function NilCommandTests:TestSuccessCallbackCalled()
    local sc = 0
    function success()
        sc = sc + 1
    end

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local c = NilCommand:NilCommand()
    c:SetSuccessCallback(success)
    c:SetFailureCallback(failure)
    c()

    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function NilCommandTests:TestSuccessCallbackOnlyCalledOnce()
    local sc = 0
    function success()
        sc = sc + 1
    end

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local c = NilCommand:NilCommand()
    c:SetSuccessCallback(success)
    c:SetFailureCallback(failure)
    c()
    c()
    c()

    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function NilCommandTests:TestTypeIsNilCommand()
    local c = NilCommand:NilCommand()
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

LuaUnit.LuaUnit.run('NilCommandTests')