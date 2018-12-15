local NilDialogue = require('model/dialogue/nil')
local Handshake = require('model/interaction/handshake')
local Choice = require('model/interaction/choice')
local NilMenu = require('model/menu/nil')
local MenuFactory = require('model/menu/factory')

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local WarpDialogue = NilDialogue:NilDialogue()
WarpDialogue.__index = WarpDialogue

--------------------------------------------------------------------------------
function WarpDialogue:WarpDialogue(target, zone_idx)
    local o = NilDialogue:NilDialogue()
    setmetatable(o, self)
    o._target = target
    o._zone_idx = zone_idx
    o._type = 'WarpDialogue'
    o._menu = NilMenu:NilMenu()
    o._interactions = {}
    o._idx = 0

    setmetatable(o._interactions,
        { __index = function() return o._on_success end})

    o:_AppendInteraction(Handshake:Handshake())

    return o
end

--------------------------------------------------------------------------------
function WarpDialogue:OnIncomingData(id, pkt)
    local block = false
    if id == 0x037 then
        block = true
    elseif id == 0x034 or id == 0x032 then
        block = true
        self._menu = MenuFactory.CreateMenu(pkt)
        self:_AppendInteraction(Choice:Choice())
    elseif id == 0x05C then
        block = true
        self._menu = MenuFactory.CreateExtraMenu(pkt, self._menu, self._zone_idx)
        self:_AppendInteraction(Choice:Choice())
    elseif id == 0x00B then
        block = false
        self._on_success()
        self._on_success = function() end
        self._on_failure = function() end
    end

    return (self._interactions[self._idx]:OnIncomingData(id, pkt) or block)
end

--------------------------------------------------------------------------------
function WarpDialogue:Start()
    self:_OnSuccess()
end

--------------------------------------------------------------------------------
function WarpDialogue:_AppendInteraction(interaction)
    interaction:SetSuccessCallback(function() self:_OnSuccess() end)
    interaction:SetFailureCallback(function() self._on_failure() end)
    table.insert(self._interactions, interaction)
end

--------------------------------------------------------------------------------
function WarpDialogue:_OnSuccess()
    self._idx = self._idx + 1
    local option = self._menu:OptionFor(self._zone_idx)
    local menu_id = self._menu:Id()
    local next = self._interactions[self._idx]

    next(self._target, menu_id, option.option, option.automated)
end

return WarpDialogue
