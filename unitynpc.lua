_addon.name = 'UnityNPC'
_addon.author = 'Areint/Alzade'
_addon.version = '1.0.0'
_addon.commands = {'unpc'}

--------------------------------------------------------------------------------
require('logger')
packets = require('util/packets')
settings = require('util/settings')

--------------------------------------------------------------------------------
local command = NilCommand:NilCommand()

--------------------------------------------------------------------------------
local function OnCommandFinished()
    command = NilCommand:NilCommand()
end

--------------------------------------------------------------------------------
local function OnLoad()
    settings.load()
end

--------------------------------------------------------------------------------
local function OnCommand(cmd, name)
    if command:Type() == 'NilCommand' then
        command = CommandFactory.CreateCommand(cmd, name)
        command:SetSuccessCallback(OnCommandFinished)
        command:SetFailureCallback(OnCommandFinished)
        command()
    else
        log('Already running a command')
    end
end

--------------------------------------------------------------------------------
local function OnIncomingData(id, _, pkt, b, i)
    return command:OnIncomingData(id, pkt)
end

--------------------------------------------------------------------------------
windower.register_event('load', OnLoad)
windower.register_event('addon command', OnCommand)
windower.register_event('incoming chunk', OnIncomingData)