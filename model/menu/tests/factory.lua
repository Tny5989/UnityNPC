local LuaUnit = require('luaunit')
local MenuFactory = require('model/menu/factory')
local SimpleMenu = require('model/menu/simple')
local ActionMenu = require('model/menu/action')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
MenuFactoryTests = {}

--------------------------------------------------------------------------------
function MenuFactoryTests:SetUp()
    packets = {}
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadPacket()
    local menu = MenuFactory.CreateMenu()
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenNoPacketLib()
    packets = nil
    local menu = MenuFactory.CreateMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadParse()
    function packets.parse(dir, data)
        return nil
    end

    local menu = MenuFactory.CreateMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadMenuId()
    function packets.parse(dir, data)
        return { ['Menu ID'] = 0 }
    end

    local menu = MenuFactory.CreateMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestSimpleMenuCreatedWhenAllGood()
    function packets.parse(dir, data)
        return { ['Menu ID'] = 1 }
    end

    local menu = MenuFactory.CreateMenu({})
    LuaUnit.assertEquals(menu:Type(), 'SimpleMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadPacket_Extra()
    local menu = MenuFactory.CreateExtraMenu(nil, {}, 0)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadMenu_Extra()
    local menu = MenuFactory.CreateExtraMenu({}, nil, 0)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadIndex_Extra()
    local menu = MenuFactory.CreateExtraMenu({}, {}, nil)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenNoPacketLib_Extra()
    packets = nil
    local menu = MenuFactory.CreateExtraMenu({}, {}, 0)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenUnableToParsePacket_Extra()
    function packets.parse(_, _)
        return nil
    end

    local menu = MenuFactory.CreateExtraMenu({}, {}, 0)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestActionMenuCreatedWhenLastMenuWasSimple()
    function packets.parse(_, _)
        return {}
    end

    local menu = MenuFactory.CreateExtraMenu({}, SimpleMenu:SimpleMenu(), 0)
    LuaUnit.assertEquals(menu:Type(), 'ActionMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestWarpMenuCreatedWhenLastMenuWasAction()
    function packets.parse(_, _)
        return {}
    end

    local menu = MenuFactory.CreateExtraMenu({}, ActionMenu:ActionMenu(), 0)
    LuaUnit.assertEquals(menu:Type(), 'WarpMenu')
end

LuaUnit.LuaUnit.run('MenuFactoryTests')
