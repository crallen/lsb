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
  player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.DEM, 0, 3)
end

return commandObj