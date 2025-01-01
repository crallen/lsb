-----------------------------------
-- func: buff
-- desc: Command that applies buffs to player
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

local function double_print(player, str)
    print(str)
    player:printToPlayer(str, xi.msg.channel.SYSTEM_3, '')
end

commandObj.onTrigger = function(player)
    if player:hasStatusEffect(xi.effect.REGEN) or player:hasStatusEffect(xi.effect.REFRESH) or player:hasStatusEffect(xi.effect.REGAIN) then
        player:delStatusEffect(xi.effect.REGEN)
        player:delStatusEffect(xi.effect.REFRESH)
        player:delStatusEffect(xi.effect.REGAIN)

        double_print(player, 'Buffs disabled')
        return
    end

    player:addStatusEffect(xi.effect.REGEN, 20, 3, 0)
    player:addStatusEffect(xi.effect.REFRESH, 20, 3, 0)
    player:addStatusEffect(xi.effect.REGAIN, 20, 3, 0) -- this is also affected by the TP multiplier

    double_print(player, 'Buffs enabled')
end

return commandObj
