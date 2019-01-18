local LuaUnit = require('luaunit')
local InventoryFactory = require('model/inventory/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
InventoryFactoryTests = {}

--------------------------------------------------------------------------------
function InventoryFactoryTests:TestNilInventoryCreatedWhenBadNumPassed()
    local b = InventoryFactory.CreateInventory(nil)
    LuaUnit.assertEquals(b:Type(), 'NilInventory')
end

--------------------------------------------------------------------------------
function InventoryFactoryTests:TestNilInventoryCreatedWhenUnableToObtainInventory()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_items()
        return nil
    end

    local b = InventoryFactory.CreateInventory(0)
    LuaUnit.assertEquals(b:Type(), 'NilInventory')
end

--------------------------------------------------------------------------------
function InventoryFactoryTests:TestPlayerInventoryCreatedWhenInventoryObtained()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_items()
        return {max = 0, count = 0}
    end

    local b = InventoryFactory.CreateInventory(0)
    LuaUnit.assertEquals(b:Type(), 'PlayerInventory')
end

LuaUnit.LuaUnit.run('InventoryFactoryTests')