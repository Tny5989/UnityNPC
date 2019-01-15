local MobEntity = require('model/entity/mob')
local NilEntity = require('model/entity/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local EntityFactory = {}

--------------------------------------------------------------------------------
function EntityFactory.CreateMob(mob_id)
    if not mob_id then
        return NilEntity:NilEntity()
    end

    local mob = windower.ffxi.get_mob_by_id(mob_id)
    if not mob or not mob.valid_target then
        return NilEntity:NilEntity()
    end

    local info = windower.ffxi.get_info()
    if not info or not info.zone then
        return NilEntity:NilEntity()
    end

    return MobEntity:MobEntity(mob, info.zone)
end

return EntityFactory
