--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local Aliases = {}

--------------------------------------------------------------------------------
function Aliases.Update()
    windower.send_command('alias buykeys input //unpc buy "SP Gobbie Key" ')
    windower.send_command('alias buypowder input //unpc buy "Prize Powder" ')
    windower.send_command('alias buywarp input //unpc buy "Warp Scroll" 1')
end

return Aliases
