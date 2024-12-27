-----------------------------------
-- func: dem
-- desc: Command that teleports player to telepoint Dem
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

commandObj.onTrigger = function(player)
  xi.spells.enhancing.useTeleportSpell(nil, player, xi.magic.spell.TELEPORT_DEM)
end

return commandObj