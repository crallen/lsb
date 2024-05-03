-----------------------------------
-- Dream Shroud
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)
    local bonusTime = utils.clamp(summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC) - 300, 0, 200)
    local duration = 180 + bonusTime
    local hour = VanadielHour()
    local buffvalue = math.abs(12 - hour) + 1
    target:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    target:delStatusEffect(xi.effect.MAGIC_DEF_BOOST)
    target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, buffvalue, 0, duration)
    target:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, 14 - buffvalue, 0, duration)

    if target:addStatusEffect(xi.effect.PHALANX, 13, 0, duration) then
        if target:getID() == action:getPrimaryTargetID() then
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_2_EFFECTS)
        else
            petskill:setMsg(xi.msg.basic.JA_RECEIVES_2_EFFECTS_2)
        end
    else
        petskill:setMsg(xi.msg.basic.JA_NO_EFFECT_2)
        return
    end

    return 0
end

return abilityObject
