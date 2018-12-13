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
local Npcs = {}

Npcs.Values = {}
Npcs.Values['']       = { id = 00000000, en = '',                  zone = 000 }

-- Bastok Markets
Npcs.Values[17739961] = { id = 17739961, en = 'Igsli', zone = 235 }

--------------------------------------------------------------------------------
function Npcs.GetByProperty(key, value)
    return ByValue(tostring(key), value, Npcs.Values)
end

--------------------------------------------------------------------------------
function Npcs.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Npcs.Values)
end

return Npcs
