local LuaUnit = require('luaunit')
local SimpleMenu = require('model/menu/simple')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
SimpleMenuTests = {}

--------------------------------------------------------------------------------
function SimpleMenuTests:TestIdIsCorrect()
    local menu = SimpleMenu:SimpleMenu(1234, 1, false)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function SimpleMenuTests:TestOptionForResult()
    local menu = SimpleMenu:SimpleMenu(1234, 1, false)
    LuaUnit.assertEquals(menu:OptionFor(), { option = 1, automated = false })
end

--------------------------------------------------------------------------------
function SimpleMenuTests:TestTypeIsSimpleMenu()
    local menu = SimpleMenu:SimpleMenu(1234, 1, false)
    LuaUnit.assertEquals(menu:Type(), 'SimpleMenu')
end

LuaUnit.LuaUnit.run('SimpleMenuTests')