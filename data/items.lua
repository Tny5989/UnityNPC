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
Items.Values[8973] = { id = 8973, idx = 01, type = "normal",  en = 'SP Gobbie Key' }
Items.Values[4181] = { id = 4181, idx = 02, type = "normal", en = 'Warp Scroll' }
Items.Values[5945] = { id = 5945, idx = 12, type = "normal", en = 'Prize Powder' }

-- Special Items
Items.Values[8979] = { id = 8979, idx = 00, type = 'special', en = 'Imperator\'s Wing' }
Items.Values[8982] = { id = 8982, idx = 02, type = 'special', en = 'Intuila\'s Hide' }
Items.Values[8987] = { id = 8987, idx = 07, type = 'special', en = 'Strix\'s Tailfeather' }
Items.Values[8989] = { id = 8989, idx = 09, type = 'special', en = 'Arke\'s Wing' }
Items.Values[8990] = { id = 8990, idx = 10, type = 'special', en = 'Largantua\'s Shard' }
Items.Values[9031] = { id = 9031, idx = 19, type = 'special', en = 'Vedrfolnir\s Wing' }
Items.Values[9047] = { id = 9047, idx = 20, type = 'special', en = 'Immani. Hide' }
Items.Values[9051] = { id = 9051, idx = 23, type = 'special', en = 'Camahueto\'s Fur' }
Items.Values[9094] = { id = 9094, idx = 33, type = 'special', en = 'Clawberry\'s Coat' }
Items.Values[9097] = { id = 9097, idx = 35, type = 'special', en = 'Mhuufya\'s Beak' }
Items.Values[9098] = { id = 9098, idx = 39, type = 'special', en = 'G. Grenade\s Ash' }
Items.Values[8974] = { id = 8974, idx = 53, type = 'special', en = 'Harold\s Ore' }
Items.Values[8975] = { id = 8975, idx = 54, type = 'special', en = 'Belinda\s Hide' }

--------------------------------------------------------------------------------
function Items.GetByProperty(key, value)
    return ByValue(tostring(key), value, Items.Values)
end

--------------------------------------------------------------------------------
function Items.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Items.Values)
end

return Items