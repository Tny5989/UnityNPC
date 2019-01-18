local LuaUnit = require('luaunit')
local NilInventory = require('model/inventory/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
NilInventoryTests = {}

--------------------------------------------------------------------------------
function NilInventoryTests:TestDefaultFreeSpaceIsZero()
    local b = NilInventory:NilInventory()
    LuaUnit.assertEquals(b:FreeSlots(), 0)
end

--------------------------------------------------------------------------------
function NilInventoryTests:TestItemCountIsZero()
    local b = NilInventory:NilInventory()
    LuaUnit.assertEquals(b:ItemCount(), 0)
    LuaUnit.assertEquals(b:ItemCount(0), 0)
    LuaUnit.assertEquals(b:ItemCount(8973), 0)
end

--------------------------------------------------------------------------------
function NilInventoryTests:TestItemIndexIsInvalid()
    local b = NilInventory:NilInventory()
    LuaUnit.assertEquals(b:ItemIndex(), NilInventory.INVALID_INDEX)
    LuaUnit.assertEquals(b:ItemIndex(0), NilInventory.INVALID_INDEX)
    LuaUnit.assertEquals(b:ItemIndex(8973), NilInventory.INVALID_INDEX)
end

--------------------------------------------------------------------------------
function NilInventoryTests:TestTypeIsNilInventory()
    local b = NilInventory:NilInventory()
    LuaUnit.assertEquals(b:Type(), 'NilInventory')
end

LuaUnit.LuaUnit.run('NilInventoryTests')