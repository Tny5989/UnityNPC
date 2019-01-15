local LuaUnit = require('luaunit')
local Handshake = require('model/interaction/handshake')
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
HandshakeTests = {}

--------------------------------------------------------------------------------
function HandshakeTests:SetUp()
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
function HandshakeTests:TestFirstPacketGroupIsActionPacket()
    local handshake = Handshake:Handshake()
    local target = MockEntity:MockEntity(1234, 1111, 11)
    local pkts = handshake:_GeneratePackets(target)
    LuaUnit.assertEquals(1, #pkts)
    LuaUnit.assertEquals(pkts[1].id, 0x01A)
    LuaUnit.assertEquals(pkts[1].dir, 'outgoing')
end

--------------------------------------------------------------------------------
function HandshakeTests:TestSecondPacketGroupIsEmpty()
    local handshake = Handshake:Handshake()
    local target = MockEntity:MockEntity(1234, 1111, 11)
    handshake:_GeneratePackets(target)
    local pkts = handshake:_GeneratePackets(target)
    LuaUnit.assertEquals(0, #pkts)
end

--------------------------------------------------------------------------------
function HandshakeTests:TestCallingInjectsPackets()
    local handshake = Handshake:Handshake()
    local target = MockEntity:MockEntity(1234, 1111, 11)
    handshake(target)
    LuaUnit.assertEquals(packets.injectcount, 1)
    handshake(target)
    LuaUnit.assertEquals(packets.injectcount, 1)
end

--------------------------------------------------------------------------------
function HandshakeTests:TestFailureReportedOn52()
    local handshake = Handshake:Handshake()

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    handshake:SetFailureCallback(failure)
    handshake:SetSuccessCallback(success)

    handshake:OnIncomingData(0x052, {})
    LuaUnit.assertEquals(fc, 1)
    LuaUnit.assertEquals(sc, 0)
end

--------------------------------------------------------------------------------
function HandshakeTests:TestSuccessReportedOn34()
    local handshake = Handshake:Handshake()

    local fc = 0
    function failure()
        fc = fc + 1
    end

    local sc = 0
    function success()
        sc = sc + 1
    end

    handshake:SetFailureCallback(failure)
    handshake:SetSuccessCallback(success)

    handshake:OnIncomingData(0x034, {})
    LuaUnit.assertEquals(sc, 1)
    LuaUnit.assertEquals(fc, 0)
end

--------------------------------------------------------------------------------
function HandshakeTests:TestTypeIsHandshake()
    local handshake = Handshake:Handshake()
    LuaUnit.assertEquals(handshake:Type(), 'Handshake')
end

LuaUnit.LuaUnit.run('HandshakeTests')