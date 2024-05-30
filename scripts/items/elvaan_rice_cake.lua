-----------------------------------
-- ID: 5295
-- Elvaan Rice Cake
-- Enchantment: 60Min, Costume - Elvaan Child (female)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if not target:canUseMisc(xi.zoneMisc.COSTUME) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.COSTUME, 158, 0, 3600)
end

return itemObject
