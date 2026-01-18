-----------------------------------
-- Buff Module
-- Handles buff persistence and reapplication
-----------------------------------
require('modules/module_utils')
require('scripts/globals/player')
require('modules/serpentarius/constants')

local m = Module:new('serpentarius_buff')

local settings = xi.serpentarius.buff

-- Helper function to remove all buff effects
local function removeAllBuffEffects(player)
    player:delStatusEffect(xi.effect.REGEN)
    player:delStatusEffect(xi.effect.REFRESH)
    player:delStatusEffect(xi.effect.REGAIN)
    player:delStatusEffect(xi.effect.DEDICATION)
    player:delStatusEffect(xi.effect.COMMITMENT)
end

-- Reapply DEDICATION when it wears off (XP cap reached)
m:addOverride('xi.effects.dedication.onEffectLose', function(target, effect)
    super(target, effect)

    if target:getCharVar('serpentarius.buff_enabled') == 1 then
        -- Use timer to avoid reapplying during effect deletion
        target:timer(100, function(player)
            if player:getCharVar('serpentarius.buff_enabled') == 1 then
                player:delStatusEffectSilent(xi.effect.COMMITMENT)
                player:addStatusEffect(xi.effect.DEDICATION, settings.xpBonus.power, 0, 0, 0, settings.xpBonus.subpower)
            end
        end)
    end
end)

-- Reapply COMMITMENT when it wears off (CP cap reached)
m:addOverride('xi.effects.commitment.onEffectLose', function(target, effect)
    super(target, effect)

    if target:getCharVar('serpentarius.buff_enabled') == 1 then
        target:timer(100, function(player)
            if player:getCharVar('serpentarius.buff_enabled') == 1 then
                player:delStatusEffectSilent(xi.effect.DEDICATION)
                player:addStatusEffect(xi.effect.COMMITMENT, settings.xpBonus.power, 0, 0, 0, settings.xpBonus.subpower)
            end
        end)
    end
end)

-- Remove buffs when player reaches level 99 (buff set changes)
m:addOverride('xi.player.onPlayerLevelUp', function(player)
    super(player)

    if player:getMainLvl() == settings.maxLevelThreshold and player:getCharVar('serpentarius.buff_enabled') == 1 then
        removeAllBuffEffects(player)

        player:setCharVar('serpentarius.buff_enabled', 0)

        player:printToPlayer('Buffs disabled due to reaching level 99. Use /buff to reapply.', xi.msg.channel.SYSTEM_3, '')
    end
end)

return m
