-----------------------------------
-- Area: Rabao
--  NPC: Rahi Fohlatti
-- Starts Quest: Trial Size Trial by Wind
-- !pos -17 7 -10 247
-----------------------------------
require("scripts/globals/teleports")
local ID = zones[xi.zone.RABAO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:hasItemQty(xi.items.MINI_TUNING_FORK_OF_WIND, 1) and
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND) == QUEST_ACCEPTED and
        player:getMainJob() == xi.job.SMN
    then
        player:startEvent(109, 0, xi.items.MINI_TUNING_FORK_OF_WIND, 3, 20)
    end
end

entity.onTrigger = function(player, npc)
    local trialSizeWind = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND)

    if
        player:getMainLvl() >= 20 and
        player:getMainJob() == xi.job.SMN and
        trialSizeWind == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 2
    then
        --Requires player to be Summoner at least lvl 20
        player:startEvent(108, 0, xi.items.MINI_TUNING_FORK_OF_WIND, 3, 20)     --mini tuning fork, zone, level
    elseif trialSizeWind == QUEST_ACCEPTED then
        local windFork = player:hasItem(xi.items.MINI_TUNING_FORK_OF_WIND)

        if windFork then
            player:startEvent(68) -- Dialogue given to remind player to be prepared
        else
            player:startEvent(112, 0, xi.items.MINI_TUNING_FORK_OF_WIND, 3, 20) -- Need another mini tuning fork
        end
    elseif trialSizeWind == QUEST_COMPLETED then
        player:startEvent(111) -- Defeated Avatar
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 108 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.MINI_TUNING_FORK_OF_WIND) --Mini tuning fork
        else
            player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_SIZE_TRIAL_BY_WIND)
            player:addItem(xi.items.MINI_TUNING_FORK_OF_WIND)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.MINI_TUNING_FORK_OF_WIND)
        end
    elseif csid == 112 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.MINI_TUNING_FORK_OF_WIND) --Mini tuning fork
        else
            player:addItem(xi.items.MINI_TUNING_FORK_OF_WIND)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.MINI_TUNING_FORK_OF_WIND)
        end
    elseif csid == 109 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.CLOISTER_OF_GALES)
    end
end

return entity
