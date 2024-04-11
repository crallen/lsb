-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Shahau
-- Type: Alchemy Image Support
-- !pos -10.470 -6.25 -141.700 241
-----------------------------------
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local skillLevel = xi.crafting.getRealSkill(player, xi.skill.ALCHEMY)

    if xi.crafting.hasJoinedGuild(player, xi.guild.ALCHEMY) then
        if not player:hasStatusEffect(xi.effect.ALCHEMY_IMAGERY) then
            player:startEvent(638, 4, skillLevel, 2, 511, 0, 0, 7, 2184)
        else
            player:startEvent(638, 4, skillLevel, 2, 511, 5662, 7154, 7, 2184)
        end
    else
        player:startEvent(638, 0, 0, 0, 0, 0, 0, 7, 0) -- Standard Dialogue
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 638 and option == 1 then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 7, 2)
        player:addStatusEffect(xi.effect.ALCHEMY_IMAGERY, 1, 0, 120)
    end
end

return entity
