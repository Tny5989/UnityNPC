local NilInteraction = require('model/interaction/nil')

--------------------------------------------------------------------------------
local function CreateChoicePacket(target, menu, choice, automated)
    local pkt = packets.new('outgoing', 0x05B)
    pkt['Target'] = target:Id()
    pkt['Target Index'] = target:Entity():Index()
    pkt['Option Index'] = choice
    pkt['Automated Message'] = automated
    pkt['Zone'] = target:Zone()
    pkt['Menu ID'] = menu
    return pkt
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Choice = NilInteraction:NilInteraction()
Choice.__index = Choice

--------------------------------------------------------------------------------
function Choice:Choice()
    local o = NilInteraction:NilInteraction()
    setmetatable(o, self)
    o._to_send = { [1] = function(target, menu, choice, automated) return {CreateChoicePacket(target, menu, choice, automated)} end }
    o._idx = 1
    o._type = 'Choice'

    setmetatable(o._to_send,
        { __index = function() return function() return {} end end })

    return o
end

--------------------------------------------------------------------------------
function Choice:OnIncomingData(id, pkt)
    -- TODO failure condition? 0x052 with 5th byte set differently?
    if id == 0x052 then
        self._on_success()
        self._on_success = function() end
        self._on_failure = function() end
        return true
    else
        return false
    end
end

--------------------------------------------------------------------------------
function Choice:_GeneratePackets(target, menu, choice, automated)
    local pkts = self._to_send[self._idx](target, menu, choice, automated)
    self._idx = self._idx + 1
    return pkts
end

--------------------------------------------------------------------------------
function Choice:__call(target, menu, choice, automated)
    local pkts = self:_GeneratePackets(target, menu, choice, automated)
    for _, pkt in pairs(pkts) do
        packets.inject(pkt)
    end
end

return Choice
