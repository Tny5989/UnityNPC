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

-- Yes, zones some zones are in this list multiple times.
-- No, I don't care.  They seem to warp to the same place.

Warps.Values = {}
Warps.Values[''] = { zone = 000, idx = -1, en = '' }

Warps.Values[101] = { zone = 101, idx = 00, en = "East Ronfaure" }
Warps.Values[107] = { zone = 107, idx = 01, en = "South Gustaberg" }
Warps.Values[116] = { zone = 116, idx = 02, en = "East Sarutabaruta" }
Warps.Values[102] = { zone = 102, idx = 03, en = "La Theine Plateau" }
Warps.Values[108] = { zone = 108, idx = 04, en = "Konschtat Highlands" }
Warps.Values[117] = { zone = 117, idx = 05, en = "Tahrongi Canyon" }
Warps.Values[103] = { zone = 103, idx = 06, en = "Valkurm Dunes" }
Warps.Values[118] = { zone = 118, idx = 07, en = "Buburimu Peninsula" }
Warps.Values[126] = { zone = 126, idx = 08, en = "Qufim Island" }
Warps.Values[004] = { zone = 004, idx = 09, en = "Bibiki Bay" }
Warps.Values[002] = { zone = 002, idx = 10, en = "Carpenters' Landing" }
Warps.Values[123] = { zone = 123, idx = 11, en = "Yuhtunga Jungle" }
Warps.Values[024] = { zone = 024, idx = 12, en = "Lufaise Meadows" }
Warps.Values[104] = { zone = 104, idx = 13, en = "Jugner Forest" }
Warps.Values[109] = { zone = 109, idx = 14, en = "Pashhow Marshlands" }
Warps.Values[119] = { zone = 119, idx = 15, en = "Meriphataud Mountains" }
Warps.Values[114] = { zone = 114, idx = 16, en = "Eastern Altepa Desert" }
Warps.Values[124] = { zone = 124, idx = 17, en = "Yhoator Jungle" }
Warps.Values[121] = { zone = 121, idx = 18, en = "The Sanctuary of Zi'Tah" }
Warps.Values[025] = { zone = 025, idx = 19, en = "Misareaux Coast" }
Warps.Values[213] = { zone = 213, idx = 20, en = "Labyrinth of Onzozo" }
Warps.Values[167] = { zone = 167, idx = 21, en = "Bostaunieux Oubliette" }
Warps.Values[105] = { zone = 105, idx = 22, en = "Batallia Downs" }
Warps.Values[110] = { zone = 110, idx = 23, en = "Rolanberry Fields" }
Warps.Values[120] = { zone = 120, idx = 24, en = "Sauromugue Champaign" }
Warps.Values[111] = { zone = 111, idx = 25, en = "Beaucedine Glacier" }
Warps.Values[112] = { zone = 112, idx = 26, en = "Xarcabard" }
Warps.Values[122] = { zone = 122, idx = 27, en = "Ro'Maeve" }
Warps.Values[125] = { zone = 125, idx = 28, en = "Western Altepa Desert" }
Warps.Values[007] = { zone = 007, idx = 29, en = "Attohwa Chasm" }
Warps.Values[200] = { zone = 200, idx = 30, en = "Garlaige Citadel" }
Warps.Values[205] = { zone = 205, idx = 31, en = "Ifrit's Cauldron" }
Warps.Values[153] = { zone = 153, idx = 32, en = "The Boyahda Tree" }
Warps.Values[174] = { zone = 174, idx = 33, en = "Kuftal Tunnel" }
Warps.Values[176] = { zone = 176, idx = 34, en = "Sea Serpent Grotto" }
Warps.Values[159] = { zone = 159, idx = 35, en = "Temple of Uggalepih" }
Warps.Values[208] = { zone = 208, idx = 36, en = "Quicksand Caves" }
Warps.Values[051] = { zone = 051, idx = 37, en = "Wajaom Woodlands" }
Warps.Values[024] = { zone = 024, idx = 38, en = "Lufaise Meadows" }
Warps.Values[113] = { zone = 113, idx = 39, en = "Cape Teriggan" }
Warps.Values[005] = { zone = 005, idx = 41, en = "Uleguerand Range" }
Warps.Values[160] = { zone = 160, idx = 42, en = "Den of Rancor" }
Warps.Values[204] = { zone = 204, idx = 43, en = "Fei'Yin" }
Warps.Values[072] = { zone = 072, idx = 45, en = "Alzadaal Undersea Ruins" }
Warps.Values[025] = { zone = 025, idx = 46, en = "Misareaux Coast" }
Warps.Values[061] = { zone = 061, idx = 47, en = "Mount Zhayolm" }
Warps.Values[212] = { zone = 212, idx = 48, en = "Gustav Tunnel" }
Warps.Values[127] = { zone = 127, idx = 49, en = "Behemoth's Dominion" }
Warps.Values[153] = { zone = 153, idx = 50, en = "The Boyahda Tree" }
Warps.Values[128] = { zone = 128, idx = 51, en = "Valley of Sorrows" }
Warps.Values[051] = { zone = 051, idx = 52, en = "Wajaom Woodlands" }
Warps.Values[061] = { zone = 061, idx = 53, en = "Mount Zhayolm" }
Warps.Values[079] = { zone = 079, idx = 54, en = "Caedarva Mire" }


--------------------------------------------------------------------------------
function Warps.GetByProperty(key, value)
    return ByValue(tostring(key), value, Warps.Values)
end

--------------------------------------------------------------------------------
function Warps.GetAllByProperty(key, value)
    return AllByValue(tostring(key), value, Warps.Values)
end

return Warps
