-----------------------------------
-- Royal Bash
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.tpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.STUN

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
