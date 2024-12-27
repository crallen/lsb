-----------------------------------
-- func: holla
-- desc: Command that teleports player to telepoint Holla
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

commandObj.onTrigger = function(player)
  xi.spells.enhancing.useTeleportSpell(nil, player, xi.magic.spell.TELEPORT_HOLLA)
end

return commandObj