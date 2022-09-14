-----------------------------------
-- Area: Al Zahbi
--  NPC: Najaaj
-- Type: Standard NPC
-- !pos 61.563 -1 36.264 48
-----------------------------------
local entity = {}

local path =
{
    { x = 40.000, y = 0.000, z = 36.000, wait = 2000 },
    { wait = 3000, rotation = 0 },
    { x = 67.000, wait = 2000 },
    { wait = 3000, rotation = 128 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos({path[1], path[2], path[3]})
    npc:pathThrough(path, xi.path.flag.PATROL)
end

-- entity.onPath = function(npc)
--     npc:pathThrough(path, xi.path.flag.PATROL)
-- end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(241)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
