local LuaUnit = require('luaunit')
local NilMenu = require('model/menu/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilMenuTests = {}

--------------------------------------------------------------------------------
function NilMenuTests:TestIdIsCorrect()
    local menu = NilMenu:NilMenu(0)
    LuaUnit.assertEquals(menu:Id(), 0)
end

--------------------------------------------------------------------------------
function NilMenuTests:TestOptionForReturn()
    local menu = NilMenu:NilMenu(0)
    LuaUnit.assertEquals(menu:OptionFor(),
        { option = 0, automated = false, uk1 = 0 })
end

--------------------------------------------------------------------------------
function NilMenuTests:TestTypeIsNilMenu()
    local menu = NilMenu:NilMenu(0)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

LuaUnit.LuaUnit.run('NilMenuTests')