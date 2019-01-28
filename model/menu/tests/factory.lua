local LuaUnit = require('luaunit')
local MenuFactory = require('model/menu/factory')
local BuyMenu = require('model/menu/buy')
local CountMenu = require('model/menu/count')
local ItemMenu = require('model/menu/item')
local SimpleMenu = require('model/menu/simple')
local ActionMenu = require('model/menu/action')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
MenuFactoryTests = {}

--------------------------------------------------------------------------------
function MenuFactoryTests:SetUp()
    packets = {}
    function packets.parse()
        return { ['Menu ID'] = 1 }
    end
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadPacket()
    local menu = MenuFactory.CreateWarpMenu()
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenNoPacketLib()
    packets = nil
    local menu = MenuFactory.CreateWarpMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadParse()
    function packets.parse(dir, data)
        return nil
    end

    local menu = MenuFactory.CreateWarpMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadMenuId()
    function packets.parse(dir, data)
        return { ['Menu ID'] = 0 }
    end

    local menu = MenuFactory.CreateWarpMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestSimpleMenuCreatedWhenAllGood()
    function packets.parse(dir, data)
        return { ['Menu ID'] = 1 }
    end

    local menu = MenuFactory.CreateWarpMenu({})
    LuaUnit.assertEquals(menu:Type(), 'SimpleMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadPacket_Extra()
    local menu = MenuFactory.CreateExtraMenu(nil, SimpleMenu:SimpleMenu(), 0)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadMenu_Extra()
    local menu = MenuFactory.CreateExtraMenu({}, nil, 0)
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadIndex_Extra()
    local menu = MenuFactory.CreateExtraMenu({}, ActionMenu:ActionMenu(), nil)
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

    local menu = MenuFactory.CreateExtraMenu({}, ActionMenu:ActionMenu(), 0)
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

--------------------------------------------------------------------------------
function MenuFactoryTests:TestItemMenuCreatedWhenLastMenuWasBuy()
    function packets.parse(_, _)
        return {}
    end

    local menu = MenuFactory.CreateExtraMenu({}, BuyMenu:BuyMenu(), 0, 0, 'normal')
    LuaUnit.assertEquals(menu:Type(), 'ItemMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestCountMenuCreatedWhenLastMenuWasItem()
    function packets.parse(_, _)
        return {}
    end

    local menu = MenuFactory.CreateExtraMenu({}, ItemMenu:ItemMenu(0, 0), 0, 0, 'normal')
    LuaUnit.assertEquals(menu:Type(), 'CountMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenLastMenuWasCount()
    function packets.parse(_, _)
        return {}
    end

    local menu = MenuFactory.CreateExtraMenu({}, CountMenu:CountMenu(0, 0, 0), 0, 0, 'normal')
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestCountMenuCreatedWhenLastMenuWasBuyAndTypeIsSpecial()
    function packets.parse(_, _)
        return {}
    end

    local menu = MenuFactory.CreateExtraMenu({}, BuyMenu:BuyMenu(0), 0, 0, 'special')
    LuaUnit.assertEquals(menu:Type(), 'CountMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenTypeIsUnknown()
    function packets.parse(_, _)
        return {}
    end

    local menu = MenuFactory.CreateExtraMenu({}, BuyMenu:BuyMenu(0), 0, 0, 'unknown')
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadPacket_Buy()
    local menu = MenuFactory.CreateBuyMenu()
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenNoPacketLib_Buy()
    packets = nil
    local menu = MenuFactory.CreateBuyMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadParse_Buy()
    function packets.parse(dir, data)
        return nil
    end

    local menu = MenuFactory.CreateBuyMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestNilMenuCreatedWhenBadMenuId_Buy()
    function packets.parse(dir, data)
        return { ['Menu ID'] = 0 }
    end

    local menu = MenuFactory.CreateBuyMenu({})
    LuaUnit.assertEquals(menu:Type(), 'NilMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestSimpleMenuCreatedWhenAllGood_Buy()
    function packets.parse(dir, data)
        return { ['Menu ID'] = 1 }
    end

    local menu = MenuFactory.CreateBuyMenu({})
    LuaUnit.assertEquals(menu:Type(), 'SimpleMenu')
end

--------------------------------------------------------------------------------
function MenuFactoryTests:TestBuyMenuCreatedWhenAllGood_Buy()
    function packets.parse(dir, data)
        return { ['Menu ID'] = 1, ['Menu Parameters'] = '' }
    end

    local menu = MenuFactory.CreateBuyMenu({})
    LuaUnit.assertEquals(menu:Type(), 'BuyMenu')
end

LuaUnit.LuaUnit.run('MenuFactoryTests')
