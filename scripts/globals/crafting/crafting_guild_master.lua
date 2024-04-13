-----------------------------------
-- Guild Masters
-----------------------------------
require('scripts/globals/crafting/crafting_utils')
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = xi.crafting or {}

-----------------------------------
-- Data
-----------------------------------
local npcTable =
{
    ['Thubu_Parohren'] = { 10009, xi.guild.FISHING,      xi.skill.FISHING,      xi.item.WATER_CRYSTAL, xi.ki.ANGLERS_ALMANAC,       'FishingExpertQuest'      },
    ['Cheupirudaux'  ] = {   621, xi.guild.WOODWORKING,  xi.skill.WOODWORKING,  xi.item.WIND_CRYSTAL,  xi.ki.WAY_OF_THE_CARPENTER,  'WoodworkingExpertQuest'  },
    ['Ghemp'         ] = {   101, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.item.FIRE_CRYSTAL,  xi.ki.WAY_OF_THE_BLACKSMITH, 'SmithingExpertQuest'     },
    ['Mevreauche'    ] = {   626, xi.guild.SMITHING,     xi.skill.SMITHING,     xi.item.FIRE_CRYSTAL,  xi.ki.WAY_OF_THE_BLACKSMITH, 'SmithingExpertQuest'     },
    ['Reinberta'     ] = {   300, xi.guild.GOLDSMITHING, xi.skill.GOLDSMITHING, xi.item.FIRE_CRYSTAL,  xi.ki.WAY_OF_THE_GOLDSMITH,  'GoldsmithingExpertQuest' },
    ['Ponono'        ] = { 10011, xi.guild.CLOTHCRAFT,   xi.skill.CLOTHCRAFT,   xi.item.EARTH_CRYSTAL, xi.ki.WAY_OF_THE_WEAVER,     'ClothcraftExpertQuest'   },
    ['Faulpie'       ] = {   648, xi.guild.LEATHERCRAFT, xi.skill.LEATHERCRAFT, xi.item.DARK_CRYSTAL,  xi.ki.WAY_OF_THE_TANNER,     'LeathercraftExpertQuest' },
    ['Peshi_Yohnts'  ] = { 10016, xi.guild.BONECRAFT,    xi.skill.BONECRAFT,    xi.item.WIND_CRYSTAL,  xi.ki.WAY_OF_THE_BONEWORKER, 'BonecraftExpertQuest'    },
    ['Abd-al-Raziq'  ] = {   120, xi.guild.ALCHEMY,      xi.skill.ALCHEMY,      xi.item.WATER_CRYSTAL, xi.ki.WAY_OF_THE_ALCHEMIST,  'AlchemyExpertQuest'      },
    ['Piketo-Puketo' ] = { 10013, xi.guild.COOKING,      xi.skill.COOKING,      xi.item.FIRE_CRYSTAL,  xi.ki.WAY_OF_THE_CULINARIAN, 'CookingExpertQuest'      },
}

-- TODO: Enum this items. This PR is already massive.
local testItemTable =
{
    [xi.guild.FISHING     ] = {  4401,  4379,  4469,  4480,  4462,  4479,  4471,  4478,  4474,  5817 },
    [xi.guild.WOODWORKING ] = {    22,    23, 17354, 17348, 17053, 17156, 17054,    56, 17101, 18884 },
    [xi.guild.SMITHING    ] = { 16530, 12299, 16512, 16650, 16651, 16559, 12427, 16577, 12428, 19788 },
    [xi.guild.GOLDSMITHING] = { 12496, 12497, 12495, 13082, 13446, 13084, 12545, 13125, 16515, 11060 },
    [xi.guild.CLOTHCRAFT  ] = { 13583, 13584, 13204, 13075, 12723, 13586, 13752, 12612, 14253, 11000 },
    [xi.guild.LEATHERCRAFT] = { 13594, 16386, 13588, 13195, 12571, 12572, 12980, 12702, 12447, 10577 },
    [xi.guild.BONECRAFT   ] = { 13442, 13441, 13323, 13459, 13091, 17299, 16420, 12508, 13987, 11058 },
    [xi.guild.ALCHEMY     ] = {   937,  4157,  4163,   947, 16543,  4116, 16479,  4120, 16609, 10792 },
    [xi.guild.COOKING     ] = {  4355,  4416,  4489,  4381,  4413,  4558,  4546,  4440,  4561,  5930 },
}

local function giveNewRank(player, guildId, skillId, newRank)
    -- Raise rank.
    player:setSkillRank(skillId, newRank)

    -- Reset guild points for the day.
    if player:getCharVar('[GUILD]currentGuild') == guildId + 1 then
        player:setCharVar('[GUILD]daily_points', 1)
    end

    -- Set local var to complete trade after event.
    player:setLocalVar('CompleteTrade', 1)
end

-----------------------------------
-- NPC Functions
-----------------------------------
xi.crafting.guildMasterOnTrade = function(player, npc, trade)
    local npcName = npc:getName()
    local eventId = npcTable[npcName][1] + 1 -- Trade event = Trigger event + 1
    local guildId = npcTable[npcName][2]
    local skillId = npcTable[npcName][3]

    -- Get test item and new rank.
    local newRank    = 0
    local testItem   = 0
    local skillLevel = xi.crafting.getRealSkill(player, skillId)
    local skillCap   = xi.crafting.getCraftSkillCap(player, skillId)

    if skillLevel >= skillCap - 2 then
        newRank  = player:getSkillRank(skillId) + 1
        testItem = testItemTable[guildId][newRank]
    end

    -- Check trade.
    if
        trade:hasItemQty(testItem, 1) and
        trade:getItemCount() == 1
    then
        -- Expert quest.
        if
            newRank >= xi.craftRank.EXPERT and           -- Check if new rank is the last one. (Tied to mini-quest)
            player:hasKeyItem(npcTable[npcName][5]) and  -- Check if player has appropiate Key Item.
            player:getCharVar(npcTable[npcName][6]) == 2 -- Check if player has gotten quest dialog.
        then
            if
                (guildId ~= xi.guild.FISHING and trade:getItem():getSignature() == player:getName()) or
                guildId == xi.guild.FISHING
            then
                player:setCharVar(npcTable[npcName][6], 0)
                giveNewRank(player, guildId, skillId, newRank)
                player:startEvent(eventId, 0, 0, 0, 0, newRank, 1)
            else
                player:startEvent(eventId, 0, 0, 0, 0, newRank, 0)
            end

        -- All else.
        elseif newRank ~= xi.craftRank.AMATEUR then
            giveNewRank(player, guildId, skillId, newRank)
            player:startEvent(eventId, 0, 0, 0, 0, newRank, 0)
        end
    end
end

xi.crafting.guildMasterOnTrigger = function(player, npc)
    local npcName = npc:getName()
    local eventId = npcTable[npcName][1]
    local guildId = npcTable[npcName][2]
    local skillId = npcTable[npcName][3]
    local keyItem = npcTable[npcName][5]

    -- Event parameters
    local testItem       = os.time()                                     -- Parameter 1: Current time OR Test Item if applicable.
    local skillLevel     = xi.crafting.getRealSkill(player, skillId)     -- Parameter 2: Player real level on concrete craft.
    local skillCap       = xi.crafting.getCraftSkillCap(player, skillId) -- Parameter 3: Player max level on concrete craft.
    local guildsJoined   = player:getCharVar('Guild_Member')             -- Parameter 4: Bitmask with guilds joined.
    local questStatus    = 0                                             -- Parameter 5: Used for expert quest.
    local artisanCount   = 0                                             -- Parameter 7: Number of crafts at Artisan rank or higher.
    local artisanBitmask = 0                                             -- Parameter 8: Bitmask of craft guilds at Artisan rank or higher.

    -- Calculate parameter 1 (Test item)
    if skillLevel >= skillCap - 2 then
        testItem = testItemTable[guildId][player:getSkillRank(skillId) + 1]
    end

    -- Calculate parameter 5 (Quest status)
    local questProgress = player:getCharVar(npcTable[npcName][6])

    if questProgress >= 1 then
        questStatus = questStatus + 512 -- Set bit 9

        if player:hasKeyItem(keyItem) then
            questStatus = questStatus + 1 -- Set bit 1
        end

        if questProgress >= 2 then
            questStatus = questStatus + 1024 -- Set bit 10
        end
    end

    -- Calculate parameters 7 and 8 (Used for rank renouncement)
    -- Note 1: It cycles. First time returns params. Second doesnt. Third does. And so on.
    -- Note 2: Highest level craft cannot be renounced.
    if
        guildId ~= xi.guild.FISHING and
        player:getLocalVar('skipRenounceDialog') == 0
    then
        local rankChecked       = 0
        local highestSkillId    = 0
        local highestSkillLevel = 0
        local currentSkillLevel = 0

        -- Track highest skill. This one wont appear in renounce list.
        for skillChecked = xi.skill.WOODWORKING, xi.skill.COOKING do
            currentSkillLevel = player:getCharSkillLevel(skillChecked)

            if currentSkillLevel > highestSkillLevel then
                highestSkillLevel = currentSkillLevel
                highestSkillId    = skillChecked
            end
        end

        -- Params 7 and 8.
        for skillChecked = xi.skill.WOODWORKING, xi.skill.COOKING do
            rankChecked = player:getSkillRank(skillChecked)

            -- Param 7: Count crafts over craftsman rank.
            if rankChecked >= xi.craftRank.ARTISAN then
                artisanCount = artisanCount + 1
            end

            -- Param 8: Full mask except craft ids that CAN be renounced.
            if
                rankChecked < xi.craftRank.ARTISAN or
                skillChecked == highestSkillId
            then
                artisanBitmask = bit.bor(artisanBitmask, bit.lshift(1, skillChecked - 48))
            end
        end

        player:setLocalVar('skipRenounceDialog', 1)
    else
        player:setLocalVar('skipRenounceDialog', 0)
    end

    player:startEvent(eventId, testItem, skillLevel, skillCap, guildsJoined, questStatus, 0, artisanCount, artisanBitmask)
end

xi.crafting.guildMasterOnEventFinish = function(player, csid, option, npc)
    local ID      = zones[player:getZoneID()]
    local npcName = npc:getName()
    local eventId = npcTable[npcName][1]
    local guildId = npcTable[npcName][2]

    -- Trigger onEventFinish
    if csid == eventId then

        -- Signup Event.
        if option == 1 then
            local crystalId = npcTable[npcName][4] -- Crystal

            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystalId)
            else
                player:messageSpecial(ID.text.ITEM_OBTAINED, crystalId)
                player:addItem(crystalId)
                player:incrementCharVar('Guild_Member', bit.lshift(1, guildId))
            end

        -- Expert quest: Start.
        elseif option == 2 then
            if xi.crafting.hasJoinedGuild(player, guildId) then
                player:setCharVar('FishingExpertQuest', 1)
            end

        -- Expert quest fish (after getting KI)
        elseif option == 3 then
            player:setCharVar('FishingExpertQuest', 2)

        -- Rank renouncement.
        elseif
            option >= xi.skill.WOODWORKING and
            option <= xi.skill.COOKING
        then
            player:setSkillRank(option, xi.craftRank.CRAFTSMAN)
            player:setSkillLevel(option, 700)
            player:messageSpecial(ID.text.RENOUNCE_CRAFTSMAN, 0, option - 49)
        end

    -- Trade onEventFinish
    elseif csid == eventId + 1 then
        if player:getLocalVar('CompleteTrade') == 1 then
            player:tradeComplete()
            player:setLocalVar('CompleteTrade', 0)
        end
    end

    -- Handle RoE.
    if guildId ~= xi.guild.FISHING then
        local recordId = guildId + 99

        if player:hasEminenceRecord(recordId) then
            xi.roe.onRecordTrigger(player, recordId)
        end
    end
end
