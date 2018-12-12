local LuaUnit = require('luaunit')
local MenuFactory = require('model/menu/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
MenuFactoryTests = {}

--------------------------------------------------------------------------------
function MenuFactoryTests:SetUp()
    packets = {}
    function packets.get_bit_packed()
        return 0
    end
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreated()
    local menu = MenuFactory.CreateSimpleMenu()
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

LuaUnit.LuaUnit.run('MenuFactoryTests')
