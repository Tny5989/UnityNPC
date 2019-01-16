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
Npcs.Values['']       = { id = 00000000, en = '',                 zone = 000 }

Npcs.Values[17739961] = { id = 17739961, en = 'Igsli',            zone = 235 }
Npcs.Values[17719646] = { id = 17719646, en = 'Urbiolaine',       zone = 230 }
Npcs.Values[17764611] = { id = 17764611, en = 'Teldro-Kesdrodo',  zone = 241 }
Npcs.Values[17764612] = { id = 17764612, en = 'Yonolala',         zone = 241 }
Npcs.Values[17826181] = { id = 17826181, en = 'Nunaarl Bthtrogg', zone = 256 }

--------------------------------------------------------------------------------
function Npcs.GetByProperty(key, value)
    return ByValue(tostring(key), value, Npcs.Values)
end

--------------------------------------------------------------------------------
function Npcs.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Npcs.Values)
end

--------------------------------------------------------------------------------
function Npcs.GetForCurrentZone()
    return Npcs.GetAllByProperty('zone', windower.ffxi.get_info().zone)[1]
end

return Npcs
