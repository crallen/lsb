-----------------------------------
-- func: buff
-- desc: Command that applies buffs to player
-----------------------------------
require('modules/serpentarius/constants')

---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 0,
    parameters = '',
}

local settings = xi.serpentarius.buff

local function double_print(player, str)
    print(str)
    player:printToPlayer(str, xi.msg.channel.SYSTEM_3, '')
end

local function getStatusEffects(level)
    if level < settings.maxLevelThreshold then
        return settings.lowLevelEffects
    else
        return settings.maxLevelEffects
    end
end

local function getXpEffect(level)
    if level < settings.maxLevelThreshold then
        return xi.effect.DEDICATION
    else
        return xi.effect.COMMITMENT
    end
end

commandObj.onTrigger = function(player)
    local level = player:getMainLvl()
    local xpEffect = getXpEffect(level)
    local statusEffects = getStatusEffects(level)

    if player:getCharVar('serpentarius.buff_enabled') == 1 then
        for _, effect in ipairs(statusEffects) do
            player:delStatusEffect(effect.effect)
        end
        player:delStatusEffect(xi.effect.DEDICATION)
        player:delStatusEffect(xi.effect.COMMITMENT)

        player:setCharVar('serpentarius.buff_enabled', 0)

        double_print(player, 'Buffs disabled')
        return
    end

    for _, effect in ipairs(statusEffects) do
        player:addStatusEffect(effect.effect, effect.power, 3, 0)
    end

    player:delStatusEffectSilent(xi.effect.DEDICATION)
    player:delStatusEffectSilent(xi.effect.COMMITMENT)
    player:addStatusEffect(xpEffect, settings.xpBonus.power, 0, 0, 0, settings.xpBonus.subpower)

    player:setCharVar('serpentarius.buff_enabled', 1)

    double_print(player, 'Buffs enabled')
end

return commandObj
