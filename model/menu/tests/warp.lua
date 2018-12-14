local LuaUnit = require('luaunit')
local WarpMenu = require('model/menu/warp')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
WarpMenuTests = {}

--------------------------------------------------------------------------------
function WarpMenuTests:TestIdIsCorrect()
    local menu = WarpMenu:WarpMenu(1234, {})
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function WarpMenuTests:TestOptionForUnknownWarp()
    local menu = WarpMenu:WarpMenu(1234, {})
    LuaUnit.assertEquals(menu:OptionFor('a'), { option = 0, automated = false })
end

--------------------------------------------------------------------------------
function WarpMenuTests:TestOptionForKnownWarp()
    local menu = WarpMenu:WarpMenu(1234, { 1, 2 })
    LuaUnit.assertEquals(menu:OptionFor(1),
        { option = 1 * (2^4) + 1, automated = true })
    LuaUnit.assertEquals(menu:OptionFor(2),
        { option = 2 * (2^4) + 1, automated = true })
end

--------------------------------------------------------------------------------
function WarpMenuTests:TestTypeIsWarpMenu()
    local menu = WarpMenu:WarpMenu(1234, {})
    LuaUnit.assertEquals(menu:Type(), 'WarpMenu')
end

LuaUnit.LuaUnit.run('WarpMenuTests')