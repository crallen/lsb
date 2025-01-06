-----------------------------------
-- func: signet
-- desc: Command that applies Signet, Sanction, etc to player
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

function cancelAllBuffs(player)
  player:delStatusEffect(xi.effect.SIGNET)
  player:delStatusEffect(xi.effect.SANCTION)
  player:delStatusEffect(xi.effect.SIGIL)
  player:delStatusEffect(xi.effect.IONIS)
end

commandObj.onTrigger = function(player)
  local region  = player:getCurrentRegion()
  local eightHours = 8 * 60 * 60

  if region < xi.region.WEST_AHT_URHGAN then
    cancelAllBuffs(player)
    player:addStatusEffect(xi.effect.SIGNET, 0, 0, eightHours)
  elseif region >= xi.region.WEST_AHT_URHGAN and region < xi.region.RONFAURE_FRONT then
    cancelAllBuffs(player)
    player:addStatusEffect(xi.effect.SANCTION, 0, 0, eightHours)
  elseif region >= xi.region.RONFAURE_FRONT and region < xi.region.ABYSSEA then
    cancelAllBuffs(player)
    player:addStatusEffect(xi.effect.SIGIL, 0, 0, eightHours)
  elseif region == xi.region.ADOULIN_ISLANDS or region == xi.region.EAST_ULBUKA then
    cancelAllBuffs(player)
    player:addStatusEffect(xi.effect.IONIS, 0, 0, eightHours)
  end
end

return commandObj