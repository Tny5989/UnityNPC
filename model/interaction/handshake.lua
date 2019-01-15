local NilInteraction = require('model/interaction/nil')

--------------------------------------------------------------------------------
local function CreateActionPacket(target)
    local pkt = packets.new('outgoing', 0x01A)
    pkt['Target'] = target:Id()
    pkt['Target Index'] = target:Index()
    return pkt
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Handshake = NilInteraction:NilInteraction()
Handshake.__index = Handshake

--------------------------------------------------------------------------------
function Handshake:Handshake()
    local o = NilInteraction:NilInteraction()
    setmetatable(o, self)
    o._to_send = { [1] = function(target) return {CreateActionPacket(target)} end }
    o._idx = 1
    o._type = 'Handshake'

    setmetatable(o._to_send,
        { __index = function() return function() return {} end end })
    return o
end

--------------------------------------------------------------------------------
function Handshake:OnIncomingData(id, _)
    if id == 0x052 then
        self._on_failure()
        self._on_failure = function() end
        self._on_success = function() end
        return true
    elseif id == 0x034 or id == 0x032 then
        self._on_success()
        self._on_success = function() end
        self._on_failure = function() end
        return true
    else
        return false
    end
end

--------------------------------------------------------------------------------
function Handshake:_GeneratePackets(target)
    local pkts = self._to_send[self._idx](target)
    self._idx = self._idx + 1
    return pkts
end

--------------------------------------------------------------------------------
function Handshake:__call(target)
    local pkts = self:_GeneratePackets(target)
    for _, pkt in pairs(pkts) do
        packets.inject(pkt)
    end
end

return Handshake
