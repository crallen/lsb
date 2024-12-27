-----------------------------------
-- func: mea
-- desc: Command that teleports player to telepoint Mea
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

commandObj.onTrigger = function(player)
  xi.spells.enhancing.useTeleportSpell(nil, player, xi.magic.spell.TELEPORT_MEA)
end

return commandObj