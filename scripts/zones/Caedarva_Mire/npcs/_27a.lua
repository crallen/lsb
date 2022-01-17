-----------------------------------
-- Area: Caedarva Mire
--  NPC: Engraved Tablet
-- !pos 763 -9 638 79
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.CYAN_DEEP_SALT) then
        player:startEvent(304)
    else
        player:startEvent(306)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 304 and option == 1 then
        player:delKeyItem(xi.ki.CYAN_DEEP_SALT)
    end
end

return entity
