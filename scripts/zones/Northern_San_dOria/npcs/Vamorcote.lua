-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Vamorcote
-- Starts and Finishes Quest: The Setting Sun
-- !pos -137.070 10.999 161.855 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- "The Setting Sun" conditional script
    if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN) == QUEST_ACCEPTED then
        if trade:hasItemQty(xi.items.ENGRAVED_KEY, 1) and trade:getItemCount() == 1 then
            player:startEvent (658)
        end
    end
end

entity.onTrigger = function(player, npc)
    -- Look at the "The Setting Sun" quest status and San d'Oria player's fame
    local theSettingSun = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)

    if
        theSettingSun == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 5 and
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACKMAIL) ~= QUEST_COMPLETED
    then
        player:startEvent(654, 0, xi.items.ENGRAVED_KEY, xi.items.ENGRAVED_KEY) --The quest is offered to the player.
    elseif theSettingSun == QUEST_ACCEPTED then
        player:startEvent(655, 0, 0, xi.items.ENGRAVED_KEY) --The NPC asks if the player got the key.'
    elseif theSettingSun == QUEST_COMPLETED and player:needToZone() then
        player:startEvent(659) --The quest is already done by the player and the NPC does small talks.
    else
        player:startEvent(651)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 654 and option == 1 then --Player accepts the quest
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)
    elseif csid == 658 then --The player trades the Engraved Key to the NPC. Here come the rewards!
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 10000)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_SETTING_SUN)
    end
end

return entity
