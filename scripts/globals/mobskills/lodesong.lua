-----------------------------------
-- Lodesong
--
-- Description: Weighs down targets in an area of effect.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- can only used if not silenced
    if mob:getMainJob() == xi.job.BRD and mob:hasStatusEffect(xi.effect.SILENCE) == false then
        return 0
    end
    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 50))

    return nil
end

return mobskillObject
