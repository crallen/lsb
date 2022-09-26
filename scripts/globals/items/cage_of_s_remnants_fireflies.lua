-----------------------------------
-- ID: 5401
-- S. Rem. Fireflies
-- Transports the user out of Silver Sea Remnants
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.SILVER_SEA_REMNANTS then
        return 0
    end
    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.S_REM, 0, 1)
end

item_object.onItemDrop = function(target, item)
   target:addTempItem(xi.items.CAGE_OF_S_REMNANTS_FIREFLIES)
end

return item_object
