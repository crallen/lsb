-----------------------------------
-- Judgment Bolt
-- Deals lightning elemental damage to enemies within area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 9

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.THUNDER, 3, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)

    return damage
end

return mobskillObject
