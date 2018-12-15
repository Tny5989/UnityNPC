local ActionMenu = require('model/menu/action')
local NilMenu = require('model/menu/nil')
local SimpleMenu = require('model/menu/simple')
local WarpMenu = require('model/menu/warp')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MenuFactory = {}

--------------------------------------------------------------------------------
function MenuFactory.CreateMenu(pkt)
    if not pkt or not packets then
        return NilMenu:NilMenu()
    end

    local ppkt = packets.parse('incoming', pkt)
    if not ppkt then
        return NilMenu:NilMenu()
    end

    local menu_id = ppkt['Menu ID']
    if not menu_id or menu_id == 0 then
        return NilMenu:NilMenu()
    end

    local params = ppkt['Menu Parameters']
    if not params then
        return SimpleMenu:SimpleMenu(menu_id, 0, false)
    end

    return SimpleMenu:SimpleMenu(menu_id, 10, true)
end

--------------------------------------------------------------------------------
function MenuFactory.CreateExtraMenu(pkt, last_menu, zone_idx)
    if not pkt or not last_menu or not zone_idx or not packets then
        return NilMenu:NilMenu()
    end

    -- This isn't really needed until I figure out what is in these packets
    local ppkt = packets.parse('incoming', pkt)
    if not ppkt then
        return NilMenu:NilMenu()
    end

    if last_menu:Type() == 'SimpleMenu' then
        return ActionMenu:ActionMenu(last_menu:Id())
    else
        return WarpMenu:WarpMenu(last_menu:Id(), { zone_idx });
    end

    return NilMenu:NilMenu()
end

return MenuFactory
