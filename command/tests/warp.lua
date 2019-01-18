local LuaUnit = require('luaunit')
local WarpCommand = require('command/warp')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
WarpCommandTests = {}

--------------------------------------------------------------------------------
function WarpCommandTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return { id = id, index = 4321, distance = 9999, valid_target = true }
    end

    function log()
    end
end

--------------------------------------------------------------------------------
function WarpCommandTests:TestSuccessCallbackCalled()
    local sc = 0
    function success()
        sc = sc + 1
    end

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local c = WarpCommand:WarpCommand() -- Don't pass parameters to force a NilDialogue to be created.
    c:SetSuccessCallback(success)
    c:SetFailureCallback(failure)
    c()

    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function WarpCommandTests:TestTypeIsWarpCommand()
    local c = WarpCommand:WarpCommand()
    LuaUnit.assertEquals(c:Type(), 'WarpCommand')
end

LuaUnit.LuaUnit.run('WarpCommandTests')