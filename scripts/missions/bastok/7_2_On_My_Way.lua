-----------------------------------
-- On My Way
-- Bastok M7-2
-----------------------------------
-- !addmission 1 19
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Karst   : !pos 106 -21 0 237
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local bastokMarketsID = require("scripts/zones/Bastok_Markets/IDs")
local bastokMinesID   = require("scripts/zones/Bastok_Mines/IDs")
local metalworksID    = require("scripts/zones/Metalworks/IDs")
local portBastokID    = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.ON_MY_WAY)

mission.reward =
{
    gil = 60000,
    rank = 8,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 19 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET + 7),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Gumbah'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: This logic needs to change, see mission complete note
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        player:getCharVar("[B7-2]Werei") == 0
                    then
                        return mission:progressEvent(177)
                    end
                end,
            },

            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET + 7),

            onEventFinish =
            {
                [177] = function(player, csid, option, npc)
                    player:setCharVar("[B7-2]Werei", 1)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Karst'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(765)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(766)
                    end
                end,
            },

            ['Malduc'] = mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET + 7),

            onEventFinish =
            {
                [765] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [766] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        -- TODO: There's some logic with Gumbah and Cornelia's door that needs to
                        -- be handled.  Gumbah is required before starting next mission, but this
                        -- mission can be completed prior to that cutscene.  Cornelia has two
                        -- options for which CS is displayed, depending on quest completion.  Fix
                        -- me before PR'ing this refactor!
                        mission:setVar(player, 'Option', 1)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET + 7),

            ['Hilda'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(255)
                    end
                end,
            },

            onEventFinish =
            {
                [255] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.WAUGHROON_SHRINE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        player:getLocalVar("battlefieldWin") == 67
                    then
                        npcUtil.giveKeyItem(player, xi.ki.xi.ki.LETTER_FROM_WEREI)
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.BASTOK_MINES] =
        {
            ['Gumbah'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: This logic needs to change, see mission complete note
                    if
                        player:getCharVar("[B7-2]Werei") == 0
                    then
                        return mission:progressEvent(177)
                    end
                end,
            },

            onEventFinish =
            {
                [177] = function(player, csid, option, npc)
                    player:setCharVar("[B7-2]Werei", 1)
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['_6lg'] =
            {
                onTrigger = function(player, npc)
                    -- TODO: This logic needs to change, see mission complete note
                    if player:getCharVar("[B7-2]Cornelia") == 0 then
                        return mission:progressEvent(622)
                    end
                end,
            },

            onEventFinish =
            {
                [622] = function(player, csid, option, npc)
                    player:setCharVar("[B7-2]Cornelia", 1)
                end,
            },
        },
    },

}

return mission
