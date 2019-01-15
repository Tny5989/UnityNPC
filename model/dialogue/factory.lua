local NilDialogue = require('model/dialogue/nil')
local WarpDialogue = require('model/dialogue/warp')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local DialogueFactory = {}

--------------------------------------------------------------------------------
function DialogueFactory.CreateWarpDialogue(npc, zone_idx)
    if not npc or npc:Type() == 'NilEntity' then
        log('Unable to find unity npc')
        return NilDialogue:NilDialogue()
    end

    if npc:Distance() > settings.config.maxdistance then
        log('Npc too far away')
        return NilDialogue:NilDialogue()
    end

    if not zone_idx then
        log('Cannot warp to zone')
        return NilDialogue:NilDialogue()
    end

    return WarpDialogue:WarpDialogue(npc, zone_idx)
end

return DialogueFactory
