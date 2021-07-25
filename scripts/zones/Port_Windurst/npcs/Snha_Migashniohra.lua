-----------------------------------
-- Area: Port Windurst
--  NPC: Snha Migashniohra
-- Working 100%
-----------------------------------
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(343)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
