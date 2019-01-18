local LuaUnit = require('luaunit')
local ActionMenu = require('model/menu/action')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ActionMenuTests = {}

--------------------------------------------------------------------------------
function ActionMenuTests:TestIdIsCorrect()
    local menu = ActionMenu:ActionMenu(1234)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function ActionMenuTests:TestOptionForResult()
    local menu = ActionMenu:ActionMenu(1234)
    LuaUnit.assertEquals(menu:OptionFor(), { option = 7, automated = true, uk1 = 0 })
end

--------------------------------------------------------------------------------
function ActionMenuTests:TestTypeIsActionMenu()
    local menu = ActionMenu:ActionMenu(1234)
    LuaUnit.assertEquals(menu:Type(), 'ActionMenu')
end

LuaUnit.LuaUnit.run('ActionMenuTests')