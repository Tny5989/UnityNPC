local LuaUnit = require('luaunit')
local WarpDialogue = require('model/dialogue/warp')
local EntityNpc = require('model/npc/entity')
local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MockEntity = NilEntity:NilEntity()
MockEntity.__index = MockEntity

--------------------------------------------------------------------------------
function MockEntity:MockEntity(id, idx)
    local o = NilEntity:NilEntity()
    setmetatable(o, self)
    o._id = id
    o._index = idx
    return o
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
WarpDialogueTests = {}

--------------------------------------------------------------------------------
function WarpDialogueTests:SetUp()
    packets = {}
    function packets.new(dir, id)
        return { dir = dir, id = id }
    end

    packets.injected = {}
    function packets.inject(pkt)
        table.insert(packets.injected, pkt)
    end

    function packets.parse(dir, data)
        return {}
    end
end

--------------------------------------------------------------------------------
function WarpDialogueTests:TestPacketsSent()
    local npc = EntityNpc:EntityNpc(1234, 1, MockEntity:MockEntity(1234, 4))
    local dialogue = WarpDialogue:WarpDialogue(npc, 2)

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    dialogue:SetSuccessCallback(success)
    dialogue:SetFailureCallback(failure)

    dialogue:Start()
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x01A)

    packets.injected = {}
    dialogue:OnIncomingData(0x034, {})
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x05B)

    packets.injected = {}
    dialogue:OnIncomingData(0x05C, {})
    dialogue:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x05B)

    packets.injected = {}
    dialogue:OnIncomingData(0x05C, {})
    dialogue:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x05B)

    packets.injected = {}
    dialogue:OnIncomingData(0x00B, {})
    LuaUnit.assertEquals(#packets.injected, 0)

    LuaUnit.assertEquals(fc, 0)
    LuaUnit.assertEquals(sc, 1)
end

--------------------------------------------------------------------------------
function WarpDialogueTests:TestDialogueFailsOnEarly52()
    local npc = EntityNpc:EntityNpc(1234, 1, MockEntity:MockEntity(1234, 4))
    local dialogue = WarpDialogue:WarpDialogue(npc)

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    dialogue:SetSuccessCallback(success)
    dialogue:SetFailureCallback(failure)

    dialogue:Start()
    LuaUnit.assertEquals(#packets.injected, 1)
    LuaUnit.assertEquals(packets.injected[1].id, 0x01A)

    packets.injected = {}
    dialogue:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(#packets.injected, 0)

    LuaUnit.assertEquals(fc, 1)
    LuaUnit.assertEquals(sc, 0)
end

--------------------------------------------------------------------------------
function WarpDialogueTests:TestTypeIsWarpDialogue()
    local dialogue = WarpDialogue:WarpDialogue()
    LuaUnit.assertEquals(dialogue:Type(), 'WarpDialogue')
end

LuaUnit.LuaUnit.run('WarpDialogueTests')