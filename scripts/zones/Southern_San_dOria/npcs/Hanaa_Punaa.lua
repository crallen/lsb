-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Hanaa Punaa
-- Starts and Finishes: A Squire's Test, A Squire's Test II, A Knight's Test
-- !zone 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- "Black Tiger Skins", Tiger Hide trade
    if (player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACK_TIGER_SKINS) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(861, 3) and trade:getItemCount() == 3) then
            player:startEvent(577)
        end
    end
end

entity.onTrigger = function(player, npc)
    -- Checking Fame Level & Quest
    local sanFame = player:getFameLevel(SANDORIA)
    local blackTigerSkins = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACK_TIGER_SKINS)

    -- "Black Tiger Skins" Quest Dialogs
    if (blackTigerSkins == QUEST_AVAILABLE and player:getCharVar("blkTigerSkin") == 1 and sanFame >= 3 and theSteamStress == QUEST_COMPLETED and lizardSkins == QUEST_COMPLETED) then
        player:startEvent(579)
    elseif (blackTigerSkins == QUEST_AVAILABLE and sanFame >= 3 and theSteamStress == QUEST_COMPLETED and lizardSkins == QUEST_COMPLETED) then
        player:startEvent(576)
        player:setCharVar("blkTigerSkin", 1)
    elseif (blackTigerSkins == QUEST_ACCEPTED) then
        player:startEvent(578)
    elseif (blackTigerSkins == QUEST_COMPLETED) then
        player:startEvent(592)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- "Black Tiger Skins" Quest
    if ((csid == 576 or csid == 579) and option == 0) then
        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACK_TIGER_SKINS)
        player:setCharVar("blkTigerSkin", 0)
    elseif (csid == 577) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 13119) -- Tyger Stole
        else
            player:tradeComplete()
            player:addTitle(xi.title.CAT_SKINNER)
            player:addItem(13119)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13119) -- Tyger Stole
            player:addFame(SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.BLACK_TIGER_SKINS)
        end
    end

end

return entity
