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
  xi.spells.enhancing.useTeleportSpell(nil, player, xi.magic.spell.WARP)
end

return commandObj