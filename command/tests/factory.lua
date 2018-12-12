local LuaUnit = require('luaunit')
local CommandFactory = require('command/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
CommandFactoryTests = {}

--------------------------------------------------------------------------------
function CommandFactoryTests:TestNilCommandCreated()
    local c = CommandFactory.CreateCommand()
    LuaUnit.assertEquals(c:Type(), 'NilCommand')
end


LuaUnit.LuaUnit.run('CommandFactoryTests')