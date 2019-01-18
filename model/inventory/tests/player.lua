local LuaUnit = require('luaunit')
local PlayerInventory = require('model/inventory/player')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
PlayerInventoryTests = {}

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestFreeSpaceIsCorrectWhenSlotsFree()
    local items = {max = 2, count = 1}
    local b = PlayerInventory:PlayerInventory(items)
    LuaUnit.assertEquals(b:FreeSlots(), 1)
end

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestFreeSpaceIsCorrectWhenFull()
    local items = {max = 1, count = 1}
    local b = PlayerInventory:PlayerInventory(items)
    LuaUnit.assertEquals(b:FreeSlots(), 0)
end

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestItemCountIsZeroWhenNoItems()
    local items = {max = 1, count = 1}
    local b = PlayerInventory:PlayerInventory(items)
    LuaUnit.assertEquals(b:ItemCount(0), 0)
end

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestItemCountIsAccurateWhenLtOneStack()
    local items = {max = 1, count = 1, [1] = {id = 1, count = 12}}
    local b = PlayerInventory:PlayerInventory(items)
    LuaUnit.assertEquals(b:ItemCount(1), 12)
end

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestItemCountIsAccurateWhenMultipleStacks()
    local items = {max = 3, count = 3, [1] = {id = 1, count = 12}, [2] = {id = 1, count = 8}, [3] = {id = 2, count = 4}}
    local b = PlayerInventory:PlayerInventory(items)
    LuaUnit.assertEquals(b:ItemCount(1), 20)
end

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestItemIndexIsInvalidWhenNoItems()
    local items = {max = 1, count = 1}
    local b = PlayerInventory:PlayerInventory(items)
    LuaUnit.assertEquals(b:ItemIndex(0), PlayerInventory.INVALID_INDEX)
end

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestItemIndexIsIndexOfFirstStackFound()
    local items = {max = 10, count = 3, [1] = {id = 1, count = 2}, [2] = {id = 2, count = 4}}
    local b = PlayerInventory:PlayerInventory(items)
    LuaUnit.assertEquals(b:ItemIndex(1), 1)
end

--------------------------------------------------------------------------------
function PlayerInventoryTests:TestTypeIsNilInventory()
    local b = PlayerInventory:PlayerInventory()
    LuaUnit.assertEquals(b:Type(), 'PlayerInventory')
end

LuaUnit.LuaUnit.run('PlayerInventoryTests')