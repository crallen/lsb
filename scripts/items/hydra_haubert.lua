-----------------------------------
-- ID: 14517
-- Item: Hydra Haubert
-- Item Effect: gives refresh
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.REFRESH) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.REFRESH, 3, 3, 180)
    end
end

return itemObject
