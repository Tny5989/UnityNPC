local LuaUnit = require('luaunit')
local CommandFactory = require('command/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CommandFactoryTests = {}

--------------------------------------------------------------------------------
function CommandFactoryTests:SetUp()
    windower = {}
    windower.ffxi = {}
    function windower.ffxi.get_mob_by_id(id)
        return {id = id, index = 4321, distance = 5}
    end

    function windower.ffxi.get_info()
        return {zone = 110}
    end

    function windower.convert_auto_trans()
    end

    function log()
    end

    resources = {}
    resources.zones = {}

    function resources.zones.with()
    end

    settings = {}
    settings.config = {}
    settings.config.maxdistance = 25
end


--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenBadCommand()
    local c = CommandFactory.CreateCommand(nil)
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenUnknownCommand()
    local c = CommandFactory.CreateCommand('', '')
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreatedWhenBadName()
    local c = CommandFactory.CreateCommand('warp', nil)
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end

--------------------------------------------------------------------------------
function CommandFactoryTests:TestWarpCommmandCreatedForValidWarp()
    local c = CommandFactory.CreateCommand('warp', '')
    LuaUnit.assertEquals(c:Type(), 'WarpCommand')
end

LuaUnit.LuaUnit.run('CommandFactoryTests')