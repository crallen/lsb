-----------------------------------
-- Area: Riverne Site #B01
-- Name: Storms of Fate
-- !pos 299 -123 345 146
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
require("scripts/globals/battlefield")
-----------------------------------
local battlefieldObject = {}

battlefieldObject.onBattlefieldTick = function(battlefield, tick)
    xi.battlefield.onBattlefieldTick(battlefield, tick)
end

battlefieldObject.onBattlefieldRegister = function(player, battlefield)
end

battlefieldObject.onBattlefieldEnter = function(player, battlefield)
end

battlefieldObject.onBattlefieldLeave = function(player, battlefield, leavecode)
    if leavecode == xi.battlefield.leaveCode.WON then
        local _, clearTime, partySize = battlefield:getRecord()
        local arg8 = (player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_COMPLETED) and 1 or 0
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), arg8)
    elseif leavecode == xi.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

battlefieldObject.onEventUpdate = function(player, csid, option, npc)
end

battlefieldObject.onEventFinish = function(player, csid, option, npc)
    if csid == 32001 then
        if
            player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and
            player:getCharVar('StormsOfFate') == 2
        then
            player:addKeyItem(xi.ki.WHISPER_OF_THE_WYRMKING)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHISPER_OF_THE_WYRMKING)
            player:setCharVar('StormsOfFate', 3)
            player:addTitle(xi.title.CONQUEROR_OF_FATE)
        end
    end
end

return battlefieldObject
