-----------------------------------
-- ID: 5283
-- Old Bolt Box +5
-- When used, you will obtain one partial stack of Dogbolt +5
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.DOGBOLT_P5, math.random(10, 20) } })
end

return itemObject
