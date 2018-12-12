--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local NilMenu = {}
NilMenu.__index = NilMenu

--------------------------------------------------------------------------------
function NilMenu:NilMenu()
    local o = {}
    setmetatable(o, self)
    o._id = 0
    o._option = { option = 0, automated = false }
    o._type = 'NilMenu'
    return o
end

--------------------------------------------------------------------------------
function NilMenu:Id()
    return self._id
end

--------------------------------------------------------------------------------
function NilMenu:OptionFor(_)
    return self._option
end

--------------------------------------------------------------------------------
function NilMenu:Type()
    return self._type
end

return NilMenu
