local BuyDialogue = require('model/dialogue/buy')
local NilDialogue = require('model/dialogue/nil')
local WarpDialogue = require('model/dialogue/warp')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local DialogueFactory = {}

--------------------------------------------------------------------------------
function DialogueFactory.CreateWarpDialogue(npc, zone)
    if not npc or npc:Type() == 'NilEntity' then
        log('Unable to find unity npc')
        return NilDialogue:NilDialogue()
    end

    if npc:Distance() > settings.config.maxdistance then
        log('Npc too far away')
        return NilDialogue:NilDialogue()
    end

    if not zone or zone.idx < 0 then
        log('Cannot warp to zone')
        return NilDialogue:NilDialogue()
    end

    return WarpDialogue:WarpDialogue(npc, zone)
end

--------------------------------------------------------------------------------
function DialogueFactory.CreateBuyDialogue(npc, player, item, count)
    if not npc or npc:Type() == 'NilEntity' then
        log('Unable to find npc')
        return NilDialogue:NilDialogue()
    end

    if not player or player:Type() == 'NilEntity' then
        log('Unable to find player')
        return NilDialogue:NilDialogue()
    end

    if npc:Distance() > settings.config.maxdistance then
        log('Npc too far away')
        return NilDialogue:NilDialogue()
    end

    if not item or item.idx < 0 then
        log('Bad item id')
        return NilDialogue:NilDialogue()
    end

    if not count then
        log('Bad item count')
        return NilDialogue:NilDialogue()
    end

    if player:Bag():FreeSlots() < 1 then
        log('Inventory full')
        return NilDialogue:NilDialogue()
    end

    return BuyDialogue:BuyDialogue(npc, item, count)
end

return DialogueFactory
