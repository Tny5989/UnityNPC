local Packets = require('packets')

local running = false
local last = { pkt = nil, time = 0 }

--------------------------------------------------------------------------------
-- Interprets a section of data as a number.
--
-- param [in] dat_string - The data to interpret.
-- param [in] start      - The index of the first bit to interpret.
-- param [in] stop       - The index of the last bit to interpret.
--
-- Returns the interpreted number.
--
function Packets.get_bit_packed(dat_string, start, stop)
    -- Copied from Battlemod
    local newval = 0
    local c_count = math.ceil(stop/8)
    while c_count >= math.ceil((start+1)/8) do
        local cur_val = dat_string:byte(c_count)
        local scal = 256
        if c_count == math.ceil(stop/8) then
            cur_val = cur_val%(2^((stop-1)%8+1))
        end
        if c_count == math.ceil((start+1)/8) then
            cur_val = math.floor(cur_val/(2^(start%8)))
            scal = 2^(8-start%8)
        end
        newval = newval*scal + cur_val
        c_count = c_count - 1
    end
    return newval
end

--------------------------------------------------------------------------------
function Packets.start()
    running = true
    Packets._update()
end

--------------------------------------------------------------------------------
function Packets.stop()
    running = false
end

--------------------------------------------------------------------------------
function Packets._update()
    if not running then
        return
    end

    local time = os.time()
    if last.pkt and ((time - last.time) >= 5) then
        log('Resending packet')
        Packets.send(last.pkt)
    end

    coroutine.schedule(Packets._update, 1)
end

--------------------------------------------------------------------------------
function Packets.send(pkt)
    last = { pkt = pkt, time = os.time() }
    Packets.inject(pkt)
end

--------------------------------------------------------------------------------
function Packets.clear()
    last = { pkt = nil, time = 0 }
end

return Packets