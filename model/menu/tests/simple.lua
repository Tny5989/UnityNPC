local LuaUnit = require('luaunit')
local SimpleMenu = require('model/menu/simple')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
SimpleMenuTests = {}

--------------------------------------------------------------------------------
function SimpleMenuTests:TestIdIsCorrect()
    local menu = SimpleMenu:SimpleMenu(1234, 1, false, 1)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function SimpleMenuTests:TestOptionForResult()
    local menu = SimpleMenu:SimpleMenu(1234, 1, false, 1)
    LuaUnit.assertEquals(menu:OptionFor(),
        { option = 1, automated = false, uk1 = 1 })
end

--------------------------------------------------------------------------------
function SimpleMenuTests:TestTypeIsSimpleMenu()
    local menu = SimpleMenu:SimpleMenu(1234, 1, false, 1)
    LuaUnit.assertEquals(menu:Type(), 'SimpleMenu')
end

LuaUnit.LuaUnit.run('SimpleMenuTests')