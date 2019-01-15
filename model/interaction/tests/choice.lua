local LuaUnit = require('luaunit')
local Choice = require('model/interaction/choice')
local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MockEntity = NilEntity:NilEntity()
MockEntity.__index = MockEntity

--------------------------------------------------------------------------------
function MockEntity:MockEntity(id, idx, zone)
    local o = NilEntity:NilEntity()
    setmetatable(o, self)
    o._id = id
    o._index = idx
    o._zone = zone
    return o
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ChoiceTests = {}

--------------------------------------------------------------------------------
function ChoiceTests:SetUp()
    packets = {}
    function packets.new(dir, id)
        return { dir = dir, id = id }
    end

    packets.injectcount = 0
    function packets.inject()
        packets.injectcount = packets.injectcount + 1
    end
end

--------------------------------------------------------------------------------
function ChoiceTests:TestFirstPacketGroupIsChoicePacket()
    local choice = Choice:Choice()
    local target = MockEntity:MockEntity(1234, 1111, 11)
    local pkts = choice:_GeneratePackets(target, 9002, 12, true)
    LuaUnit.assertEquals(#pkts, 1)
    LuaUnit.assertEquals(pkts[1].id, 0x05B)
    LuaUnit.assertEquals(pkts[1].dir, 'outgoing')
end

--------------------------------------------------------------------------------
function ChoiceTests:TestSecondPacketGroupIsEmpty()
    local choice = Choice:Choice()
    local target = MockEntity:MockEntity(1234, 1111, 11)
    choice:_GeneratePackets(target, 9002, 12, true)
    local pkts = choice:_GeneratePackets(target, 9002, 12, true)
    LuaUnit.assertEquals(0, #pkts)
end

--------------------------------------------------------------------------------
function ChoiceTests:TestCallingInjectsPackets()
    local choice = Choice:Choice()
    local target = MockEntity:MockEntity(1234, 1111, 11)
    choice(target, 9002, 0x01, true)
    LuaUnit.assertEquals(packets.injectcount, 1)
    choice(target, 9002, 0x01, true)
    LuaUnit.assertEquals(packets.injectcount, 1)
end

--------------------------------------------------------------------------------
function ChoiceTests:TestSuccessReportedOn52()
    local choice = Choice:Choice()

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    choice:SetFailureCallback(failure)
    choice:SetSuccessCallback(success)

    choice:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function ChoiceTests:TestTypeIsChoice()
    local choice = Choice:Choice()
    LuaUnit.assertEquals(choice:Type(), 'Choice')
end

LuaUnit.LuaUnit.run('ChoiceTests')