--------------------------------------------------------------------------------
local function ByValue(name, search_value, domain)
    for _, value in pairs(domain) do
        if value[name] == search_value then
            return value
        end
    end

    return domain['']
end

--------------------------------------------------------------------------------
local function AllByValue(name, search_value, domain)
    local matches = {}
    for _, value in pairs(domain) do
        if value[name] == search_value then
            table.insert(matches, value)
        end
    end

    table.insert(matches, domain[''])
    return matches
end

--------------------------------------------------------------------------------
local Warps = {}

Warps.Values = {}
Warps.Values[''] = { zone = 000, idx = 000 }

-- East Ronfaure
Warps.Values[101] = { zone = 101, idx = 000 }
-- South Gustaberg
Warps.Values[107] = { zone = 107, idx = 002 }
-- East Sarutabaruta
Warps.Values[116] = { zone = 116, idx = 004 }
-- La Theine Plateau
Warps.Values[102] = { zone = 102, idx = 006 }
-- Konschtat Highlands
Warps.Values[108] = { zone = 108, idx = 008 }
-- Tahrongi Canyon
Warps.Values[117] = { zone = 117, idx = 010 }

--------------------------------------------------------------------------------
function Warps.GetByProperty(key, value)
    return ByValue(tostring(key), value, Warps.Values)
end

--------------------------------------------------------------------------------
function Warps.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Warps.Values)
end

return Warps
