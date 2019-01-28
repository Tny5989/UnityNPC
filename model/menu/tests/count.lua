local LuaUnit = require('luaunit')
local CountMenu = require('model/menu/count')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CountMenuTests = {}

--------------------------------------------------------------------------------
function CountMenuTests:TestIdIsCorrect()
    local menu = CountMenu:CountMenu(1234, 1, 6, 4)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function CountMenuTests:TestOptionForResult()
    local menu = CountMenu:CountMenu(1234, 12, 11, 4)
    LuaUnit.assertEquals(menu:OptionFor(), { option = 24964, automated = true, uk1 = 1 })
end

--------------------------------------------------------------------------------
function CountMenuTests:TestTypeIsCountMenu()
    local menu = CountMenu:CountMenu(1234, 1, 6, 4)
    LuaUnit.assertEquals(menu:Type(), 'CountMenu')
end

LuaUnit.LuaUnit.run('CountMenuTests')