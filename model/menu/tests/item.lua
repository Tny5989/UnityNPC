local LuaUnit = require('luaunit')
local ItemMenu = require('model/menu/item')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ItemMenuTests = {}

--------------------------------------------------------------------------------
function ItemMenuTests:TestIdIsCorrect()
    local menu = ItemMenu:ItemMenu(1234, 1)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function ItemMenuTests:TestOptionForResult()
    local menu = ItemMenu:ItemMenu(1234, 1)
    LuaUnit.assertEquals(menu:OptionFor(), { option = 35, automated = true, uk1 = 0 })
end

--------------------------------------------------------------------------------
function ItemMenuTests:TestTypeIsItemMenu()
    local menu = ItemMenu:ItemMenu(1234, 1)
    LuaUnit.assertEquals(menu:Type(), 'ItemMenu')
end

LuaUnit.LuaUnit.run('ItemMenuTests')