-----------------------------------
-- ID: 4412
-- Item: thundermelon
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility -6
-- Intelligence 4
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4412)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, -6)
    target:addMod(xi.mod.INT, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, -6)
    target:delMod(xi.mod.INT, 4)
end

return itemObject
