-----------------------------------
-- func: home
-- desc: Command that returns player to their home point
-----------------------------------
---@type TCommand

local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

commandObj.onTrigger = function(player)
  player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WARP, 0, 3)
end

return commandObj