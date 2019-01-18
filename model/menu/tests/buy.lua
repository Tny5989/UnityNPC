local LuaUnit = require('luaunit')
local BuyMenu = require('model/menu/buy')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
BuyMenuTests = {}

--------------------------------------------------------------------------------
function BuyMenuTests:TestIdIsCorrect()
    local menu = BuyMenu:BuyMenu(1234)
    LuaUnit.assertEquals(menu:Id(), 1234)
end

--------------------------------------------------------------------------------
function BuyMenuTests:TestOptionForResult()
    local menu = BuyMenu:BuyMenu(1234)
    LuaUnit.assertEquals(menu:OptionFor(), { option = 10, automated = true, uk1 = 0 })
end

--------------------------------------------------------------------------------
function BuyMenuTests:TestTypeIsBuyMenu()
    local menu = BuyMenu:BuyMenu(1234)
    LuaUnit.assertEquals(menu:Type(), 'BuyMenu')
end

LuaUnit.LuaUnit.run('BuyMenuTests')