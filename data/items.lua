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
--------------------------------------------------------------------------------
local Items = {}
Items.Values = {}

-- Nil Key
Items.Values['']   = { id = 0000, idx = 0, en = '' }

-- Items
Items.Values[8973] = { id = 8973, idx = 01, en = 'SP Gobbie Key' }
Items.Values[4181] = { id = 4181, idx = 02, en = 'Warp Scroll' }
Items.Values[5945] = { id = 5945, idx = 12, en = 'Prize Powder' }

--------------------------------------------------------------------------------
function Items.GetByProperty(key, value)
    return ByValue(tostring(key), value, Items.Values)
end

--------------------------------------------------------------------------------
function Items.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Items.Values)
end

return Items