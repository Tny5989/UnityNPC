local NilMenu = require('model/menu/nil')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local SimpleMenu = NilMenu:NilMenu()
SimpleMenu.__index = SimpleMenu

--------------------------------------------------------------------------------
function SimpleMenu:SimpleMenu(id, option, automated)
    local o = NilMenu:NilMenu()
    setmetatable(o, self)

    o._id = id
    o._option = { option = option, automated = automated }
    o._type = 'SimpleMenu'

    return o
end

return SimpleMenu