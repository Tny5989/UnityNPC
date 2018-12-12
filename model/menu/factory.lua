local NilMenu = require('model/menu/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local MenuFactory = {}

--------------------------------------------------------------------------------
function MenuFactory.CreateSimpleMenu()
    return NilMenu:NilMenu()
end

return MenuFactory
